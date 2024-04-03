// raylib-zig (c) Nikolas Wipper 2020-2024

const std = @import("std");
const builtin = @import("builtin");

const emccOutputDir = "zig-out" ++ std.fs.path.sep_str ++ "htmlout" ++ std.fs.path.sep_str;
const emccOutputFile = "index.html";
pub fn emscriptenRunStep(b: *std.Build) !*std.Build.Step.Run {
    // Find emrun.
    if (b.sysroot == null) {
        @panic("Pass '--sysroot \"[path to emsdk installation]/upstream/emscripten\"'");
    }
    // If compiling on windows , use emrun.bat.
    const emrunExe = switch (builtin.os.tag) {
        .windows => "emrun.bat",
        else => "emrun",
    };
    const emrun_run_arg = try b.allocator.alloc(u8, b.sysroot.?.len + emrunExe.len + 1);
    defer b.allocator.free(emrun_run_arg);

    _ = try std.fmt.bufPrint(emrun_run_arg, "{s}" ++ std.fs.path.sep_str ++ "{s}", .{ b.sysroot.?, emrunExe });

    const run_cmd = b.addSystemCommand(&[_][]const u8{ emrun_run_arg, emccOutputDir ++ emccOutputFile });
    return run_cmd;
}

// Creates the static library to build a project for Emscripten.
pub fn compileForEmscripten(
    b: *std.Build,
    name: []const u8,
    root_source_file: []const u8,
    target: std.zig.CrossTarget,
    optimize: std.builtin.Mode,
) *std.Build.Step.Compile {
    // TODO: It might be a good idea to create a custom compile step, that does
    // both the compile to static library and the link with emcc by overidding
    // the make function of the step. However it might also be a bad idea since
    // it messes with the build system itself.

    const new_target = updateTargetForWeb(target);

    // The project is built as a library and linked later.
    const exe_lib = b.addStaticLibrary(.{
        .name = name,
        .root_source_file = .{ .path = root_source_file },
        .target = new_target,
        .optimize = optimize,
    });

    // There are some symbols that need to be defined in C.
    const webhack_c_file_step = b.addWriteFiles();
    const webhack_c_file = webhack_c_file_step.add("webhack.c", webhack_c);
    exe_lib.addCSourceFile(.{ .file = webhack_c_file, .flags = &[_][]u8{} });
    // Since it's creating a static library, the symbols raylib uses to webgl
    // and glfw don't need to be linked by emscripten yet.
    exe_lib.step.dependOn(&webhack_c_file_step.step);
    return exe_lib;
}

// Links a set of items together using emscripten.
//
// Will accept objects and static libraries as items to link. As for files to
// include, it is recomended to have a single resources directory and just pass
// the entire directory instead of passing every file individually. The entire
// path given will be the path to read the file within the program. So, if
// "resources/image.png" is passed, your program will use "resources/image.png"
// as the path to load the file.
//
// TODO: Test if shared libraries are accepted, I don't remember if emcc can
//       link a shared library with a project or not.
// TODO: Add a parameter that allows a custom output directory.
pub fn linkWithEmscripten(
    b: *std.Build,
    itemsToLink: []const *std.Build.Step.Compile,
) !*std.Build.Step.Run {
    // Raylib uses --sysroot in order to find emscripten, so do the same here.
    if (b.sysroot == null) {
        @panic("Pass '--sysroot \"[path to emsdk installation]/upstream/emscripten\"'");
    }
    const emccExe = switch (builtin.os.tag) {
        .windows => "emcc.bat",
        else => "emcc",
    };
    var emcc_run_arg = try b.allocator.alloc(u8, b.sysroot.?.len + emccExe.len + 1);
    defer b.allocator.free(emcc_run_arg);

    emcc_run_arg = try std.fmt.bufPrint(
        emcc_run_arg,
        "{s}" ++ std.fs.path.sep_str ++ "{s}",
        .{ b.sysroot.?, emccExe },
    );

    // Create the output directory because emcc can't do it.
    const mkdir_command = b.addSystemCommand(&[_][]const u8{ "mkdir", "-p", emccOutputDir });

    // Actually link everything together.
    const emcc_command = b.addSystemCommand(&[_][]const u8{emcc_run_arg});

    for (itemsToLink) |item| {
        emcc_command.addFileArg(item.getEmittedBin());
        emcc_command.step.dependOn(&item.step);
    }
    // This puts the file in zig-out/htmlout/index.html.
    emcc_command.step.dependOn(&mkdir_command.step);
    emcc_command.addArgs(&[_][]const u8{
        "-o",
        emccOutputDir ++ emccOutputFile,
        "-sFULL-ES3=1",
        "-sUSE_GLFW=3",
        "-sASYNCIFY",
        "-O3",
        "--emrun",
    });
    return emcc_command;
}

// TODO: See if zig's standard library already has somehing like this.
fn lastIndexOf(string: []const u8, character: u8) usize {
    // Interestingly, Zig has no nice way of iterating a slice backwards.
    for (0..string.len) |i| {
        const index = string.len - i - 1;
        if (string[index] == character) return index;
    }
    return string.len - 1;
}
// TODO: each zig update, remove this and see if everything still works.
// https://github.com/ziglang/zig/issues/16776 is where the issue is submitted.
fn updateTargetForWeb(target: std.zig.CrossTarget) std.zig.CrossTarget {
    // Zig building to emscripten doesn't work, because the Zig standard library
    // is missing some things in the C system. "std/c.zig" is missing fd_t,
    // which causes compilation to fail. So build to wasi instead, until it gets
    // fixed.
    return std.zig.CrossTarget{
        .cpu_arch = target.cpu_arch,
        .cpu_model = target.cpu_model,
        .cpu_features_add = target.cpu_features_add,
        .cpu_features_sub = target.cpu_features_sub,
        .os_tag = .wasi,
        .os_version_min = target.os_version_min,
        .os_version_max = target.os_version_max,
        .glibc_version = target.glibc_version,
        .abi = target.abi,
        .dynamic_linker = target.dynamic_linker,
        .ofmt = target.ofmt,
    };
}
const webhack_c =
    \\// Zig adds '__stack_chk_guard', '__stack_chk_fail', and 'errno',
    \\// which emscripten doesn't actually support.
    \\// Seems that zig ignores disabling stack checking,
    \\// and I honestly don't know why emscripten doesn't have errno.
    \\// TODO: when the updateTargetForWeb workaround gets removed, see if those are nessesary anymore
    \\#include <stdint.h>
    \\uintptr_t __stack_chk_guard;
    \\//I'm not certain if this means buffer overflows won't be detected,
    \\// However, zig is pretty safe from those, so don't worry about it too much.
    \\void __stack_chk_fail(void){}
    \\int errno;
;

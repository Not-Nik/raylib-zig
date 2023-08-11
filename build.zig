// raylib-zig (c) Nikolas Wipper 2020-2023

const std = @import("std");
const rl = @This();
const builtin = @import("builtin");

const Program = struct {
    name: []const u8,
    path: []const u8,
    desc: []const u8,
};

pub fn link(b: *std.Build, exe: *std.Build.Step.Compile, target: std.zig.CrossTarget, optimize: std.builtin.Mode) void {
    const raylib = b.dependency("raylib", .{
        .target = target,
        .optimize = optimize,
    });
    var art = raylib.artifact("raylib");

    const target_os = exe.target.toTarget().os.tag;
    switch (target_os) {
        .windows => {
            exe.linkSystemLibrary("winmm");
            exe.linkSystemLibrary("gdi32");
            exe.linkSystemLibrary("opengl32");
        },
        .macos => {
            exe.linkFramework("OpenGL");
            exe.linkFramework("Cocoa");
            exe.linkFramework("IOKit");
            exe.linkFramework("CoreAudio");
            exe.linkFramework("CoreVideo");
        },
        .freebsd, .openbsd, .netbsd, .dragonfly => {
            exe.linkSystemLibrary("GL");
            exe.linkSystemLibrary("rt");
            exe.linkSystemLibrary("dl");
            exe.linkSystemLibrary("m");
            exe.linkSystemLibrary("X11");
            exe.linkSystemLibrary("Xrandr");
            exe.linkSystemLibrary("Xinerama");
            exe.linkSystemLibrary("Xi");
            exe.linkSystemLibrary("Xxf86vm");
            exe.linkSystemLibrary("Xcursor");
        },
        .emscripten, .wasi => {
            //when using emscripten,
            // the libries don't need to be linked
            // because emscripten is going
            // to do that later.
        },
        else => { // linux and possibly others
            exe.linkSystemLibrary("GL");
            exe.linkSystemLibrary("rt");
            exe.linkSystemLibrary("dl");
            exe.linkSystemLibrary("m");
            exe.linkSystemLibrary("X11");
        },
    }

    exe.linkLibrary(art);
}

pub fn getArtifact(b: *std.Build, target: std.zig.CrossTarget, optimize: std.builtin.Mode) *std.Build.Step.Compile {
    const raylib = b.dependency("raylib", .{
        .target = target,
        .optimize = optimize,
    });

    return raylib.artifact("raylib");
}

//TODO: make these not comptime
pub fn getModule(b: *std.Build, comptime rl_path: []const u8) *std.Build.Module {
    if (b.modules.contains("raylib")) {
        return b.modules.get("raylib").?;
    }
    return b.addModule("raylib", .{ .source_file = .{ .path = rl_path ++ "/lib/raylib-zig.zig" } });
}

pub fn getModuleInternal(b: *std.Build) *std.Build.Module {
    if (b.modules.contains("raylib")) {
        return b.modules.get("raylib").?;
    }
    return b.addModule("raylib", .{ .source_file = .{ .path = "lib/raylib-zig.zig" } });
}

pub const math = struct {
    pub fn getModule(b: *std.Build, comptime rl_path: []const u8) *std.Build.Module {
        var raylib = rl.getModule(b, rl_path);
        return b.addModule("raylib-math", .{ .source_file = .{ .path = rl_path ++ "/lib/raylib-zig-math.zig" }, .dependencies = &.{.{ .name = "raylib-zig", .module = raylib }} });
    }

    fn getModuleInternal(b: *std.Build) *std.Build.Module {
        var raylib = rl.getModuleInternal(b);
        return b.addModule("raylib-math", .{ .source_file = .{ .path = "lib/raylib-zig-math.zig" }, .dependencies = &.{.{ .name = "raylib-zig", .module = raylib }} });
    }
};

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const examples = [_]Program{
        .{
            .name = "basic_window",
            .path = "examples/core/basic_window.zig",
            .desc = "Creates a basic window with text",
        },
        .{
            .name = "input_keys",
            .path = "examples/core/input_keys.zig",
            .desc = "Simple keyboard input",
        },
        .{
            .name = "input_mouse",
            .path = "examples/core/input_mouse.zig",
            .desc = "Simple mouse input",
        },
        .{
            .name = "input_mouse_wheel",
            .path = "examples/core/input_mouse_wheel.zig",
            .desc = "Mouse wheel input",
        },
        .{
            .name = "input_multitouch",
            .path = "examples/core/input_multitouch.zig",
            .desc = "Multitouch input",
        },
        .{
            .name = "2d_camera",
            .path = "examples/core/2d_camera.zig",
            .desc = "Shows the functionality of a 2D camera",
        },
        .{
            .name = "3d_camera_first_person",
            .path = "examples/core/3d_camera_first_person.zig",
            .desc = "Simple first person demo",
        },
        .{
            .name = "texture_outline",
            .path = "examples/shaders/texture_outline.zig",
            .desc = "Uses a shader to create an outline around a sprite",
        },
        .{
            .name = "logo_raylib",
            .path = "examples/shapes/logo_raylib.zig",
            .desc = "Renders the raylib-zig logo",
        },
        .{
            .name = "sprite_anim",
            .path = "examples/textures/sprite_anim.zig",
            .desc = "Animate a sprite",
        },
        // .{
        //     .name = "models_loading",
        //     .path = "examples/models/models_loading.zig",
        //     .desc = "Loads a model and renders it",
        // },
        // .{
        //     .name = "shaders_basic_lighting",
        //     .path = "examples/shaders/shaders_basic_lighting.zig",
        //     .desc = "Loads a model and renders it",
        // },
    };

    const examples_step = b.step("examples", "Builds all the examples");
    const system_lib = b.option(bool, "system-raylib", "link to preinstalled raylib libraries") orelse false;
    _ = system_lib;

    var raylib = rl.getModuleInternal(b);
    var raylib_math = rl.math.getModuleInternal(b);

    for (examples) |ex| {
        //If compiling for emscripten, things need to be done COMPLETELY differently
        if (target.getOsTag() == .emscripten) {
            var build_step = try buildForEmscripten(b, ex.name, ex.path, target, optimize, raylib, raylib_math);
            var emrun_step = try emscriptenRunStep(b);
            emrun_step.step.dependOn(&build_step.step);
            var run_step = b.step(ex.name, ex.desc);
            run_step.dependOn(&emrun_step.step);
            //examples_step.dependOn(&build_step.step);
            continue;
        }

        const exe = b.addExecutable(.{ .name = ex.name, .root_source_file = .{ .path = ex.path }, .optimize = optimize, .target = target });
        rl.link(b, exe, target, optimize);
        exe.addModule("raylib", raylib);
        exe.addModule("raylib-math", raylib_math);
        const run_cmd = b.addRunArtifact(exe);
        const run_step = b.step(ex.name, ex.desc);
        run_step.dependOn(&run_cmd.step);
        examples_step.dependOn(&exe.step);
    }
}

pub fn emscriptenRunStep(b: *std.Build) !*std.Build.Step.Run {
    //find emrun
    if (b.sysroot == null) {
        @panic("Pass '--sysroot \"[path to emsdk installation]/upstream/emscripten\"'");
    }
    //If compiling on windows , use emrun.bat
    const emrunExe = switch (builtin.os.tag) {
        .windows => "emrun.bat",
        else => "emrun",
    };
    const emrun_run_arg = try b.allocator.alloc(u8, b.sysroot.?.len + emrunExe.len + 1);
    defer b.allocator.free(emrun_run_arg);

    _ = try std.fmt.bufPrint(emrun_run_arg, "{s}" ++ std.fs.path.sep_str ++ "{s}", .{ b.sysroot.?, emrunExe });

    const run_cmd = b.addSystemCommand(&[_][]const u8{ emrun_run_arg, "zig-out" ++ std.fs.path.sep_str ++ "htmlout" ++ std.fs.path.sep_str ++ "index.html" });
    return run_cmd;
}

pub fn buildForEmscripten(b: *std.Build, name: []const u8, root_source_file: []const u8, target: std.zig.CrossTarget, optimize: std.builtin.Mode, raylib: *std.Build.Module, raylib_math: *std.Build.Module) !*std.Build.Step.Run {
    const new_target = updateTargetForWeb(target);
    // Emscripten is completely unable to find Zig's entry point.
    // Solution: create a C compatible entry point in zig,
    // and then a C file that calls that entry point in the main method.
    // The C file is pre-written into the project,
    // However since the zig file needs to @import the main project,
    // it needs to be generated at compile time,
    // and it needs to be in the project's source.

    //TODO: find a way to create a C-compatible entrypoint without doing this

    //Figure out where to write the file
    //TODO: This does mean that building all of the examples at once would cause them to clash,
    // However for now that is not a problem
    const zig_entrypoint_dir = root_source_file[0..lastIndexOf(root_source_file, '/')];
    const zig_entrypoint_file = try b.allocator.alloc(u8, zig_entrypoint_dir.len + "/web_emscripten_entry_point.zig".len);
    _ = try std.fmt.bufPrint(zig_entrypoint_file, "{s}{s}", .{ zig_entrypoint_dir, "/web_emscripten_entry_point.zig" });

    //create the file
    const zig_entrypoint_format =
        \\//This file is generated in order to allow web builds to start properly. It can safely be deleted.
        \\const main = @import("{s}");
        \\const std = @import("std");
        \\export fn web_emscripten_entry_point() c_int
        \\{{
        \\    main.main() catch |e| {{
        \\        //Since emscripten isn't going to get the stack trace,
        \\        // it needs to be printed elsewhere
        \\        const writer = std.io.getStdErr().writer();
        \\                //TODO: It seems zig doesn't put error info into wasm binaries: https://github.com/ziglang/zig/issues/10426
        \\                // So this always returns null.
        \\                // if (@errorReturnTrace()) |trace| {{
        \\                //     trace.format("{{s}}", .{{}}, writer);
        \\                // }}
        \\                // I'm not really worried since web outputs are usually reserved for release anyway, which by then most errors should be fixed.
        \\        writer.print("THERE WAS AN ERROR:{{s}}\n", .{{@errorName(e)}}) catch {{}};
        \\    }};
        \\    return 0;
        \\}}
    ;
    const zig_entrypoint_buffer = try b.allocator.alloc(u8, zig_entrypoint_format.len + root_source_file.len + 1);
    const root_source_file_name = root_source_file[(lastIndexOf(root_source_file, '/') + 1)..];
    const zig_entrypoint_code = try std.fmt.bufPrint(zig_entrypoint_buffer, zig_entrypoint_format, .{root_source_file_name});

    const write_zig_entrypoint = b.addWriteFiles();
    write_zig_entrypoint.addBytesToSource(zig_entrypoint_code, zig_entrypoint_file);

    //create the entrypoint C file - unlike the zig file, this can be placed anywhere, so it goes into the cache
    // It's worth noting that this also defines some symbols that zig adds for wasi that emscripten doesn't support.
    const webhack_c_file_step = b.addWriteFiles();
    const webhack_c_file = webhack_c_file_step.add("webhack.c", webhack_c);

    //Emcc has to be the one that links the project, in order to make sure that the web libraries are correctly linked.
    if (b.sysroot == null) {
        @panic("Pass '--sysroot \"[path to emsdk installation]/upstream/emscripten\"'");
    }
    //the project is built as a library and linked later
    const exe_lib = b.addStaticLibrary(.{ .name = name, .root_source_file = .{ .path = zig_entrypoint_file }, .target = new_target, .optimize = optimize });
    const cache_include = std.fs.path.join(b.allocator, &.{ b.sysroot.?, "cache", "sysroot", "include" }) catch @panic("Out of memory");
    defer b.allocator.free(cache_include);
    exe_lib.addCSourceFile(.{ .file = webhack_c_file, .flags = &[_][]u8{} });
    const raylib_artifact = getArtifact(b, target, optimize);
    //Since it's creating a static library, the symbols raylib uses to webgl and glfw don't need to be linked by emscripten yet.
    exe_lib.linkLibrary(raylib_artifact);
    exe_lib.addModule("raylib", raylib);
    exe_lib.addModule("raylib-math", raylib_math);
    exe_lib.step.dependOn(&write_zig_entrypoint.step);
    exe_lib.step.dependOn(&webhack_c_file_step.step);
    exe_lib.step.dependOn(&raylib_artifact.step);

    //If compiling on windows , use emcc.bat
    const emccExe = switch (builtin.os.tag) {
        .windows => "emcc.bat",
        else => "emcc",
    };
    var emcc_run_arg = try b.allocator.alloc(u8, b.sysroot.?.len + emccExe.len + 1);
    defer b.allocator.free(emcc_run_arg);

    emcc_run_arg = try std.fmt.bufPrint(emcc_run_arg, "{s}" ++ std.fs.path.sep_str ++ "{s}", .{ b.sysroot.?, emccExe });

    //create the output directory because emcc can't do it.
    const mkdir_command = b.addSystemCommand(&[_][]const u8{ "mkdir", "-p", "zig-out" ++ std.fs.path.sep_str ++ "htmlout" ++ std.fs.path.sep_str });
    //Actually link everything together
    const emcc_command = b.addSystemCommand(&[_][]const u8{emcc_run_arg});
    emcc_command.addFileArg(raylib_artifact.getEmittedBin());
    emcc_command.addFileArg(exe_lib.getEmittedBin());
    //TODO: This does mean that building all of the examples at once would cause them to clash,
    // However for now that is not a problem
    emcc_command.addArgs(&[_][]const u8{ "-o", "zig-out" ++ std.fs.path.sep_str ++ "htmlout" ++ std.fs.path.sep_str ++ "index.html", "-sFULL-ES3=1", "-sUSE_GLFW=3", "-sASYNCIFY", "-O3" });
    emcc_command.step.dependOn(&exe_lib.step);
    emcc_command.step.dependOn(&raylib_artifact.step);
    emcc_command.step.dependOn(&mkdir_command.step);

    return emcc_command;
}

//TODO: see if zig's standard library already has somehing like this
fn lastIndexOf(string: []const u8, character: u8) usize {
    //interestingly, zig has no nice way of iterating a slice backwards
    for (0..string.len) |i| {
        const index = string.len - i - 1;
        if (string[index] == character) return index;
    }
    return string.len - 1;
}
// TODO: each zig update, remove this and see if everything still works.
// https://github.com/ziglang/zig/issues/16776 is where the issue is submitted
fn updateTargetForWeb(target: std.zig.CrossTarget) std.zig.CrossTarget {
    //zig building to emscripten doesn't work, because the zig standard library is missing some things in the C system.
    // "std/c.zig" is missing fd_t, which causes compilation to fail.
    // So build to wasi instead, until it gets fixed.
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

pub fn webExport(b: *std.Build, root_source_file: []const u8, comptime rl_path: []const u8, optimize: std.builtin.OptimizeMode) !*std.Build.Step {
    const target = try std.zig.CrossTarget.parse(.{ .arch_os_abi = "wasm32-emscripten" });
    var raylib = rl.getModule(b, rl_path);
    var raylib_math = rl.math.getModule(b, rl_path);
    //Note: the name doesn't matter, it's only used as the file name of a temporary object, so it's just called "project"
    const build_step = try buildForEmscripten(b, "project", root_source_file, target, optimize, raylib, raylib_math);
    const run_step = try emscriptenRunStep(b);
    run_step.step.dependOn(&build_step.step);
    const run_step_arg = b.step("run", "This only exists because the run step for web exports is different");
    run_step_arg.dependOn(&run_step.step);
    return &build_step.step;
}
const webhack_c =
    \\// Emscripten is completely unable to find Zig's entry point.
    \\// Solution: create a C compatible entry point in zig,
    \\// and then a C file that calls that entry point in the main method
    \\// This is that C file.
    \\#include <stdio.h>
    \\//The entry point found in the zig project
    \\extern int web_emscripten_entry_point();
    \\//this is the method that emscripten calls automatically when the page loads
    \\int main(int argc, char** argv)
    \\{
    \\    //TODO: possibly pass arguments into zig?
    \\    int status = web_emscripten_entry_point();
    \\    //emscripten won't print until a newline is formed, and often people forget the last "\n" of a print.
    \\    // Missing lines can be really annoying, so to avoid that one last line is printed before the program exits.
    \\    printf("\n");
    \\    return status;
    \\}
    \\// Zig adds '__stack_chk_guard', '__stack_chk_fail', and 'errno',
    \\// which emscripten doesn't actually support.
    \\// Seems that zig ignores disabling stack checking,
    \\// and I honestly don't know why emscripten doesn't have errno.
    \\// TODO: when the updateTargetForWeb workaround gets removed, see if those are nessesary anymore
    \\// there's a solution, although it's not a good one...
    \\#include <stdint.h>
    \\uintptr_t __stack_chk_guard;
    \\//Yes, this means that if there is a buffer overflow, nobody is going to know about it.
    \\// However, zig is pretty safe from those, so don't worry about it too much.
    \\void __stack_chk_fail(void){}
    \\int errno;
;

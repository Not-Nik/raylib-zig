const std = @import("std");

pub fn addRaygui(b: *std.build.Builder, target: std.zig.CrossTarget) *std.build.LibExeObjStep {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const raygui = b.addStaticLibrary("raygui", srcdir ++ "/raygui.h");
    raygui.setTarget(target);
    raygui.setBuildMode(mode);
    // Make raylib.h available for import to raygui.h
    raygui.addIncludePath("raylib/src");
    raygui.linkLibC();

    const raylib_flags = &[_][]const u8{
        "-std=gnu99",
        "-DPLATFORM_DESKTOP",
        "-DGL_SILENCE_DEPRECATION=199309L",
        "-fno-sanitize=undefined", // https://github.com/raysan5/raylib/issues/1891
    };
    raygui.addCSourceFiles(&.{
        srcdir ++ "/raygui.c",
    }, raylib_flags);
    raygui.defineCMacroRaw("RAYGUI_IMPLEMENTATION");

    return raygui;
}

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    const lib = addRaygui(b, target);
    lib.setOutputDir(srcdir);
    lib.install();
}

const srcdir = getSrcDir();

fn getSrcDir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

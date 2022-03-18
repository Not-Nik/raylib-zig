const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;
const rl = @import("raylib/src/build.zig");

var ran_git = false;
const srcdir = getSrcDir();

fn getSrcDir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub fn link(exe: *LibExeObjStep, system_lib: bool) void {
    if (system_lib) {
        exe.linkSystemLibrary("raylib");
        return;
    } else {
        exe.linkLibrary(rl.addRaylib(exe.builder, exe.target));
    }

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
        else => { // linux and possibly others
            exe.linkSystemLibrary("GL");
            exe.linkSystemLibrary("rt");
            exe.linkSystemLibrary("dl");
            exe.linkSystemLibrary("m");
            exe.linkSystemLibrary("X11");
        },
    }
}

pub fn addAsPackage(name: []const u8, to: *LibExeObjStep) void {
    to.addPackagePath(name, srcdir ++ "/lib/raylib-zig.zig");
}
pub const math = struct {
    pub fn addAsPackage(name: []const u8, to: *LibExeObjStep) void {
        to.addPackagePath(name, srcdir ++ "/lib/raylib-zig-math.zig");
    }
};

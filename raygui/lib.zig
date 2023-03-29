const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;
const rayguiBuild = @import("build.zig");

const srcdir = getSrcDir();

fn getSrcDir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub fn link(exe: *LibExeObjStep) void {
    exe.linkLibrary(rayguiBuild.addRaygui(exe.builder, exe.target));
}

pub fn addAsPackage(name: []const u8, to: *LibExeObjStep) void {
    to.defineCMacroRaw("RAYGUI_IMPLEMENTATION");
    to.addPackagePath(name, "lib/raygui-zig.zig");
}

//
// build
// Zig version: 0.5.0
// Author: Nikolas Wipper
// Date: 2020-02-15
//

const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void
{
    const mode = b.standardReleaseOptions();
    const lib = b.addStaticLibrary("raylib-zig", "lib/raylib-zig.zig");
    lib.setBuildMode(mode);
    lib.linkSystemLibrary("raylib");
    lib.install();

    var basicWindow = b.addExecutable("BasicWindow", "examples/core/BasicWindow.zig");
    basicWindow.setBuildMode(mode);

    const example_step = b.step("basicWindow", "Creates a basic window and text");
    example_step.dependOn(&basicWindow.step);
}

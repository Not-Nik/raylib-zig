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

    var basicWindow = b.addExecutable("BasicWindow", "examples/core/BasicWindow.zig");
    basicWindow.setBuildMode(mode);
    basicWindow.linkSystemLibrary("raylib");
    basicWindow.addPackagePath("raylib", "lib/raylib-zig.zig");

    const examplesStep = b.step("examples", "Builds all the examples");
    examplesStep.dependOn(&basicWindow.step);

    const runBasicWindow = basicWindow.run();
    runBasicWindow.step.dependOn(b.getInstallStep());
    const basicWindowStep = b.step("basic_window", "Creates a basic window with text");
    basicWindowStep.dependOn(&runBasicWindow.step);
}

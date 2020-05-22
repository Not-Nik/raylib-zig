//
// build
// Zig version: 0.6.0
// Author: Nikolas Wipper
// Date: 2020-02-15
//

const std = @import("std");
const Builder = std.build.Builder;

pub fn createExe(b: *Builder, name: []const u8, source: []const u8, desc: []const u8) *std.build.LibExeObjStep
{
    const mode = b.standardReleaseOptions();

    var exe = b.addExecutable(name, source);
    exe.setBuildMode(mode);
    exe.linkSystemLibrary("raylib");
    exe.addCSourceFile("lib/workaround.c", &[_][]const u8{});
    exe.addPackagePath("raylib", "lib/raylib-zig.zig");
    exe.addPackagePath("raylib-math", "lib/raylib-zig-math.zig");

    const runExe = exe.run();
    const exeStep = b.step(name, desc);
    exeStep.dependOn(&runExe.step);
    return exe;
}

pub fn build(b: *Builder) void
{
    var basicWindow     = createExe(b, "basic_window"     , "examples/core/basic_window.zig"     , "Creates a basic window with text");
    var inputKeys       = createExe(b, "input_keys"       , "examples/core/input_keys.zig"       , "Simple keyboard input");
    var inputMouse      = createExe(b, "input_mouse"      , "examples/core/input_mouse.zig"      , "Simple mouse input");
    var inputMouseWheel = createExe(b, "input_mouse_wheel", "examples/core/input_mouse_wheel.zig", "Mouse wheel input");
    var inputMultitouch = createExe(b, "input_multitouch" , "examples/core/input_multitouch.zig" , "Multitouch input");
    var twoDCamera      = createExe(b, "2d_camera"        , "examples/core/2d_camera.zig"        , "Shows the functionality of a 2D camera");
    var modelsLoading   = createExe(b, "models_loading"   , "examples/models/models_loading.zig" , "Loads a model and renders it");
    var mouseRay        = createExe(b, "draw_2d"          , "tests/draw_2d.zig"                  , "Testing workaround on 2D drawing functions");
    var drawSphere      = createExe(b, "draw_sphere"      , "tests/draw_sphere.zig"              , "Testing workaround on DrawSphere");
    var delExitKey      = createExe(b, "del_exit_key"     , "tests/del_exit_key.zig"             , "Testing disabling of exit key");

    const examplesStep = b.step("examples", "Builds all the examples");
          examplesStep.dependOn(&basicWindow.step);
          examplesStep.dependOn(&inputKeys.step);
          examplesStep.dependOn(&inputMouse.step);
          examplesStep.dependOn(&inputMouseWheel.step);
          examplesStep.dependOn(&inputMultitouch.step);
          examplesStep.dependOn(&twoDCamera.step);
          examplesStep.dependOn(&modelsLoading.step);
}

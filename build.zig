//
// build
// Zig version: 0.6.0
// Author: Nikolas Wipper
// Date: 2020-02-15
//

const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void
{
    const mode = b.standardReleaseOptions();

    var basicWindow = b.addExecutable("basic_window", "examples/core/basic_window.zig");
        basicWindow.setBuildMode(mode);
        basicWindow.linkSystemLibrary("raylib");
        basicWindow.addPackagePath("raylib", "lib/raylib-zig.zig");

    var inputKeys = b.addExecutable("input_keys", "examples/core/input_keys.zig");
        inputKeys.setBuildMode(mode);
        inputKeys.linkSystemLibrary("raylib");
        inputKeys.addPackagePath("raylib", "lib/raylib-zig.zig");

    var inputMouse = b.addExecutable("input_mouse", "examples/core/input_mouse.zig");
        inputMouse.setBuildMode(mode);
        inputMouse.linkSystemLibrary("raylib");
        inputMouse.addPackagePath("raylib", "lib/raylib-zig.zig");

    var inputMouseWheel = b.addExecutable("input_mouse_wheel", "examples/core/input_mouse_wheel.zig");
        inputMouseWheel.setBuildMode(mode);
        inputMouseWheel.linkSystemLibrary("raylib");
        inputMouseWheel.addPackagePath("raylib", "lib/raylib-zig.zig");

    var inputMultitouch = b.addExecutable("input_multitouch", "examples/core/input_multitouch.zig");
        inputMultitouch.setBuildMode(mode);
        inputMultitouch.linkSystemLibrary("raylib");
        inputMultitouch.addPackagePath("raylib", "lib/raylib-zig.zig");

    var twoDCamera = b.addExecutable("2d_camera", "examples/core/2d_camera.zig");
        twoDCamera.setBuildMode(mode);
        twoDCamera.linkSystemLibrary("raylib");
        twoDCamera.addPackagePath("raylib", "lib/raylib-zig.zig");
        twoDCamera.addPackagePath("raylib-math", "lib/raylib-zig-math.zig");

    var modelsLoading = b.addExecutable("models_loading", "examples/models/models_loading.zig");
        modelsLoading.setBuildMode(mode);
        modelsLoading.linkSystemLibrary("raylib");
        modelsLoading.addPackagePath("raylib", "lib/raylib-zig.zig");

    const examplesStep = b.step("examples", "Builds all the examples");
          examplesStep.dependOn(&basicWindow.step);
          examplesStep.dependOn(&inputKeys.step);
          examplesStep.dependOn(&inputMouse.step);
          examplesStep.dependOn(&inputMouseWheel.step);
          examplesStep.dependOn(&inputMultitouch.step);
          examplesStep.dependOn(&twoDCamera.step);
          examplesStep.dependOn(&modelsLoading.step);

    const runBasicWindow = basicWindow.run();
    const basicWindowStep = b.step("basic_window", "Creates a basic window with text");
          basicWindowStep.dependOn(&runBasicWindow.step);

    const runInputKeys = inputKeys.run();
    const inputKeysStep = b.step("input_keys", "Simple keyboard input");
          inputKeysStep.dependOn(&runInputKeys.step);

    const runInputMouse = inputMouse.run();
    const inputMouseStep = b.step("input_mouse", "Simple mouse input");
          inputMouseStep.dependOn(&runInputMouse.step);

    const runInputMouseWheel = inputMouseWheel.run();
    const inputMouseWheelStep = b.step("input_mouse_wheel", "Mouse wheel input");
          inputMouseWheelStep.dependOn(&runInputMouseWheel.step);

    const runInputMultitouch = inputMultitouch.run();
    const inputMultitouchStep = b.step("input_multitouch", "Multitouch (duh)");
          inputMultitouchStep.dependOn(&runInputMultitouch.step);

    const run2DCamera = twoDCamera.run();
    const twoDCameraStep = b.step("2d_camera", "Shows the functionality of a 2D camera");
          twoDCameraStep.dependOn(&run2DCamera.step);

    const runModelsLoading= modelsLoading.run();
    const modelsLoadingStep = b.step("models_loading", "Loads a model and renders it");
          modelsLoadingStep.dependOn(&runModelsLoading.step);
}

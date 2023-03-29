const std = @import("std");
const rl = @import("raylib");
const rlm = @import("raylib-math");
const rg = @import("raygui");

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 800;

    rl.InitWindow(screenWidth, screenHeight, "raylib [button] example");
    rl.SetTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
    // Main game loop
    while (!rl.WindowShouldClose()) // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------

        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();
        rl.ClearBackground(rl.RAYWHITE);
        if (rg.GuiButton(.{ .x = -60 + screenWidth / 2, .y = -15 + screenHeight / 2, .width = 120, .height = 30 }, "Button")) {
            std.debug.print("Button Pressed!\n", .{});
        }
        rl.EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------

    rl.CloseWindow(); // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

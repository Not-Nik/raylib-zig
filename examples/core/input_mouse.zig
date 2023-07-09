// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.InitWindow(screenWidth, screenHeight, "raylib-zig [core] example - mouse input");

    var ballPosition = rl.Vector2{ .x = -100.0, .y = -100.0 };
    var ballColor = rl.DARKBLUE;

    rl.SetTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.WindowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        ballPosition = rl.GetMousePosition();
        ballPosition.x = @as(f32, @floatFromInt(rl.GetMouseX()));
        ballPosition.y = @as(f32, @floatFromInt(rl.GetMouseY()));

        if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_BUTTON_LEFT)) {
            ballColor = rl.MAROON;
        } else if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_BUTTON_MIDDLE)) {
            ballColor = rl.LIME;
        } else if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_BUTTON_RIGHT)) {
            ballColor = rl.DARKBLUE;
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();

        rl.ClearBackground(rl.RAYWHITE);

        rl.DrawCircle(@as(c_int, @intFromFloat(ballPosition.x)), @as(c_int, @intFromFloat(ballPosition.y)), 50, ballColor);
        //DrawCircleV(ballPosition, 40, ballColor);

        rl.DrawText("move ball with mouse and click mouse button to change color", 10, 10, 20, rl.DARKGRAY);

        rl.EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.CloseWindow(); // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

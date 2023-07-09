// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.InitWindow(screenWidth, screenHeight, "raylib-zig [core] example - mouse input");

    var ballPosition = rl.Vector2.init(-100, -100);
    var ballColor = rl.Color.DARKBLUE;

    rl.SetTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.WindowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        ballPosition = rl.GetMousePosition();
        ballPosition.x = @intToFloat(f32, rl.GetMouseX());
        ballPosition.y = @intToFloat(f32, rl.GetMouseY());

        if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_BUTTON_LEFT)) {
            ballColor = rl.Color.MAROON;
        } else if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_BUTTON_MIDDLE)) {
            ballColor = rl.Color.LIME;
        } else if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_BUTTON_RIGHT)) {
            ballColor = rl.Color.DARKBLUE;
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();

        rl.ClearBackground(rl.Color.RAYWHITE);

        rl.DrawCircle(@floatToInt(c_int, ballPosition.x), @floatToInt(c_int, ballPosition.y), 50, ballColor);
        //DrawCircleV(ballPosition, 40, ballColor);

        rl.DrawText("move ball with mouse and click mouse button to change color", 10, 10, 20, rl.Color.DARKGRAY);

        rl.EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.CloseWindow(); // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

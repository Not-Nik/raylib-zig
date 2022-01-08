//
// input_mouse
// Zig version: 
// Author: Nikolas Wipper
// Date: 2020-02-16
//

const rl = @import("raylib");

pub fn main() anyerror!void
{
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.InitWindow(screenWidth, screenHeight, "raylib-zig [core] example - mouse input");

    var ballPosition = rl.Vector2 { .x = -100.0, .y = -100.0 };
    var ballColor = rl.DARKBLUE;

    rl.SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.WindowShouldClose())   // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        ballPosition = rl.GetMousePosition();
        ballPosition.x = @intToFloat(f32, rl.GetMouseX());
        ballPosition.y = @intToFloat(f32, rl.GetMouseY());

        if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_LEFT_BUTTON)) { ballColor = rl.MAROON; }
        else if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_MIDDLE_BUTTON)) { ballColor = rl.LIME; }
        else if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_RIGHT_BUTTON)) { ballColor = rl.DARKBLUE; }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();

            rl.ClearBackground(rl.RAYWHITE);

            rl.DrawCircle(@floatToInt(c_int, ballPosition.x), @floatToInt(c_int, ballPosition.y), 50, ballColor);
            //DrawCircleV(ballPosition, 40, ballColor);

            rl.DrawText("move ball with mouse and click mouse button to change color", 10, 10, 20, rl.DARKGRAY);

        rl.EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}


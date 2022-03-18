//
// input_multitouch
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

    rl.InitWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");

    var ballPosition = rl.Vector2 { .x = -100.0, .y = -100.0 };
    var ballColor = rl.BEIGE;

    var touchCounter: f32 = 0;
    var touchPosition = rl.Vector2 { .x = 0.0, .y = 0.0 };

    rl.SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        ballPosition = rl.GetMousePosition();

        ballColor = rl.BEIGE;

        if (rl.IsMouseButtonDown(rl.MouseButton.MOUSE_LEFT_BUTTON)) { ballColor = rl.MAROON; }
        if (rl.IsMouseButtonDown(rl.MouseButton.MOUSE_MIDDLE_BUTTON)) { ballColor = rl.LIME; }
        if (rl.IsMouseButtonDown(rl.MouseButton.MOUSE_RIGHT_BUTTON)) { ballColor = rl.DARKBLUE; }

        if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_LEFT_BUTTON)) { touchCounter = 10; }
        if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_MIDDLE_BUTTON)) { touchCounter = 10; }
        if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_RIGHT_BUTTON)) { touchCounter = 10; }

        if (touchCounter > 0) { touchCounter -= 1; }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();

            rl.ClearBackground(rl.RAYWHITE);

            const nums = [_]i32{0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
            for (nums) |i|
            {
                touchPosition = rl.GetTouchPosition(i);                    // Get the touch point

                if ((touchPosition.x >= 0) and (touchPosition.y >= 0))   // Make sure point is not (-1,-1) as this means there is no touch for it
                {
                    // Draw circle and touch index number
                    rl.DrawCircleV(touchPosition, 34, rl.ORANGE);
                    rl.DrawText(rl.FormatText("%d", i), @floatToInt(c_int, touchPosition.x) - 10, @floatToInt(c_int, touchPosition.y) - 70, 40, rl.BLACK);
                }
            }

            // Draw the normal mouse location
            rl.DrawCircleV(ballPosition, 30 + (touchCounter*3), ballColor);

            rl.DrawText("move ball with mouse and click mouse button to change color", 10, 10, 20, rl.DARKGRAY);
            rl.DrawText("touch the screen at multiple locations to get multiple balls", 10, 30, 20, rl.DARKGRAY);

        rl.EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}


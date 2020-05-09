//
// input_multitouch
// Zig version: 
// Author: Nikolas Wipper
// Date: 2020-02-16
//

usingnamespace @import("raylib");

pub fn main() anyerror!void
{
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");

    var ballPosition = Vector2 { .x = -100.0, .y = -100.0 };
    var ballColor = BEIGE;

    var touchCounter: f32 = 0;
    var touchPosition = Vector2 { .x = 0.0, .y = 0.0 };

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        //ballPosition = GetMousePosition();

        ballColor = BEIGE;

        if (IsMouseButtonDown(MouseButton.MOUSE_LEFT_BUTTON)) { ballColor = MAROON; }
        if (IsMouseButtonDown(MouseButton.MOUSE_MIDDLE_BUTTON)) { ballColor = LIME; }
        if (IsMouseButtonDown(MouseButton.MOUSE_RIGHT_BUTTON)) { ballColor = DARKBLUE; }

        if (IsMouseButtonPressed(MouseButton.MOUSE_LEFT_BUTTON)) { touchCounter = 10; }
        if (IsMouseButtonPressed(MouseButton.MOUSE_MIDDLE_BUTTON)) { touchCounter = 10; }
        if (IsMouseButtonPressed(MouseButton.MOUSE_RIGHT_BUTTON)) { touchCounter = 10; }

        if (touchCounter > 0) { touchCounter -= 1; }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            const nums = [_]i32{0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
            for (nums) |i|
            {
                //touchPosition = GetTouchPosition(i);                    // Get the touch point

                if ((touchPosition.x >= 0) and (touchPosition.y >= 0))   // Make sure point is not (-1,-1) as this means there is no touch for it
                {
                    // Draw circle and touch index number
                    DrawCircleV(touchPosition, 34, ORANGE);
                    DrawText(FormatText("%d", i), @floatToInt(c_int, touchPosition.x) - 10, @floatToInt(c_int, touchPosition.y) - 70, 40, BLACK);
                }
            }

            // Draw the normal mouse location
            DrawCircleV(ballPosition, 30 + (touchCounter*3), ballColor);

            DrawText("move ball with mouse and click mouse button to change color", 10, 10, 20, DARKGRAY);
            DrawText("touch the screen at multiple locations to get multiple balls", 10, 30, 20, DARKGRAY);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}


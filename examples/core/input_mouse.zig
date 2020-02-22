//
// input_mouse
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

    InitWindow(screenWidth, screenHeight, c"raylib-zig [core] example - mouse input");

    var ballPosition = Vector2 { .x = -100.0, .y = -100.0 };
    var ballColor = DARKBLUE;

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        ballPosition = GetMousePosition();

        if (IsMouseButtonPressed(MouseButton.MOUSE_LEFT_BUTTON)) { ballColor = MAROON; }
        else if (IsMouseButtonPressed(MouseButton.MOUSE_MIDDLE_BUTTON)) { ballColor = LIME; }
        else if (IsMouseButtonPressed(MouseButton.MOUSE_RIGHT_BUTTON)) { ballColor = DARKBLUE; }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawCircle(@floatToInt(c_int, ballPosition.x), @floatToInt(c_int, ballPosition.y), 50, ballColor);
            //DrawCircleV(ballPosition, 40, ballColor);

            DrawText(c"move ball with mouse and click mouse button to change color", 10, 10, 20, DARKGRAY);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}


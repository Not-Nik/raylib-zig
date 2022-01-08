//
// input_mouse_wheel
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

    var boxPositionY: f32 = screenHeight / 2 - 40;
    var scrollSpeed: f32 = 4;            // Scrolling speed in pixels

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        boxPositionY -= (GetMouseWheelMove() * scrollSpeed);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(WHITE);

            DrawRectangle(screenWidth/2 - 40, @floatToInt(c_int, boxPositionY), 80, 80, MAROON);

            DrawText("Use mouse wheel to move the cube up and down!", 10, 10, 20, GRAY);
            DrawText(FormatText("Box position Y: %03i", @floatToInt(c_int, boxPositionY)), 10, 40, 20, LIGHTGRAY);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}


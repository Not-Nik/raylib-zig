//
// input_keys
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

    InitWindow(screenWidth, screenHeight, "raylib-zig [core] example - keyboard input");

    var ballPosition = Vector2 { .x = screenWidth/2, .y = screenHeight/2 };

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        if (IsKeyDown(KeyboardKey.KEY_RIGHT)) { ballPosition.x += 2.0; }
        if (IsKeyDown(KeyboardKey.KEY_LEFT)) { ballPosition.x -= 2.0; }
        if (IsKeyDown(KeyboardKey.KEY_UP)) { ballPosition.y -= 2.0; }
        if (IsKeyDown(KeyboardKey.KEY_DOWN)) { ballPosition.y += 2.0; }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("move the ball with arrow keys", 10, 10, 20, DARKGRAY);

            DrawCircleV(ballPosition, 50, MAROON);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}


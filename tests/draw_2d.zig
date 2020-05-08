//
// mouse_ray
// Zig version: 0.6.0
// Author: Nikolas Wipper
// Date: 2020-02-15
//

usingnamespace @import("raylib");

pub fn main() anyerror!void
{
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "raylib-zig [core] test - draw 2d");

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(WHITE);

            DrawLineV(Vector2{.x=0, .y=0}, Vector2{.x=100, .y=100}, RED);
            DrawLineEx(Vector2{.x=10, .y=0}, Vector2{.x=110, .y=100}, 5, RED);
            DrawLineBezier(Vector2{.x=50, .y=0}, Vector2{.x=150, .y=100}, 5, RED);
            DrawLineStrip(&[_]Vector2{ Vector2{.x=100, .y=0}, Vector2{.x=160, .y=40}, Vector2{.x=200, .y=100} }, 3, RED);
            // TODO: More testing on all the functions
            // I'm just getting everything is fine, but you never know

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}


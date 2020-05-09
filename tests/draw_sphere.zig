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

    InitWindow(screenWidth, screenHeight, "raylib-zig [core] example - draw sphere");

    var camera = Camera {
        .position = Vector3 { .x = 0.0, .y = 0.0, .z = 0.0 }, // Camera position
        .target = Vector3 { .x = 0.0, .y = 0.0, .z = 2.0 },   // Camera looking at point
        .up = Vector3 { .x = 0.0, .y = 1.0, .z = 0.0 },       // Camera up vector (rotation towards target)
        .fovy = 80.0,                                         // Camera field-of-view Y
        .type = CameraType.CAMERA_PERSPECTIVE                 // Camera mode type
    };

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(WHITE);

            camera.Begin();

                DrawSphere(Vector3 {.x = 0, .y = 0, . z = 2}, 1, RED);

            camera.End();

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}


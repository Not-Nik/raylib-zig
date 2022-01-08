//
// input_keys
// Zig version: 
// Author: Nikolas Wipper
// Date: 2020-02-16
//

const rl = @import("raylib");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.InitWindow(screenWidth, screenHeight, "raylib-zig [core] example - keyboard input");

    var ballPosition = rl.Vector2 { .x = screenWidth/2, .y = screenHeight/2 };

    rl.SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.WindowShouldClose())   // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        if (rl.IsKeyDown(rl.KeyboardKey.KEY_RIGHT)) { ballPosition.x += 2.0; }
        if (rl.IsKeyDown(rl.KeyboardKey.KEY_LEFT)) { ballPosition.x -= 2.0; }
        if (rl.IsKeyDown(rl.KeyboardKey.KEY_UP)) { ballPosition.y -= 2.0; }
        if (rl.IsKeyDown(rl.KeyboardKey.KEY_DOWN)) { ballPosition.y += 2.0; }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();

            rl.ClearBackground(rl.RAYWHITE);

            rl.DrawText("move the ball with arrow keys", 10, 10, 20, rl.DARKGRAY);

            rl.DrawCircleV(ballPosition, 50, rl.MAROON);

        rl.EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - keyboard input");

    var ballPosition = rl.Vector2.init(screenWidth / 2, screenHeight / 2);

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key

        // Update
        //----------------------------------------------------------------------------------
        if (rl.isKeyDown(rl.KeyboardKey.KEY_RIGHT)) {
            ballPosition.x += 2.0;
        }
        if (rl.isKeyDown(rl.KeyboardKey.KEY_LEFT)) {
            ballPosition.x -= 2.0;
        }
        if (rl.isKeyDown(rl.KeyboardKey.KEY_UP)) {
            ballPosition.y -= 2.0;
        }
        if (rl.isKeyDown(rl.KeyboardKey.KEY_DOWN)) {
            ballPosition.y += 2.0;
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();

        rl.clearBackground(rl.Color.RAYWHITE);

        rl.drawText("move the ball with arrow keys", 10, 10, 20, rl.Color.DARKGRAY);

        rl.drawCircleV(ballPosition, 50, rl.Color.MAROON);

        rl.endDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.closeWindow(); // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

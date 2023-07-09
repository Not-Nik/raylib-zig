// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.InitWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");

    var ballPosition = rl.Vector2.init(-100, -100);
    var ballColor = rl.Color.BEIGE;

    var touchCounter: f32 = 0;
    var touchPosition = rl.Vector2.init(0, 0);

    rl.SetTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.WindowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        ballPosition = rl.GetMousePosition();

        ballColor = rl.Color.BEIGE;

        if (rl.IsMouseButtonDown(rl.MouseButton.MOUSE_BUTTON_LEFT)) {
            ballColor = rl.Color.MAROON;
        }
        if (rl.IsMouseButtonDown(rl.MouseButton.MOUSE_BUTTON_MIDDLE)) {
            ballColor = rl.Color.LIME;
        }
        if (rl.IsMouseButtonDown(rl.MouseButton.MOUSE_BUTTON_RIGHT)) {
            ballColor = rl.Color.DARKBLUE;
        }

        if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_BUTTON_LEFT)) {
            touchCounter = 10;
        }
        if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_BUTTON_MIDDLE)) {
            touchCounter = 10;
        }
        if (rl.IsMouseButtonPressed(rl.MouseButton.MOUSE_BUTTON_RIGHT)) {
            touchCounter = 10;
        }

        if (touchCounter > 0) {
            touchCounter -= 1;
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();

        rl.ClearBackground(rl.Color.RAYWHITE);

        const nums = [_]i32{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
        for (nums) |i| {
            touchPosition = rl.GetTouchPosition(i); // Get the touch point

            // Make sure point is not (-1,-1) as this means there is no touch for it
            if ((touchPosition.x >= 0) and (touchPosition.y >= 0)) {

                // Draw circle and touch index number
                rl.DrawCircleV(touchPosition, 34, rl.Color.ORANGE);
                rl.DrawText(rl.TextFormat("%d", i), @floatToInt(c_int, touchPosition.x) - 10, @floatToInt(c_int, touchPosition.y) - 70, 40, rl.Color.BLACK);
            }
        }

        // Draw the normal mouse location
        rl.DrawCircleV(ballPosition, 30 + (touchCounter * 3), ballColor);

        rl.DrawText("move ball with mouse and click mouse button to change color", 10, 10, 20, rl.Color.DARKGRAY);
        rl.DrawText("touch the screen at multiple locations to get multiple balls", 10, 30, 20, rl.Color.DARKGRAY);

        rl.EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.CloseWindow(); // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

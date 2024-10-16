// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    defer rl.closeWindow(); // Close window and OpenGL context

    var ballPosition = rl.Vector2.init(-100, -100);
    var ballColor = rl.Color.beige;

    var touchCounter: f32 = 0;
    var touchPosition = rl.Vector2.init(0, 0);

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        ballPosition = rl.getMousePosition();

        ballColor = rl.Color.beige;

        if (rl.isMouseButtonDown(rl.MouseButton.mouse_button_left)) {
            ballColor = rl.Color.maroon;
        }
        if (rl.isMouseButtonDown(rl.MouseButton.mouse_button_middle)) {
            ballColor = rl.Color.lime;
        }
        if (rl.isMouseButtonDown(rl.MouseButton.mouse_button_right)) {
            ballColor = rl.Color.dark_blue;
        }

        if (rl.isMouseButtonPressed(rl.MouseButton.mouse_button_left)) {
            touchCounter = 10;
        }
        if (rl.isMouseButtonPressed(rl.MouseButton.mouse_button_middle)) {
            touchCounter = 10;
        }
        if (rl.isMouseButtonPressed(rl.MouseButton.mouse_button_right)) {
            touchCounter = 10;
        }

        if (touchCounter > 0) {
            touchCounter -= 1;
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.ray_white);

        const nums = [_]i32{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
        for (nums) |i| {
            touchPosition = rl.getTouchPosition(i); // Get the touch point

            // Make sure point is not (-1,-1) as this means there is no touch for it
            if ((touchPosition.x >= 0) and (touchPosition.y >= 0)) {

                // Draw circle and touch index number
                rl.drawCircleV(touchPosition, 34, rl.Color.orange);
                rl.drawText(
                    rl.textFormat("%d", .{i}),
                    @as(i32, @intFromFloat(touchPosition.x)) - 10,
                    @as(i32, @intFromFloat(touchPosition.y)) - 70,
                    40,
                    rl.Color.black,
                );
            }
        }

        // Draw the normal mouse location
        rl.drawCircleV(ballPosition, 30 + (touchCounter * 3), ballColor);

        rl.drawText("move ball with mouse and click mouse button to change color", 10, 10, 20, rl.Color.dark_gray);
        rl.drawText("touch the screen at multiple locations to get multiple balls", 10, 30, 20, rl.Color.dark_gray);
        //----------------------------------------------------------------------------------
    }
}

// Port of https://github.com/raysan5/raylib/blob/master/examples/textures/textures_sprite_anim.c to zig

const std = @import("std");
const rl = @import("raylib");

const MAX_FRAME_SPEED = 15;
const MIN_FRAME_SPEED = 1;

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initAudioDevice(); // Initialize audio device
    rl.initWindow(screenWidth, screenHeight, "raylib [texture] example - sprite anim");
    defer rl.closeWindow(); // Close window and OpenGL context

    // NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
    const scarfy: rl.Texture = rl.Texture.init("resources/textures/scarfy.png"); // Texture loading
    defer rl.unloadTexture(scarfy); // Texture unloading

    const position = rl.Vector2.init(350.0, 280.0);
    var frameRec = rl.Rectangle.init(
        0,
        0,
        @as(f32, @floatFromInt(@divFloor(scarfy.width, 6))),
        @as(f32, @floatFromInt(scarfy.height)),
    );
    var currentFrame: u8 = 0;

    var framesCounter: u8 = 0;
    var framesSpeed: u8 = 8; // Number of spritesheet frames shown by second

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        framesCounter += 1;

        if (framesCounter >= (60 / framesSpeed)) {
            framesCounter = 0;
            currentFrame += 1;

            if (currentFrame > 5) currentFrame = 0;

            frameRec.x = @as(f32, @floatFromInt(currentFrame)) * @as(f32, @floatFromInt(@divFloor(scarfy.width, 6)));
        }

        // Control frames speed
        if (rl.isKeyPressed(rl.KeyboardKey.key_right)) {
            framesSpeed += 1;
        } else if (rl.isKeyPressed(rl.KeyboardKey.key_left)) {
            framesSpeed -= 1;
        }

        if (framesSpeed > MAX_FRAME_SPEED) {
            framesSpeed = MAX_FRAME_SPEED;
        } else if (framesSpeed < MIN_FRAME_SPEED) {
            framesSpeed = MIN_FRAME_SPEED;
        }

        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.ray_white);

        rl.drawTexture(scarfy, 15, 40, rl.Color.white);
        rl.drawRectangleLines(15, 40, scarfy.width, scarfy.height, rl.Color.lime);
        rl.drawRectangleLines(
            15 + @as(i32, @intFromFloat(frameRec.x)),
            40 + @as(i32, @intFromFloat(frameRec.y)),
            @as(i32, @intFromFloat(frameRec.width)),
            @as(i32, @intFromFloat(frameRec.height)),
            rl.Color.red,
        );

        rl.drawText("FRAME SPEED: ", 165, 210, 10, rl.Color.dark_gray);
        rl.drawText(rl.textFormat("%02i FPS", .{framesSpeed}), 575, 210, 10, rl.Color.dark_gray);
        rl.drawText("PRESS RIGHT/LEFT KEYS to CHANGE SPEED!", 290, 240, 10, rl.Color.dark_gray);

        for ([_]u32{0} ** MAX_FRAME_SPEED, 0..) |_, i| {
            if (i < framesSpeed) {
                rl.drawRectangle(250 + 21 * @as(i32, @intCast(i)), 205, 20, 20, rl.Color.red);
            }
            rl.drawRectangleLines(250 + 21 * @as(i32, @intCast(i)), 205, 20, 20, rl.Color.maroon);
        }

        scarfy.drawRec(frameRec, position, rl.Color.white); // Draw part of the texture

        rl.drawText(
            "(c) Scarfy sprite by Eiden Marsal",
            screenWidth - 200,
            screenHeight - 20,
            10,
            rl.Color.gray,
        );
        //----------------------------------------------------------------------------------
    }
}

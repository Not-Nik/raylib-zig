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

    rl.InitAudioDevice();      // Initialize audio device
    rl.InitWindow(screenWidth, screenHeight, "raylib [texture] example - sprite anim");

    // NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
    const scarfy: rl.Texture2D = rl.LoadTexture("resources/textures/scarfy.png");  // Texture loading

    const position = rl.Vector2{ .x = 350.0, .y = 280.0 };
    var frameRec = rl.Rectangle{ .x = 0.0, .y = 0.0, .width = @intToFloat(f32, @divFloor(scarfy.width,6)), .height = @intToFloat(f32, scarfy.height) };
    var currentFrame:u8 = 0;

    var framesCounter:u8 = 0;
    var framesSpeed:u8 = 8;            // Number of spritesheet frames shown by second

    rl.SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.WindowShouldClose())   // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        framesCounter += 1;

        if (framesCounter >= (60/framesSpeed))
        {
            framesCounter = 0;
            currentFrame += 1;

            if (currentFrame > 5) currentFrame = 0;

            frameRec.x = @intToFloat(f32,currentFrame)*@intToFloat(f32,@divFloor(scarfy.width,6));
        }

        // Control frames speed
        if (rl.IsKeyPressed(rl.KeyboardKey.KEY_RIGHT)) {framesSpeed+=1;}
        else if (rl.IsKeyPressed(rl.KeyboardKey.KEY_LEFT)) {framesSpeed-=1;}

        if (framesSpeed > MAX_FRAME_SPEED) {framesSpeed = MAX_FRAME_SPEED;}
        else if (framesSpeed < MIN_FRAME_SPEED) {framesSpeed = MIN_FRAME_SPEED;}


        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();

            rl.ClearBackground(rl.RAYWHITE);

            rl.DrawTexture(scarfy, 15, 40, rl.WHITE);
            rl.DrawRectangleLines(15, 40, scarfy.width, scarfy.height, rl.LIME);
            rl.DrawRectangleLines(15 + @floatToInt(i32,frameRec.x), 40 + @floatToInt(i32, frameRec.y), @floatToInt(i32,frameRec.width), @floatToInt(i32,frameRec.height), rl.RED);

            rl.DrawText("FRAME SPEED: ", 165, 210, 10, rl.DARKGRAY);
            rl.DrawText(rl.TextFormat("%02i FPS", framesSpeed), 575, 210, 10, rl.DARKGRAY);
            rl.DrawText("PRESS RIGHT/LEFT KEYS to CHANGE SPEED!", 290, 240, 10, rl.DARKGRAY);

            for ([_]u32{0} ** MAX_FRAME_SPEED) |_, i| {
                if (i < framesSpeed) {rl.DrawRectangle(250 + 21*@intCast(c_int, i), 205, 20, 20, rl.RED);}
                rl.DrawRectangleLines(250 + 21*@intCast(c_int, i), 205, 20, 20, rl.MAROON);
            }

            rl.DrawTextureRec(scarfy, frameRec, position, rl.WHITE);  // Draw part of the texture

            rl.DrawText("(c) Scarfy sprite by Eiden Marsal", screenWidth - 200, screenHeight - 20, 10, rl.GRAY);

        rl.EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.UnloadTexture(scarfy);       // Texture unloading

    rl.CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

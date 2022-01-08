//
// 2d_camera
// Zig version: 
// Author: Nikolas Wipper
// Date: 2020-02-16
//

const rl = @import("raylib");
const rlm = @import("raylib-math");

const MAX_BUILDINGS = 100;

pub fn main() anyerror!void
{
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.InitWindow(screenWidth, screenHeight, "raylib-zig [core] example - 2d camera");

    var player = rl.Rectangle { .x = 400, .y = 280, .width = 40, .height = 40 };
    var buildings: [MAX_BUILDINGS]rl.Rectangle = undefined;
    var buildColors: [MAX_BUILDINGS]rl.Color = undefined;

    var spacing: i32 = 0;

    for (buildings) |_, i|
    {
        buildings[i].width = @intToFloat(f32, rl.GetRandomValue(50, 200));
        buildings[i].height = @intToFloat(f32, rl.GetRandomValue(100, 800));
        buildings[i].y = screenHeight - 130 - buildings[i].height;
        buildings[i].x = @intToFloat(f32, -6000 + spacing);

        spacing += @floatToInt(i32, buildings[i].width);

        buildColors[i] = rl.Color { .r = @intCast(u8, rl.GetRandomValue(200, 240)), .g = @intCast(u8, rl.GetRandomValue(200, 240)),
                                 .b = @intCast(u8, rl.GetRandomValue(200, 250)), .a = 255 };
    }

    var camera = rl.Camera2D {
        .target = rl.Vector2 { .x = player.x + 20, .y = player.y + 20 },
        .offset = rl.Vector2 { .x = screenWidth/2, .y = screenHeight/2 },
        .rotation = 0,
        .zoom = 1,
    };

    rl.SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.WindowShouldClose())   // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------

        // Player movement
        if (rl.IsKeyDown(rl.KeyboardKey.KEY_RIGHT)) { player.x += 2; }
        else if (rl.IsKeyDown(rl.KeyboardKey.KEY_LEFT)) { player.x -= 2; }

        // Camera target follows player
        camera.target = rl.Vector2 { .x = player.x + 20, .y = player.y + 20 };

        // Camera rotation controls
        if (rl.IsKeyDown(rl.KeyboardKey.KEY_A)) { camera.rotation -= 1; }
        else if (rl.IsKeyDown(rl.KeyboardKey.KEY_S)) { camera.rotation += 1; }

        // Limit camera rotation to 80 degrees (-40 to 40)
        camera.rotation = rlm.Clamp(camera.rotation, -40, 40);

        // Camera zoom controls
        camera.zoom += rl.GetMouseWheelMove() * 0.05;

        camera.zoom = rlm.Clamp(camera.zoom, 0.1, 3.0);

        // Camera reset (zoom and rotation)
        if (rl.IsKeyPressed(rl.KeyboardKey.KEY_R))
        {
            camera.zoom = 1.0;
            camera.rotation = 0.0;
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();

            rl.ClearBackground(rl.RAYWHITE);

            camera.Begin();

                rl.DrawRectangle(-6000, 320, 13000, 8000, rl.DARKGRAY);

                for (buildings) |building, i|
                {
                    rl.DrawRectangleRec(building, buildColors[i]);
                }

                rl.DrawRectangleRec(player, rl.RED);

                rl.DrawLine(@floatToInt(c_int, camera.target.x), -screenHeight*10, @floatToInt(c_int, camera.target.x), screenHeight*10, rl.GREEN);
                rl.DrawLine(-screenWidth*10, @floatToInt(c_int, camera.target.y), screenWidth*10, @floatToInt(c_int, camera.target.y), rl.GREEN);

            camera.End();

            rl.DrawText("SCREEN AREA", 640, 10, 20, rl.RED);

            rl.DrawRectangle(0, 0, screenWidth, 5, rl.RED);
            rl.DrawRectangle(0, 5, 5, screenHeight - 10, rl.RED);
            rl.DrawRectangle(screenWidth - 5, 5, 5, screenHeight - 10, rl.RED);
            rl.DrawRectangle(0, screenHeight - 5, screenWidth, 5, rl.RED);

            rl.DrawRectangle( 10, 10, 250, 113, rl.Fade(rl.SKYBLUE, 0.5));
            rl.DrawRectangleLines( 10, 10, 250, 113, rl.BLUE);

            rl.DrawText("Free 2d camera controls:", 20, 20, 10, rl.BLACK);
            rl.DrawText("- Right/Left to move Offset", 40, 40, 10, rl.DARKGRAY);
            rl.DrawText("- Mouse Wheel to Zoom in-out", 40, 60, 10, rl.DARKGRAY);
            rl.DrawText("- A / S to Rotate", 40, 80, 10, rl.DARKGRAY);
            rl.DrawText("- R to reset Zoom and Rotation", 40, 100, 10, rl.DARKGRAY);

        rl.EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

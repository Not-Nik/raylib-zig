//
// 2d_camera
// Zig version: 
// Author: Nikolas Wipper
// Date: 2020-02-16
//

usingnamespace @import("raylib");
usingnamespace @import("raylib-math");

const MAX_BUILDINGS = 100;

pub fn main() anyerror!void
{
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "raylib-zig [core] example - 2d camera");

    var player = Rectangle { .x = 400, .y = 280, .width = 40, .height = 40 };
    var buildings: [MAX_BUILDINGS]Rectangle = undefined;
    var buildColors: [MAX_BUILDINGS]Color = undefined;

    var spacing: i32 = 0;

    for (buildings) |building, i|
    {
        buildings[i].width = @intToFloat(f32, GetRandomValue(50, 200));
        buildings[i].height = @intToFloat(f32, GetRandomValue(100, 800));
        buildings[i].y = screenHeight - 130 - buildings[i].height;
        buildings[i].x = @intToFloat(f32, -6000 + spacing);

        spacing += @floatToInt(i32, buildings[i].width);

        buildColors[i] = Color { .r = @intCast(u8, GetRandomValue(200, 240)), .g = @intCast(u8, GetRandomValue(200, 240)),
                                 .b = @intCast(u8, GetRandomValue(200, 250)), .a = 255 };
    }

    var camera = Camera2D {
        .target = Vector2 { .x = player.x + 20, .y = player.y + 20 },
        .offset = Vector2 { .x = screenWidth/2, .y = screenHeight/2 },
        .rotation = 0,
        .zoom = 1,
    };

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------

        // Player movement
        if (IsKeyDown(KeyboardKey.KEY_RIGHT)) { player.x += 2; }
        else if (IsKeyDown(KeyboardKey.KEY_LEFT)) { player.x -= 2; }

        // Camera target follows player
        camera.target = Vector2 { .x = player.x + 20, .y = player.y + 20 };

        // Camera rotation controls
        if (IsKeyDown(KeyboardKey.KEY_A)) { camera.rotation -= 1; }
        else if (IsKeyDown(KeyboardKey.KEY_S)) { camera.rotation += 1; }

        // Limit camera rotation to 80 degrees (-40 to 40)
        camera.rotation = Clamp(camera.rotation, -40, 40);

        // Camera zoom controls
        camera.zoom += @intToFloat(f32, GetMouseWheelMove() * @floatToInt(c_int, 0.05));

        camera.zoom = Clamp(camera.zoom, 0.1, 3.0);

        // Camera reset (zoom and rotation)
        if (IsKeyPressed(KeyboardKey.KEY_R))
        {
            camera.zoom = 1.0;
            camera.rotation = 0.0;
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            camera.Begin();

                DrawRectangle(-6000, 320, 13000, 8000, DARKGRAY);

                for (buildings) |building, i|
                {
                    //DrawRectangleRec(building, buildColors[i]);
                    DrawRectangle(@floatToInt(c_int, building.x), @floatToInt(c_int, building.y),
                                  @floatToInt(c_int, building.width), @floatToInt(c_int, building.height), buildColors[i]);
                }

                DrawRectangle(@floatToInt(c_int, player.x), @floatToInt(c_int, player.y),
                              @floatToInt(c_int, player.width), @floatToInt(c_int, player.height), DARKGRAY);
                //DrawRectangleRec(player, RED);

                DrawLine(@floatToInt(c_int, camera.target.x), -screenHeight*10, @floatToInt(c_int, camera.target.x), screenHeight*10, GREEN);
                DrawLine(-screenWidth*10, @floatToInt(c_int, camera.target.y), screenWidth*10, @floatToInt(c_int, camera.target.y), GREEN);

            camera.End();

            DrawText("SCREEN AREA", 640, 10, 20, RED);

            DrawRectangle(0, 0, screenWidth, 5, RED);
            DrawRectangle(0, 5, 5, screenHeight - 10, RED);
            DrawRectangle(screenWidth - 5, 5, 5, screenHeight - 10, RED);
            DrawRectangle(0, screenHeight - 5, screenWidth, 5, RED);

            DrawRectangle( 10, 10, 250, 113, Fade(SKYBLUE, 0.5));
            DrawRectangleLines( 10, 10, 250, 113, BLUE);

            DrawText("Free 2d camera controls:", 20, 20, 10, BLACK);
            DrawText("- Right/Left to move Offset", 40, 40, 10, DARKGRAY);
            DrawText("- Mouse Wheel to Zoom in-out", 40, 60, 10, DARKGRAY);
            DrawText("- A / S to Rotate", 40, 80, 10, DARKGRAY);
            DrawText("- R to reset Zoom and Rotation", 40, 100, 10, DARKGRAY);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

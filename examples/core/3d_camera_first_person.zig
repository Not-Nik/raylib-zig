// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib");
const rlm = @import("raylib-math");

const MAX_COLUMNS = 20;

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.InitWindow(screenWidth, screenHeight, "raylib-zig [core] example - 3d camera first person");

    var camera = rl.Camera3D{
        .position = rl.Vector3.init(4, 2, 4),
        .target = rl.Vector3.init(0, 1.8, 0),
        .up = rl.Vector3.init(0, 1, 0),
        .fovy = 60,
        .projection = rl.CameraProjection.CAMERA_PERSPECTIVE,
    };

    var heights: [MAX_COLUMNS]f32 = undefined;
    var positions: [MAX_COLUMNS]rl.Vector3 = undefined;
    var colors: [MAX_COLUMNS]rl.Color = undefined;

    for (heights) |_, i| {
        heights[i] = @intToFloat(f32, rl.GetRandomValue(1, 12));
        positions[i] = rl.Vector3.init(@intToFloat(f32, rl.GetRandomValue(-15, 15)), heights[i] / 2.0, @intToFloat(f32, rl.GetRandomValue(-15, 15)));
        colors[i] = rl.Color.init(@intCast(u8, rl.GetRandomValue(20, 255)), @intCast(u8, rl.GetRandomValue(10, 55)), 30, 255);
    }

    camera.setMode(rl.CameraMode.CAMERA_FIRST_PERSON);

    rl.SetTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.WindowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        camera.update();
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();

        rl.ClearBackground(rl.RAYWHITE);

        camera.begin();

        // Draw ground
        rl.DrawPlane(rl.Vector3.init(0, 0, 0), rl.Vector2.init(32, 32), rl.LIGHTGRAY);
        rl.DrawCube(rl.Vector3.init(-16.0, 2.5, 0.0), 1.0, 5.0, 32.0, rl.BLUE); // Draw a blue wall
        rl.DrawCube(rl.Vector3.init(16.0, 2.5, 0.0), 1.0, 5.0, 32.0, rl.LIME); // Draw a green wall
        rl.DrawCube(rl.Vector3.init(0.0, 2.5, 16.0), 32.0, 5.0, 1.0, rl.GOLD); // Draw a yellow wall

        // Draw some cubes around
        for (heights) |height, i| {
            rl.DrawCube(positions[i], 2.0, height, 2.0, colors[i]);
            rl.DrawCubeWires(positions[i], 2.0, height, 2.0, rl.MAROON);
        }

        camera.end();

        rl.DrawRectangle(10, 10, 220, 70, rl.Fade(rl.SKYBLUE, 0.5));
        rl.DrawRectangleLines(10, 10, 220, 70, rl.BLUE);

        rl.DrawText("First person camera default controls:", 20, 20, 10, rl.BLACK);
        rl.DrawText("- Move with keys: W, A, S, D", 40, 40, 10, rl.DARKGRAY);
        rl.DrawText("- Mouse move to look around", 40, 60, 10, rl.DARKGRAY);

        rl.EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.CloseWindow(); // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

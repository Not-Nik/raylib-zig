// A raylib-zig port of https://github.com/raysan5/raylib/blob/master/examples/core/core_3d_picking.c
const rl = @import("raylib");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - 3d picking");

    // Define the camera to look into our 3d world
    var camera = rl.Camera{
        .position = rl.Vector3.init(10, 10, 10),
        .target = rl.Vector3.init(0, 0, 0),
        .up = rl.Vector3.init(0, 1, 0),
        .fovy = 45,
        .projection = rl.CameraProjection.camera_perspective,
    };

    const cubePosition = rl.Vector3.init(0, 1, 0);
    const cubeSize = rl.Vector3.init(2, 2, 2);

    var ray: rl.Ray = undefined; // Picking line ray
    var collision: rl.RayCollision = undefined; // Ray collision hit info

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        if (rl.isCursorHidden()) rl.updateCamera(&camera, rl.CameraMode.camera_first_person);

        // Toggle camera controls
        if (rl.isMouseButtonPressed(rl.MouseButton.mouse_button_right)) {
            if (rl.isCursorHidden()) rl.enableCursor() else rl.disableCursor();
        }

        if (rl.isMouseButtonPressed(rl.MouseButton.mouse_button_left)) {
            if (!collision.hit) {
                ray = rl.getScreenToWorldRay(rl.getMousePosition(), camera);

                // Check collision between ray and box
                collision = rl.getRayCollisionBox(ray, rl.BoundingBox{
                    .max = rl.Vector3.init(cubePosition.x - cubeSize.x / 2, cubePosition.y - cubeSize.y / 2, cubePosition.z - cubeSize.z / 2),
                    .min = rl.Vector3.init(cubePosition.x + cubeSize.x / 2, cubePosition.y + cubeSize.y / 2, cubePosition.z + cubeSize.z / 2),
                });
            } else collision.hit = false;
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------

        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(rl.Color.ray_white);

        {
            camera.begin();
            defer camera.end();

            if (collision.hit) {
                rl.drawCube(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, rl.Color.red);
                rl.drawCubeWires(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, rl.Color.maroon);

                rl.drawCubeWires(cubePosition, cubeSize.x + 0.2, cubeSize.y + 0.2, cubeSize.z + 0.2, rl.Color.green);
            } else {
                rl.drawCube(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, rl.Color.gray);
                rl.drawCubeWires(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, rl.Color.dark_gray);
            }

            rl.drawRay(ray, rl.Color.maroon);
            rl.drawGrid(10, 1);
        }

        rl.drawText("Try clicking on the box with your mouse!", 240, 10, 20, rl.Color.dark_gray);

        if (collision.hit) {
            rl.drawText("BOX SELECTED", @divTrunc((screenWidth - rl.measureText("BOX SELECTED", 30)), 2), screenHeight * 0.1, 30, rl.Color.green);
        }

        rl.drawText("Right click mouse to toggle camera controls", 10, 430, 10, rl.Color.gray);

        rl.drawFPS(10, 10);
    }
}

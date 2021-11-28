//
// models_loading
// Zig version:
// Author: Nikolas Wipper
// Date: 2020-02-15
//

usingnamespace @import("raylib");

const resourceDir = "raylib/examples/models/resources/";

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "raylib [models] example - models loading");

    // Define the camera to look into our 3d world
    var camera = Camera{
        .position = Vector3{ .x = 50.0, .y = 50.0, .z = 50.0 }, // Camera position
        .target = Vector3{ .x = 0.0, .y = 10.0, .z = 0.0 }, // Camera looking at point
        .up = Vector3{ .x = 0.0, .y = 1.0, .z = 0.0 }, // Camera up vector (rotation towards target)
        .fovy = 45.0, // Camera field-of-view Y
        .projection = CameraProjection.CAMERA_PERSPECTIVE, // Camera mode type
    };

    var model = LoadModel(resourceDir ++ "models/castle.obj"); // Load model
    var texture = LoadTexture(resourceDir ++ "models/castle_diffuse.png"); // Load model texture
    model.materials[0].maps[@enumToInt(MAP_DIFFUSE)].texture = texture; // Set map diffuse texture

    var position = Vector3{ .x = 0.0, .y = 0.0, .z = 0.0 }; // Set model position

    var bounds = MeshBoundingBox(model.meshes[0]); // Set model bounds

    // NOTE: bounds are calculated from the original size of the model,
    // if model is scaled on drawing, bounds must be also scaled

    camera.SetMode(CameraMode.CAMERA_FREE); // Set a free camera mode

    var selected = false; // Selected object flag

    SetTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose()) // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        camera.Update();

        // Load new models/textures on drag&drop
        if (IsFileDropped()) {
            var count: c_int = 0;
            var droppedFiles = GetDroppedFiles(&count);

            if (count == 1) // Only support one file dropped
            {
                if (IsFileExtension(droppedFiles[0], ".obj") or
                    IsFileExtension(droppedFiles[0], ".gltf") or
                    IsFileExtension(droppedFiles[0], ".iqm")) // Model file formats supported
                {
                    UnloadModel(model); // Unload previous model
                    model = LoadModel(droppedFiles[0]); // Load new model
                    model.materials[0].maps[@enumToInt(MAP_DIFFUSE)].texture = texture; // Set current map diffuse texture

                    bounds = MeshBoundingBox(model.meshes[0]);

                    // TODO: Move camera position from target enough distance to visualize model properly
                } else if (IsFileExtension(droppedFiles[0], ".png")) // Texture file formats supported
                {
                    // Unload current model texture and load new one
                    UnloadTexture(texture);
                    texture = LoadTexture(droppedFiles[0]);
                    model.materials[0].maps[@enumToInt(MAP_DIFFUSE)].texture = texture;
                }
            }

            ClearDroppedFiles(); // Clear internal buffers
        }

        // Select model on mouse click
        if (IsMouseButtonPressed(MouseButton.MOUSE_LEFT_BUTTON)) {
            // Check collision between ray and box
            if (CheckCollisionRayBox(GetMouseRay(GetMousePosition(), camera), bounds)) {
                selected = !selected;
            } else {
                selected = false;
            }
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

        ClearBackground(RAYWHITE);

        camera.Begin();

        DrawModel(model, position, 1.0, WHITE); // Draw 3d model with texture

        DrawGrid(20, 10.0); // Draw a grid

        if (selected) DrawBoundingBox(bounds, GREEN); // Draw selection box

        camera.End();

        DrawText("Drag & drop model to load mesh/texture.", 10, GetScreenHeight() - 20, 10, DARKGRAY);
        if (selected) DrawText("MODEL SELECTED", GetScreenWidth() - 110, 10, 10, GREEN);

        DrawText("(c) Castle 3D model by Alberto Cano", screenWidth - 200, screenHeight - 20, 10, GRAY);

        DrawFPS(10, 10);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadTexture(texture); // Unload texture
    UnloadModel(model); // Unload model

    CloseWindow(); // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

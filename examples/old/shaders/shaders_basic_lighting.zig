//
// shaders_basic_lighting
// Zig version:
// Author: Ryan Roden-Corrent
// Date: 2021-07-24
//
//  NOTE: This example requires raylib OpenGL 3.3 or ES2 versions for shaders
//  support,
//        OpenGL 1.1 does not support shaders, recompile raylib to OpenGL 3.3
//        version.
//
//  NOTE: Shaders used in this example are #version 330 (OpenGL 3.3).
usingnamespace @import("raylib");
usingnamespace @import("rlights.zig");
usingnamespace @import("raylib-math");

const resourceDir = "raylib/examples/shaders/resources/";

pub fn main() !void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    //SetConfigFlags(.FLAG_MSAA_4X_HINT); // Enable Multi Sampling Anti Aliasing 4x
    // (if available)
    InitWindow(screenWidth, screenHeight, "raylib [shaders] example - basic lighting");

    // Define the camera to look into our 3d world
    const camera = Camera{
        .position = .{ .x = 2.0, .y = 2.0, .z = 6.0 }, // Camera position
        .target = .{ .x = 0.0, .y = 0.5, .z = 0.0 }, // Camera looking at point
        .up = .{ .x = 0.0, .y = 1.0, .z = 0.0 }, // Camera up vector (rotation towards target)
        .fovy = 45.0, // Camera field-of-view Y
        .projection = CameraProjection.CAMERA_PERSPECTIVE, // Camera mode type
    };

    // Load models
    var modelA = LoadModelFromMesh(GenMeshTorus(0.4, 1.0, 16, 32));
    var modelB = LoadModelFromMesh(GenMeshCube(1.0, 1.0, 1.0));
    var modelC = LoadModelFromMesh(GenMeshSphere(0.5, 32, 32));

    // Load models texture
    const texture = LoadTexture(resourceDir ++ "texel_checker.png");

    // Assign texture to default model material
    modelA.materials[0].maps[@enumToInt(MAP_DIFFUSE)].texture = texture;
    modelB.materials[0].maps[@enumToInt(MAP_DIFFUSE)].texture = texture;
    modelC.materials[0].maps[@enumToInt(MAP_DIFFUSE)].texture = texture;

    var shader = LoadShader(
        resourceDir ++ "/shaders/glsl330/base_lighting.vs",
        resourceDir ++ "/shaders/glsl330/lighting.fs",
    );

    // Get some shader loactions
    shader.locs[@enumToInt(ShaderLocationIndex.SHADER_LOC_MATRIX_MODEL)] = GetShaderLocation(shader, "matModel");
    shader.locs[@enumToInt(ShaderLocationIndex.SHADER_LOC_VECTOR_VIEW)] = GetShaderLocation(shader, "viewPos");

    // ambient light level
    const ambientLoc = GetShaderLocation(shader, "ambient");
    const ambientVals = [4]f32{ 0.2, 0.2, 0.2, 1.0 };
    SetShaderValue(shader, ambientLoc, &ambientVals, @enumToInt(ShaderUniformDataType.SHADER_UNIFORM_VEC4));

    var angle: f32 = 6.282;

    // All models use the same shader
    modelA.materials[0].shader = shader;
    modelB.materials[0].shader = shader;
    modelC.materials[0].shader = shader;

    // Using 4 point lights, white, red, green and blue
    var lights = [_]Light{
        try CreateLight(LightType.point, .{ .x = 4, .y = 2, .z = 4 }, Vector3Zero(), WHITE, shader),
        try CreateLight(LightType.point, .{ .x = 4, .y = 2, .z = 4 }, Vector3Zero(), RED, shader),
        try CreateLight(LightType.point, .{ .x = 0, .y = 4, .z = 2 }, Vector3Zero(), GREEN, shader),
        try CreateLight(LightType.point, .{ .x = 0, .y = 4, .z = 2 }, Vector3Zero(), BLUE, shader),
    };

    SetCameraMode(camera, CameraMode.CAMERA_ORBITAL); // Set an orbital camera mode

    SetTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose()) // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        if (IsKeyPressed(KeyboardKey.KEY_W)) {
            lights[0].enabled = !lights[0].enabled;
        }
        if (IsKeyPressed(KeyboardKey.KEY_R)) {
            lights[1].enabled = !lights[1].enabled;
        }
        if (IsKeyPressed(KeyboardKey.KEY_G)) {
            lights[2].enabled = !lights[2].enabled;
        }
        if (IsKeyPressed(KeyboardKey.KEY_B)) {
            lights[3].enabled = !lights[3].enabled;
        }

        //UpdateCamera(&camera); // Update camera

        // Make the lights do differing orbits
        angle -= 0.02;
        lights[0].position.x = @cos(angle) * 4.0;
        lights[0].position.z = @sin(angle) * 4.0;
        lights[1].position.x = @cos(-angle * 0.6) * 4.0;
        lights[1].position.z = @sin(-angle * 0.6) * 4.0;
        lights[2].position.y = @cos(angle * 0.2) * 4.0;
        lights[2].position.z = @sin(angle * 0.2) * 4.0;
        lights[3].position.y = @cos(-angle * 0.35) * 4.0;
        lights[3].position.z = @sin(-angle * 0.35) * 4.0;

        UpdateLightValues(shader, lights[0]);
        UpdateLightValues(shader, lights[1]);
        UpdateLightValues(shader, lights[2]);
        UpdateLightValues(shader, lights[3]);

        // Rotate the torus
        modelA.transform =
            MatrixMultiply(modelA.transform, MatrixRotateX(-0.025));
        modelA.transform =
            MatrixMultiply(modelA.transform, MatrixRotateZ(0.012));

        // Update the light shader with the camera view position
        const cameraPos = [3]f32{ camera.position.x, camera.position.y, camera.position.z };
        SetShaderValue(shader, shader.locs[@enumToInt(ShaderLocationIndex.SHADER_LOC_VECTOR_VIEW)], &cameraPos, @enumToInt(ShaderUniformDataType.SHADER_UNIFORM_VEC3));
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

        ClearBackground(RAYWHITE);

        BeginMode3D(camera);

        // Draw the three models
        DrawModel(modelA, Vector3Zero(), 1.0, WHITE);
        DrawModel(modelB, .{ .x = -1.6, .y = 0, .z = 0 }, 1.0, WHITE);
        DrawModel(modelC, .{ .x = 1.6, .y = 0, .z = 0 }, 1.0, WHITE);

        // Draw markers to show where the lights are
        if (lights[0].enabled) {
            DrawSphereEx(lights[0].position, 0.2, 8, 8, WHITE);
        }
        if (lights[1].enabled) {
            DrawSphereEx(lights[1].position, 0.2, 8, 8, RED);
        }
        if (lights[2].enabled) {
            DrawSphereEx(lights[2].position, 0.2, 8, 8, GREEN);
        }
        if (lights[3].enabled) {
            DrawSphereEx(lights[3].position, 0.2, 8, 8, BLUE);
        }

        DrawGrid(10, 1.0);

        EndMode3D();

        DrawFPS(10, 10);

        DrawText("Use keys RGBW to toggle lights", 10, 30, 20, DARKGRAY);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadModel(modelA); // Unload the modelA
    UnloadModel(modelB); // Unload the modelB
    UnloadModel(modelC); // Unload the modelC

    UnloadTexture(texture); // Unload the texture
    UnloadShader(shader); // Unload shader

    CloseWindow(); // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

// A raylib port of https://github.com/raysan5/raylib/blob/master/examples/shaders/shaders_texture_outline.c

const rl = @import("raylib");
const std = @import("std");

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib [shaders] example - Apply an outline to a texture");

    const texture: rl.Texture2D = rl.loadTexture("resources/textures/fudesumi.png");

    const shdrOutline: rl.Shader = rl.loadShader(null, "resources/shaders/glsl330/outline.fs");

    var outlineSize: f32 = 2.0;
    const outlineColor = [4]f32{ 1.0, 0.0, 0.0, 1.0 }; // Normalized RED color
    const textureSize = rl.Vector2.init(@intToFloat(f32, texture.width), @intToFloat(f32, texture.height));

    // Get shader locations
    const outlineSizeLoc = rl.getShaderLocation(shdrOutline, "outlineSize");
    const outlineColorLoc = rl.getShaderLocation(shdrOutline, "outlineColor");
    const textureSizeLoc = rl.getShaderLocation(shdrOutline, "textureSize");

    // Set shader values (they can be changed later)
    rl.setShaderValue(shdrOutline, outlineSizeLoc, &outlineSize, @enumToInt(rl.ShaderUniformDataType.SHADER_UNIFORM_FLOAT));
    rl.setShaderValue(shdrOutline, outlineColorLoc, &outlineColor, @enumToInt(rl.ShaderUniformDataType.SHADER_UNIFORM_VEC4));
    rl.setShaderValue(shdrOutline, textureSizeLoc, &textureSize, @enumToInt(rl.ShaderUniformDataType.SHADER_UNIFORM_VEC2));

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        outlineSize += rl.getMouseWheelMove();
        if (outlineSize < 1.0) outlineSize = 1.0;

        rl.setShaderValue(shdrOutline, outlineSizeLoc, &outlineSize, @enumToInt(rl.ShaderUniformDataType.SHADER_UNIFORM_FLOAT));
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();

        rl.clearBackground(rl.Color.RAYWHITE);

        rl.beginShaderMode(shdrOutline);

        rl.drawTexture(texture, @divFloor(rl.getScreenWidth(), 2) - @divFloor(texture.width, 2), -30, rl.Color.WHITE);

        rl.endShaderMode();

        rl.drawText("Shader-based\ntexture\noutline", 10, 10, 20, rl.Color.GRAY);

        //rl.drawText(rl.textFormat("Outline size: %i px", @floatToInt(i32, outlineSize)), 10, 120, 20, rl.Color.MAROON);

        rl.drawFPS(710, 10);

        rl.endDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.unloadTexture(texture);
    rl.unloadShader(shdrOutline);

    rl.closeWindow(); // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

}

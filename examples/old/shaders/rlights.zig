// This is a zig port of rlights.h by Ryan Roden-Corrent (rcorre).
// The original notice follows:
//
// *********************************************************************************************
//
//    raylib.lights - Some useful functions to deal with lights data
//
//    CONFIGURATION:
//
//    #define RLIGHTS_IMPLEMENTATION
//        Generates the implementation of the library into the included file.
//        If not defined, the library is in header only mode and can be included
// in other headers or source files without problems. But only ONE file should
// hold the implementation.
//
//    LICENSE: zlib/libpng
//
//    Copyright (c) 2017-2020 Victor Fisac (@victorfisac) and Ramon Santamaria
// (@raysan5)
//
//    This software is provided "as-is", without any express or implied warranty.
// In no event will the authors be held liable for any damages arising from the
// use of this software.
//
//    Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it freely,
// subject to the following restrictions:
//
//      1. The origin of this software must not be misrepresented; you must not
// claim that you wrote the original software. If you use this software in a
// product, an acknowledgment in the product documentation would be appreciated
// but is not required.
//
//      2. Altered source versions must be plainly marked as such, and must not
// be misrepresented as being the original software.
//
//      3. This notice may not be removed or altered from any source
// distribution.
//
// *********************************************************************************************/

const std = @import("std");
usingnamespace @import("raylib");

const max_lights = 4;

pub const Light = struct {
    type: LightType,
    position: Vector3,
    target: Vector3,
    color: Color,
    enabled: bool,

    // Shader locations
    enabledLoc: i32,
    typeLoc: i32,
    posLoc: i32,
    targetLoc: i32,
    colorLoc: i32,
};

// Light type
pub const LightType = enum { directional, point };

var lightsCount: u32 = 0;

fn getShaderLoc(shader: Shader, name: []const u8) !i32 {
    // TODO: Below code doesn't look good to me,
    // it assumes a specific shader naming and structure
    // Probably this implementation could be improved
    // (note from original C implementation, I don't have a better idea)
    var buf: [32]u8 = undefined;
    const key = try std.fmt.bufPrintZ(buf[0..], "lights[{}].{s}", .{ lightsCount, name });
    return GetShaderLocation(shader, key);
}

// Create a light and get shader locations
pub fn CreateLight(typ: LightType, position: Vector3, target: Vector3, color: Color, shader: Shader) !Light {
    if (lightsCount >= max_lights) {
        return error.TooManyLights;
    }

    const light = Light{
        .enabled = true,
        .type = typ,
        .position = position,
        .target = target,
        .color = color,

        .enabledLoc = try getShaderLoc(shader, "enabled"),
        .typeLoc = try getShaderLoc(shader, "type"),
        .posLoc = try getShaderLoc(shader, "position"),
        .targetLoc = try getShaderLoc(shader, "target"),
        .colorLoc = try getShaderLoc(shader, "color"),
    };
    UpdateLightValues(shader, light);

    lightsCount += 1;

    return light;
}

// Send light properties to shader
// NOTE: Light shader locations should be available
pub fn UpdateLightValues(shader: Shader, light: Light) void {
    // Send to shader light enabled state and type
    SetShaderValue(shader, light.enabledLoc, &light.enabled, @enumToInt(ShaderUniformDataType.SHADER_UNIFORM_INT));
    SetShaderValue(shader, light.typeLoc, &light.type, @enumToInt(ShaderUniformDataType.SHADER_UNIFORM_INT));

    // Send to shader light position values
    const position = [3]f32{ light.position.x, light.position.y, light.position.z };
    SetShaderValue(shader, light.posLoc, &position, @enumToInt(ShaderUniformDataType.SHADER_UNIFORM_VEC3));

    // Send to shader light target position values
    const target = [3]f32{ light.target.x, light.target.y, light.target.z };
    SetShaderValue(shader, light.targetLoc, &target, @enumToInt(ShaderUniformDataType.SHADER_UNIFORM_VEC3));

    // Send to shader light color values
    const color = [4]f32{
        @intToFloat(f32, light.color.r) / 255.0,
        @intToFloat(f32, light.color.g) / 255.0,
        @intToFloat(f32, light.color.b) / 255.0,
        @intToFloat(f32, light.color.a) / 255.0,
    };
    SetShaderValue(shader, light.colorLoc, &color, @enumToInt(ShaderUniformDataType.SHADER_UNIFORM_VEC4));
}

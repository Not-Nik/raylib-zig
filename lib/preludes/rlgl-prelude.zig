// raylib-zig (c) Nikolas Wipper 2024

const rl = @import("raylib.zig");
const cdef = @import("rlgl-ext.zig");
const std = @import("std");

test {
    std.testing.refAllDeclsRecursive(@This());
}

const Matrix = rl.Matrix;

pub const rlVertexBuffer = extern struct {
    elementCount: c_int,
    vertices: [*c]f32,
    texcoords: [*c]f32,
    normals: [*c]f32,
    colors: [*c]u8,
    indices: [*c]c_ushort,
    vaoId: c_uint,
    vboId: [5]c_uint,
};

pub const rlDrawCall = extern struct {
    mode: c_int,
    vertexCount: c_int,
    vertexAlignment: c_int,
    textureId: c_uint,
};

pub const rlRenderBatch = extern struct {
    bufferCount: c_int,
    currentBuffer: c_int,
    vertexBuffer: [*c]rlVertexBuffer,
    draws: [*c]rlDrawCall,
    drawCounter: c_int,
    currentDepth: f32,
};

pub const rlGlVersion = enum(c_int) {
    rl_opengl_11 = 1,
    rl_opengl_21 = 2,
    rl_opengl_33 = 3,
    rl_opengl_43 = 4,
    rl_opengl_es_20 = 5,
    rl_opengl_es_30 = 6
};

pub const rlTraceLogLevel = enum(c_int) {
    rl_log_all = 0,
    rl_log_trace = 1,
    rl_log_debug = 2,
    rl_log_info = 3,
    rl_log_warning = 4,
    rl_log_error = 5,
    rl_log_fatal = 6,
    rl_log_none = 7,
};

pub const rlPixelFormat = enum(c_int) {
    rl_pixelformat_uncompressed_grayscale = 1,
    rl_pixelformat_uncompressed_gray_alpha = 2,
    rl_pixelformat_uncompressed_r5g6b5 = 3,
    rl_pixelformat_uncompressed_r8g8b8 = 4,
    rl_pixelformat_uncompressed_r5g5b5a1 = 5,
    rl_pixelformat_uncompressed_r4g4b4a4 = 6,
    rl_pixelformat_uncompressed_r8g8b8a8 = 7,
    rl_pixelformat_uncompressed_r32 = 8,
    rl_pixelformat_uncompressed_r32g32b32 = 9,
    rl_pixelformat_uncompressed_r32g32b32a32 = 10,
    rl_pixelformat_uncompressed_r16 = 11,
    rl_pixelformat_uncompressed_r16g16b16 = 12,
    rl_pixelformat_uncompressed_r16g16b16a16 = 13,
    rl_pixelformat_compressed_dxt1_rgb = 14,
    rl_pixelformat_compressed_dxt1_rgba = 15,
    rl_pixelformat_compressed_dxt3_rgba = 16,
    rl_pixelformat_compressed_dxt5_rgba = 17,
    rl_pixelformat_compressed_etc1_rgb = 18,
    rl_pixelformat_compressed_etc2_rgb = 19,
    rl_pixelformat_compressed_etc2_eac_rgba = 20,
    rl_pixelformat_compressed_pvrt_rgb = 21,
    rl_pixelformat_compressed_pvrt_rgba = 22,
    rl_pixelformat_compressed_astc_4x4_rgba = 23,
    rl_pixelformat_compressed_astc_8x8_rgba = 24,
};

pub const rlTextureFilter = enum(c_int) {
    rl_texture_filter_point = 0,
    rl_texture_filter_bilinear = 1,
    rl_texture_filter_trilinear = 2,
    rl_texture_filter_anisotropic_4x = 3,
    rl_texture_filter_anisotropic_8x = 4,
    rl_texture_filter_anisotropic_16x = 5,
};

pub const rlBlendMode = enum(c_int) {
    rl_blend_alpha = 0,
    rl_blend_additive = 1,
    rl_blend_multiplied = 2,
    rl_blend_add_colors = 3,
    rl_blend_subtract_colors = 4,
    rl_blend_alpha_premultiply = 5,
    rl_blend_custom = 6,
    rl_blend_custom_separate = 7,
};

pub const rlShaderLocationIndex = enum(c_uint) {
    rl_shader_loc_vertex_position = 0,
    rl_shader_loc_vertex_texcoord01 = 1,
    rl_shader_loc_vertex_texcoord02 = 2,
    rl_shader_loc_vertex_normal = 3,
    rl_shader_loc_vertex_tangent = 4,
    rl_shader_loc_vertex_color = 5,
    rl_shader_loc_matrix_mvp = 6,
    rl_shader_loc_matrix_view = 7,
    rl_shader_loc_matrix_projection = 8,
    rl_shader_loc_matrix_model = 9,
    rl_shader_loc_matrix_normal = 10,
    rl_shader_loc_vector_view = 11,
    rl_shader_loc_color_diffuse = 12,
    rl_shader_loc_color_specular = 13,
    rl_shader_loc_color_ambient = 14,
    rl_shader_loc_map_albedo = 15,
    rl_shader_loc_map_metalness = 16,
    rl_shader_loc_map_normal = 17,
    rl_shader_loc_map_roughness = 18,
    rl_shader_loc_map_occlusion = 19,
    rl_shader_loc_map_emission = 20,
    rl_shader_loc_map_height = 21,
    rl_shader_loc_map_cubemap = 22,
    rl_shader_loc_map_irradiance = 23,
    rl_shader_loc_map_prefilter = 24,
    rl_shader_loc_map_brdf = 25,
};

pub const rlShaderUniformDataType = enum(c_uint) {
    rl_shader_uniform_float = 0,
    rl_shader_uniform_vec2 = 1,
    rl_shader_uniform_vec3 = 2,
    rl_shader_uniform_vec4 = 3,
    rl_shader_uniform_int = 4,
    rl_shader_uniform_ivec2 = 5,
    rl_shader_uniform_ivec3 = 6,
    rl_shader_uniform_ivec4 = 7,
    rl_shader_uniform_sampler2d = 8,
};

pub const rlShaderAttributeDataType = enum(c_uint) {
    rl_shader_attrib_float = 0,
    rl_shader_attrib_vec2 = 1,
    rl_shader_attrib_vec3 = 2,
    rl_shader_attrib_vec4 = 3
};

pub const rlFramebufferAttachType = enum(c_uint) {
    rl_attachment_color_channel0 = 0,
    rl_attachment_color_channel1 = 1,
    rl_attachment_color_channel2 = 2,
    rl_attachment_color_channel3 = 3,
    rl_attachment_color_channel4 = 4,
    rl_attachment_color_channel5 = 5,
    rl_attachment_color_channel6 = 6,
    rl_attachment_color_channel7 = 7,
    rl_attachment_depth = 100,
    rl_attachment_stencil = 200,
};

pub const rlFramebufferAttachTextureType = enum(c_uint) {
    rl_attachment_cubemap_positive_x = 0,
    rl_attachment_cubemap_negative_x = 1,
    rl_attachment_cubemap_positive_y = 2,
    rl_attachment_cubemap_negative_y = 3,
    rl_attachment_cubemap_positive_z = 4,
    rl_attachment_cubemap_negative_z = 5,
    rl_attachment_texture2d = 100,
    rl_attachment_renderbuffer = 200,
};

pub const rlCullMode = enum(c_uint) {
    rl_cull_face_front = 0,
    rl_cull_face_back = 1,
};

pub const RL_DEFAULT_SHADER_ATTRIB_LOCATION_POSITION = @as(i32, 0);
pub const RL_DEFAULT_SHADER_ATTRIB_LOCATION_TEXCOORD = @as(i32, 1);
pub const RL_DEFAULT_SHADER_ATTRIB_LOCATION_NORMAL = @as(i32, 2);
pub const RL_DEFAULT_SHADER_ATTRIB_LOCATION_COLOR = @as(i32, 3);
pub const RL_DEFAULT_SHADER_ATTRIB_LOCATION_TANGENT = @as(i32, 4);
pub const RL_DEFAULT_SHADER_ATTRIB_LOCATION_TEXCOORD2 = @as(i32, 5);

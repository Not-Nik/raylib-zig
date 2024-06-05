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

pub fn rlMatrixMode(mode: i32) void {
    cdef.rlMatrixMode(@as(c_int, mode));
}

pub fn rlPushMatrix() void {
    cdef.rlPushMatrix();
}

pub fn rlPopMatrix() void {
    cdef.rlPopMatrix();
}

pub fn rlLoadIdentity() void {
    cdef.rlLoadIdentity();
}

pub fn rlTranslatef(x: f32, y: f32, z: f32) void {
    cdef.rlTranslatef(x, y, z);
}

pub fn rlRotatef(angle: f32, x: f32, y: f32, z: f32) void {
    cdef.rlRotatef(angle, x, y, z);
}

pub fn rlScalef(x: f32, y: f32, z: f32) void {
    cdef.rlScalef(x, y, z);
}

pub fn rlMultMatrixf(matf: []const f32) void {
    cdef.rlMultMatrixf(@as([*c]const f32, @ptrCast(matf)));
}

pub fn rlFrustum(left: f64, right: f64, bottom: f64, top: f64, znear: f64, zfar: f64) void {
    cdef.rlFrustum(left, right, bottom, top, znear, zfar);
}

pub fn rlOrtho(left: f64, right: f64, bottom: f64, top: f64, znear: f64, zfar: f64) void {
    cdef.rlOrtho(left, right, bottom, top, znear, zfar);
}

pub fn rlViewport(x: i32, y: i32, width: i32, height: i32) void {
    cdef.rlViewport(@as(c_int, x), @as(c_int, y), @as(c_int, width), @as(c_int, height));
}

pub fn rlSetClipPlanes(near: f64, far: f64) void {
    cdef.rlSetClipPlanes(near, far);
}

pub fn rlGetCullDistanceNear() f64 {
    return cdef.rlGetCullDistanceNear();
}

pub fn rlGetCullDistanceFar() f64 {
    return cdef.rlGetCullDistanceFar();
}

pub fn rlBegin(mode: i32) void {
    cdef.rlBegin(@as(c_int, mode));
}

pub fn rlEnd() void {
    cdef.rlEnd();
}

pub fn rlVertex2i(x: i32, y: i32) void {
    cdef.rlVertex2i(@as(c_int, x), @as(c_int, y));
}

pub fn rlVertex2f(x: f32, y: f32) void {
    cdef.rlVertex2f(x, y);
}

pub fn rlVertex3f(x: f32, y: f32, z: f32) void {
    cdef.rlVertex3f(x, y, z);
}

pub fn rlTexCoord2f(x: f32, y: f32) void {
    cdef.rlTexCoord2f(x, y);
}

pub fn rlNormal3f(x: f32, y: f32, z: f32) void {
    cdef.rlNormal3f(x, y, z);
}

pub fn rlColor4ub(r: u8, g: u8, b: u8, a: u8) void {
    cdef.rlColor4ub(r, g, b, a);
}

pub fn rlColor3f(x: f32, y: f32, z: f32) void {
    cdef.rlColor3f(x, y, z);
}

pub fn rlColor4f(x: f32, y: f32, z: f32, w: f32) void {
    cdef.rlColor4f(x, y, z, w);
}

pub fn rlEnableVertexArray(vaoId: u32) bool {
    return cdef.rlEnableVertexArray(@as(c_uint, vaoId));
}

pub fn rlDisableVertexArray() void {
    cdef.rlDisableVertexArray();
}

pub fn rlEnableVertexBuffer(id: u32) void {
    cdef.rlEnableVertexBuffer(@as(c_uint, id));
}

pub fn rlDisableVertexBuffer() void {
    cdef.rlDisableVertexBuffer();
}

pub fn rlEnableVertexBufferElement(id: u32) void {
    cdef.rlEnableVertexBufferElement(@as(c_uint, id));
}

pub fn rlDisableVertexBufferElement() void {
    cdef.rlDisableVertexBufferElement();
}

pub fn rlEnableVertexAttribute(index: u32) void {
    cdef.rlEnableVertexAttribute(@as(c_uint, index));
}

pub fn rlDisableVertexAttribute(index: u32) void {
    cdef.rlDisableVertexAttribute(@as(c_uint, index));
}

pub fn rlEnableStatePointer(vertexAttribType: i32, buffer: *anyopaque) void {
    cdef.rlEnableStatePointer(@as(c_int, vertexAttribType), buffer);
}

pub fn rlDisableStatePointer(vertexAttribType: i32) void {
    cdef.rlDisableStatePointer(@as(c_int, vertexAttribType));
}

pub fn rlActiveTextureSlot(slot: i32) void {
    cdef.rlActiveTextureSlot(@as(c_int, slot));
}

pub fn rlEnableTexture(id: u32) void {
    cdef.rlEnableTexture(@as(c_uint, id));
}

pub fn rlDisableTexture() void {
    cdef.rlDisableTexture();
}

pub fn rlEnableTextureCubemap(id: u32) void {
    cdef.rlEnableTextureCubemap(@as(c_uint, id));
}

pub fn rlDisableTextureCubemap() void {
    cdef.rlDisableTextureCubemap();
}

pub fn rlTextureParameters(id: u32, param: i32, value: i32) void {
    cdef.rlTextureParameters(@as(c_uint, id), @as(c_int, param), @as(c_int, value));
}

pub fn rlCubemapParameters(id: u32, param: i32, value: i32) void {
    cdef.rlCubemapParameters(@as(c_uint, id), @as(c_int, param), @as(c_int, value));
}

pub fn rlEnableShader(id: u32) void {
    cdef.rlEnableShader(@as(c_uint, id));
}

pub fn rlDisableShader() void {
    cdef.rlDisableShader();
}

pub fn rlEnableFramebuffer(id: u32) void {
    cdef.rlEnableFramebuffer(@as(c_uint, id));
}

pub fn rlDisableFramebuffer() void {
    cdef.rlDisableFramebuffer();
}

pub fn rlGetActiveFramebuffer() u32 {
    return @as(u32, cdef.rlGetActiveFramebuffer());
}

pub fn rlActiveDrawBuffers(count: i32) void {
    cdef.rlActiveDrawBuffers(@as(c_int, count));
}

pub fn rlBlitFramebuffer(srcX: i32, srcY: i32, srcWidth: i32, srcHeight: i32, dstX: i32, dstY: i32, dstWidth: i32, dstHeight: i32, bufferMask: i32) void {
    cdef.rlBlitFramebuffer(@as(c_int, srcX), @as(c_int, srcY), @as(c_int, srcWidth), @as(c_int, srcHeight), @as(c_int, dstX), @as(c_int, dstY), @as(c_int, dstWidth), @as(c_int, dstHeight), @as(c_int, bufferMask));
}

pub fn rlBindFramebuffer(target: u32, framebuffer: u32) void {
    cdef.rlBindFramebuffer(@as(c_uint, target), @as(c_uint, framebuffer));
}

pub fn rlEnableColorBlend() void {
    cdef.rlEnableColorBlend();
}

pub fn rlDisableColorBlend() void {
    cdef.rlDisableColorBlend();
}

pub fn rlEnableDepthTest() void {
    cdef.rlEnableDepthTest();
}

pub fn rlDisableDepthTest() void {
    cdef.rlDisableDepthTest();
}

pub fn rlEnableDepthMask() void {
    cdef.rlEnableDepthMask();
}

pub fn rlDisableDepthMask() void {
    cdef.rlDisableDepthMask();
}

pub fn rlEnableBackfaceCulling() void {
    cdef.rlEnableBackfaceCulling();
}

pub fn rlDisableBackfaceCulling() void {
    cdef.rlDisableBackfaceCulling();
}

pub fn rlColorMask(r: bool, g: bool, b: bool, a: bool) void {
    cdef.rlColorMask(r, g, b, a);
}

pub fn rlSetCullFace(mode: i32) void {
    cdef.rlSetCullFace(@as(c_int, mode));
}

pub fn rlEnableScissorTest() void {
    cdef.rlEnableScissorTest();
}

pub fn rlDisableScissorTest() void {
    cdef.rlDisableScissorTest();
}

pub fn rlScissor(x: i32, y: i32, width: i32, height: i32) void {
    cdef.rlScissor(@as(c_int, x), @as(c_int, y), @as(c_int, width), @as(c_int, height));
}

pub fn rlEnableWireMode() void {
    cdef.rlEnableWireMode();
}

pub fn rlEnablePointMode() void {
    cdef.rlEnablePointMode();
}

pub fn rlDisableWireMode() void {
    cdef.rlDisableWireMode();
}

pub fn rlSetLineWidth(width: f32) void {
    cdef.rlSetLineWidth(width);
}

pub fn rlGetLineWidth() f32 {
    return cdef.rlGetLineWidth();
}

pub fn rlEnableSmoothLines() void {
    cdef.rlEnableSmoothLines();
}

pub fn rlDisableSmoothLines() void {
    cdef.rlDisableSmoothLines();
}

pub fn rlEnableStereoRender() void {
    cdef.rlEnableStereoRender();
}

pub fn rlDisableStereoRender() void {
    cdef.rlDisableStereoRender();
}

pub fn rlIsStereoRenderEnabled() bool {
    return cdef.rlIsStereoRenderEnabled();
}

pub fn rlClearColor(r: u8, g: u8, b: u8, a: u8) void {
    cdef.rlClearColor(r, g, b, a);
}

pub fn rlClearScreenBuffers() void {
    cdef.rlClearScreenBuffers();
}

pub fn rlCheckErrors() void {
    cdef.rlCheckErrors();
}

pub fn rlSetBlendMode(mode: i32) void {
    cdef.rlSetBlendMode(@as(c_int, mode));
}

pub fn rlSetBlendFactors(glSrcFactor: i32, glDstFactor: i32, glEquation: i32) void {
    cdef.rlSetBlendFactors(@as(c_int, glSrcFactor), @as(c_int, glDstFactor), @as(c_int, glEquation));
}

pub fn rlSetBlendFactorsSeparate(glSrcRGB: i32, glDstRGB: i32, glSrcAlpha: i32, glDstAlpha: i32, glEqRGB: i32, glEqAlpha: i32) void {
    cdef.rlSetBlendFactorsSeparate(@as(c_int, glSrcRGB), @as(c_int, glDstRGB), @as(c_int, glSrcAlpha), @as(c_int, glDstAlpha), @as(c_int, glEqRGB), @as(c_int, glEqAlpha));
}

pub fn rlglInit(width: i32, height: i32) void {
    cdef.rlglInit(@as(c_int, width), @as(c_int, height));
}

pub fn rlglClose() void {
    cdef.rlglClose();
}

pub fn rlLoadExtensions(loader: *anyopaque) void {
    cdef.rlLoadExtensions(loader);
}

pub fn rlGetVersion() i32 {
    return @as(i32, cdef.rlGetVersion());
}

pub fn rlSetFramebufferWidth(width: i32) void {
    cdef.rlSetFramebufferWidth(@as(c_int, width));
}

pub fn rlGetFramebufferWidth() i32 {
    return @as(i32, cdef.rlGetFramebufferWidth());
}

pub fn rlSetFramebufferHeight(height: i32) void {
    cdef.rlSetFramebufferHeight(@as(c_int, height));
}

pub fn rlGetFramebufferHeight() i32 {
    return @as(i32, cdef.rlGetFramebufferHeight());
}

pub fn rlGetTextureIdDefault() u32 {
    return @as(u32, cdef.rlGetTextureIdDefault());
}

pub fn rlGetShaderIdDefault() u32 {
    return @as(u32, cdef.rlGetShaderIdDefault());
}

pub fn rlLoadRenderBatch(numBuffers: i32, bufferElements: i32) rlRenderBatch {
    return cdef.rlLoadRenderBatch(@as(c_int, numBuffers), @as(c_int, bufferElements));
}

pub fn rlUnloadRenderBatch(batch: rlRenderBatch) void {
    cdef.rlUnloadRenderBatch(batch);
}

pub fn rlDrawRenderBatch(batch: *rlRenderBatch) void {
    cdef.rlDrawRenderBatch(@as([*c]rlRenderBatch, @ptrCast(batch)));
}

pub fn rlSetRenderBatchActive(batch: *rlRenderBatch) void {
    cdef.rlSetRenderBatchActive(@as([*c]rlRenderBatch, @ptrCast(batch)));
}

pub fn rlDrawRenderBatchActive() void {
    cdef.rlDrawRenderBatchActive();
}

pub fn rlCheckRenderBatchLimit(vCount: i32) bool {
    return cdef.rlCheckRenderBatchLimit(@as(c_int, vCount));
}

pub fn rlSetTexture(id: u32) void {
    cdef.rlSetTexture(@as(c_uint, id));
}

pub fn rlLoadVertexArray() u32 {
    return @as(u32, cdef.rlLoadVertexArray());
}

pub fn rlLoadVertexBuffer(buffer: *const anyopaque, size: i32, dynamic: bool) u32 {
    return @as(u32, cdef.rlLoadVertexBuffer(buffer, @as(c_int, size), dynamic));
}

pub fn rlLoadVertexBufferElement(buffer: *const anyopaque, size: i32, dynamic: bool) u32 {
    return @as(u32, cdef.rlLoadVertexBufferElement(buffer, @as(c_int, size), dynamic));
}

pub fn rlUpdateVertexBuffer(bufferId: u32, data: *const anyopaque, dataSize: i32, offset: i32) void {
    cdef.rlUpdateVertexBuffer(@as(c_uint, bufferId), data, @as(c_int, dataSize), @as(c_int, offset));
}

pub fn rlUpdateVertexBufferElements(id: u32, data: *const anyopaque, dataSize: i32, offset: i32) void {
    cdef.rlUpdateVertexBufferElements(@as(c_uint, id), data, @as(c_int, dataSize), @as(c_int, offset));
}

pub fn rlUnloadVertexArray(vaoId: u32) void {
    cdef.rlUnloadVertexArray(@as(c_uint, vaoId));
}

pub fn rlUnloadVertexBuffer(vboId: u32) void {
    cdef.rlUnloadVertexBuffer(@as(c_uint, vboId));
}

pub fn rlSetVertexAttribute(index: u32, compSize: i32, ty: i32, normalized: bool, stride: i32, offset: i32) void {
    cdef.rlSetVertexAttribute(@as(c_uint, index), @as(c_int, compSize), @as(c_int, ty), normalized, @as(c_int, stride), @as(c_int, offset));
}

pub fn rlSetVertexAttributeDivisor(index: u32, divisor: i32) void {
    cdef.rlSetVertexAttributeDivisor(@as(c_uint, index), @as(c_int, divisor));
}

pub fn rlSetVertexAttributeDefault(locIndex: i32, value: *const anyopaque, attribType: i32, count: i32) void {
    cdef.rlSetVertexAttributeDefault(@as(c_int, locIndex), value, @as(c_int, attribType), @as(c_int, count));
}

pub fn rlDrawVertexArray(offset: i32, count: i32) void {
    cdef.rlDrawVertexArray(@as(c_int, offset), @as(c_int, count));
}

pub fn rlDrawVertexArrayElements(offset: i32, count: i32, buffer: *const anyopaque) void {
    cdef.rlDrawVertexArrayElements(@as(c_int, offset), @as(c_int, count), buffer);
}

pub fn rlDrawVertexArrayInstanced(offset: i32, count: i32, instances: i32) void {
    cdef.rlDrawVertexArrayInstanced(@as(c_int, offset), @as(c_int, count), @as(c_int, instances));
}

pub fn rlDrawVertexArrayElementsInstanced(offset: i32, count: i32, buffer: *const anyopaque, instances: i32) void {
    cdef.rlDrawVertexArrayElementsInstanced(@as(c_int, offset), @as(c_int, count), buffer, @as(c_int, instances));
}

pub fn rlLoadTexture(data: *const anyopaque, width: i32, height: i32, format: i32, mipmapCount: i32) u32 {
    return @as(u32, cdef.rlLoadTexture(data, @as(c_int, width), @as(c_int, height), @as(c_int, format), @as(c_int, mipmapCount)));
}

pub fn rlLoadTextureDepth(width: i32, height: i32, useRenderBuffer: bool) u32 {
    return @as(u32, cdef.rlLoadTextureDepth(@as(c_int, width), @as(c_int, height), useRenderBuffer));
}

pub fn rlLoadTextureCubemap(data: *const anyopaque, size: i32, format: i32) u32 {
    return @as(u32, cdef.rlLoadTextureCubemap(data, @as(c_int, size), @as(c_int, format)));
}

pub fn rlUpdateTexture(id: u32, offsetX: i32, offsetY: i32, width: i32, height: i32, format: i32, data: *const anyopaque) void {
    cdef.rlUpdateTexture(@as(c_uint, id), @as(c_int, offsetX), @as(c_int, offsetY), @as(c_int, width), @as(c_int, height), @as(c_int, format), data);
}

pub fn rlGetGlTextureFormats(format: i32, glInternalFormat: *u32, glFormat: *u32, glType: *u32) void {
    cdef.rlGetGlTextureFormats(@as(c_int, format), @as([*c]c_uint, @ptrCast(glInternalFormat)), @as([*c]c_uint, @ptrCast(glFormat)), @as([*c]c_uint, @ptrCast(glType)));
}

pub fn rlGetPixelFormatName(format: u32) [:0]const u8 {
    return std.mem.span(cdef.rlGetPixelFormatName(@as(c_uint, format)));
}

pub fn rlUnloadTexture(id: u32) void {
    cdef.rlUnloadTexture(@as(c_uint, id));
}

pub fn rlGenTextureMipmaps(id: u32, width: i32, height: i32, format: i32, mipmaps: *i32) void {
    cdef.rlGenTextureMipmaps(@as(c_uint, id), @as(c_int, width), @as(c_int, height), @as(c_int, format), @as([*c]c_int, @ptrCast(mipmaps)));
}

pub fn rlReadTexturePixels(id: u32, width: i32, height: i32, format: i32) *anyopaque {
    return cdef.rlReadTexturePixels(@as(c_uint, id), @as(c_int, width), @as(c_int, height), @as(c_int, format));
}

pub fn rlReadScreenPixels(width: i32, height: i32) [:0]u8 {
    return std.mem.span(cdef.rlReadScreenPixels(@as(c_int, width), @as(c_int, height)));
}

pub fn rlLoadFramebuffer() u32 {
    return @as(u32, cdef.rlLoadFramebuffer());
}

pub fn rlFramebufferAttach(fboId: u32, texId: u32, attachType: i32, texType: i32, mipLevel: i32) void {
    cdef.rlFramebufferAttach(@as(c_uint, fboId), @as(c_uint, texId), @as(c_int, attachType), @as(c_int, texType), @as(c_int, mipLevel));
}

pub fn rlFramebufferComplete(id: u32) bool {
    return cdef.rlFramebufferComplete(@as(c_uint, id));
}

pub fn rlUnloadFramebuffer(id: u32) void {
    cdef.rlUnloadFramebuffer(@as(c_uint, id));
}

pub fn rlLoadShaderCode(vsCode: [:0]const u8, fsCode: [:0]const u8) u32 {
    return @as(u32, cdef.rlLoadShaderCode(@as([*c]const u8, @ptrCast(vsCode)), @as([*c]const u8, @ptrCast(fsCode))));
}

pub fn rlCompileShader(shaderCode: [:0]const u8, ty: i32) u32 {
    return @as(u32, cdef.rlCompileShader(@as([*c]const u8, @ptrCast(shaderCode)), @as(c_int, ty)));
}

pub fn rlLoadShaderProgram(vShaderId: u32, fShaderId: u32) u32 {
    return @as(u32, cdef.rlLoadShaderProgram(@as(c_uint, vShaderId), @as(c_uint, fShaderId)));
}

pub fn rlUnloadShaderProgram(id: u32) void {
    cdef.rlUnloadShaderProgram(@as(c_uint, id));
}

pub fn rlGetLocationUniform(shaderId: u32, uniformName: [:0]const u8) i32 {
    return @as(i32, cdef.rlGetLocationUniform(@as(c_uint, shaderId), @as([*c]const u8, @ptrCast(uniformName))));
}

pub fn rlGetLocationAttrib(shaderId: u32, attribName: [:0]const u8) i32 {
    return @as(i32, cdef.rlGetLocationAttrib(@as(c_uint, shaderId), @as([*c]const u8, @ptrCast(attribName))));
}

pub fn rlSetUniform(locIndex: i32, value: *const anyopaque, uniformType: i32, count: i32) void {
    cdef.rlSetUniform(@as(c_int, locIndex), value, @as(c_int, uniformType), @as(c_int, count));
}

pub fn rlSetUniformMatrix(locIndex: i32, mat: Matrix) void {
    cdef.rlSetUniformMatrix(@as(c_int, locIndex), mat);
}

pub fn rlSetUniformSampler(locIndex: i32, textureId: u32) void {
    cdef.rlSetUniformSampler(@as(c_int, locIndex), @as(c_uint, textureId));
}

pub fn rlSetShader(id: u32, locs: []i32) void {
    cdef.rlSetShader(@as(c_uint, id), @as([*c]c_int, @ptrCast(locs)));
}

pub fn rlLoadComputeShaderProgram(shaderId: u32) u32 {
    return @as(u32, cdef.rlLoadComputeShaderProgram(@as(c_uint, shaderId)));
}

pub fn rlComputeShaderDispatch(groupX: u32, groupY: u32, groupZ: u32) void {
    cdef.rlComputeShaderDispatch(@as(c_uint, groupX), @as(c_uint, groupY), @as(c_uint, groupZ));
}

pub fn rlLoadShaderBuffer(size: u32, data: *const anyopaque, usageHint: i32) u32 {
    return @as(u32, cdef.rlLoadShaderBuffer(@as(c_uint, size), data, @as(c_int, usageHint)));
}

pub fn rlUnloadShaderBuffer(ssboId: u32) void {
    cdef.rlUnloadShaderBuffer(@as(c_uint, ssboId));
}

pub fn rlUpdateShaderBuffer(id: u32, data: *const anyopaque, dataSize: u32, offset: u32) void {
    cdef.rlUpdateShaderBuffer(@as(c_uint, id), data, @as(c_uint, dataSize), @as(c_uint, offset));
}

pub fn rlBindShaderBuffer(id: u32, index: u32) void {
    cdef.rlBindShaderBuffer(@as(c_uint, id), @as(c_uint, index));
}

pub fn rlReadShaderBuffer(id: u32, dest: *anyopaque, count: u32, offset: u32) void {
    cdef.rlReadShaderBuffer(@as(c_uint, id), dest, @as(c_uint, count), @as(c_uint, offset));
}

pub fn rlCopyShaderBuffer(destId: u32, srcId: u32, destOffset: u32, srcOffset: u32, count: u32) void {
    cdef.rlCopyShaderBuffer(@as(c_uint, destId), @as(c_uint, srcId), @as(c_uint, destOffset), @as(c_uint, srcOffset), @as(c_uint, count));
}

pub fn rlGetShaderBufferSize(id: u32) u32 {
    return @as(u32, cdef.rlGetShaderBufferSize(@as(c_uint, id)));
}

pub fn rlBindImageTexture(id: u32, index: u32, format: i32, readonly: bool) void {
    cdef.rlBindImageTexture(@as(c_uint, id), @as(c_uint, index), @as(c_int, format), readonly);
}

pub fn rlGetMatrixModelview() Matrix {
    return cdef.rlGetMatrixModelview();
}

pub fn rlGetMatrixProjection() Matrix {
    return cdef.rlGetMatrixProjection();
}

pub fn rlGetMatrixTransform() Matrix {
    return cdef.rlGetMatrixTransform();
}

pub fn rlGetMatrixProjectionStereo(eye: i32) Matrix {
    return cdef.rlGetMatrixProjectionStereo(@as(c_int, eye));
}

pub fn rlGetMatrixViewOffsetStereo(eye: i32) Matrix {
    return cdef.rlGetMatrixViewOffsetStereo(@as(c_int, eye));
}

pub fn rlSetMatrixProjection(proj: Matrix) void {
    cdef.rlSetMatrixProjection(proj);
}

pub fn rlSetMatrixModelview(view: Matrix) void {
    cdef.rlSetMatrixModelview(view);
}

pub fn rlSetMatrixProjectionStereo(right: Matrix, left: Matrix) void {
    cdef.rlSetMatrixProjectionStereo(right, left);
}

pub fn rlSetMatrixViewOffsetStereo(right: Matrix, left: Matrix) void {
    cdef.rlSetMatrixViewOffsetStereo(right, left);
}

pub fn rlLoadDrawCube() void {
    cdef.rlLoadDrawCube();
}

pub fn rlLoadDrawQuad() void {
    cdef.rlLoadDrawQuad();
}

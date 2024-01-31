// raylib-zig (c) Nikolas Wipper 2023

const rl = @This();
const std = @import("std");

pub const RaylibError = error{GenericError};

pub const Vector2 = extern struct {
    x: f32,
    y: f32,

    pub fn init(x: f32, y: f32) Vector2 {
        return Vector2{ .x = x, .y = y };
    }
};

pub const Vector3 = extern struct {
    x: f32,
    y: f32,
    z: f32,

    pub fn init(x: f32, y: f32, z: f32) Vector3 {
        return Vector3{ .x = x, .y = y, .z = z };
    }
};

pub const Vector4 = extern struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32,

    pub fn init(x: f32, y: f32, z: f32, w: f32) Vector4 {
        return Vector4{ .x = x, .y = y, .z = z, .w = w };
    }
};
pub const Quaternion = Vector4;

pub const Matrix = extern struct {
    m0: f32,
    m4: f32,
    m8: f32,
    m12: f32,
    m1: f32,
    m5: f32,
    m9: f32,
    m13: f32,
    m2: f32,
    m6: f32,
    m10: f32,
    m14: f32,
    m3: f32,
    m7: f32,
    m11: f32,
    m15: f32,
};

pub const Color = extern struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,

    pub const light_gray = Color.init(200, 200, 200, 255);
    pub const gray = Color.init(130, 130, 130, 255);
    pub const dark_gray = Color.init(80, 80, 80, 255);
    pub const yellow = Color.init(253, 249, 0, 255);
    pub const gold = Color.init(255, 203, 0, 255);
    pub const orange = Color.init(255, 161, 0, 255);
    pub const pink = Color.init(255, 109, 194, 255);
    pub const red = Color.init(230, 41, 55, 255);
    pub const maroon = Color.init(190, 33, 55, 255);
    pub const green = Color.init(0, 228, 48, 255);
    pub const lime = Color.init(0, 158, 47, 255);
    pub const dark_green = Color.init(0, 117, 44, 255);
    pub const sky_blue = Color.init(102, 191, 255, 255);
    pub const blue = Color.init(0, 121, 241, 255);
    pub const dark_blue = Color.init(0, 82, 172, 255);
    pub const purple = Color.init(200, 122, 255, 255);
    pub const violet = Color.init(135, 60, 190, 255);
    pub const dark_purple = Color.init(112, 31, 126, 255);
    pub const beige = Color.init(211, 176, 131, 255);
    pub const brown = Color.init(127, 106, 79, 255);
    pub const dark_brown = Color.init(76, 63, 47, 255);

    pub const white = Color.init(255, 255, 255, 255);
    pub const black = Color.init(0, 0, 0, 255);
    pub const blank = Color.init(0, 0, 0, 0);
    pub const magenta = Color.init(255, 0, 255, 255);
    pub const ray_white = Color.init(245, 245, 245, 255);

    pub fn init(r: u8, g: u8, b: u8, a: u8) Color {
        return Color{ .r = r, .g = g, .b = b, .a = a };
    }

    pub fn fromNormalized(normalized: Vector4) Color {
        return rl.colorFromNormalized(normalized);
    }

    pub fn fromHSV(hue: f32, saturation: f32, value: f32) Color {
        return rl.colorFromHSV(hue, saturation, value);
    }

    pub fn fromInt(hexValue: u32) Color {
        return rl.getColor(hexValue);
    }

    pub fn fade(self: Color, a: f32) Color {
        return rl.fade(self, a);
    }

    pub fn tint(self: Color, t: Color) Color {
        return rl.colorTint(self, t);
    }

    pub fn normalize(self: Color) Vector4 {
        return rl.colorNormalize(self);
    }

    pub fn brightness(self: Color, factor: f32) Color {
        return rl.colorBrightness(self, factor);
    }

    pub fn constrast(self: Color, c: f32) Color {
        return rl.colorContrast(self, c);
    }

    pub fn alpha(self: Color, a: f32) Color {
        return rl.colorAlpha(self, a);
    }

    pub fn toInt(self: Color) i32 {
        return rl.colorToInt(self);
    }

    pub fn toHSV(self: Color) Vector3 {
        return rl.colorToHSV(self);
    }
};

pub const Rectangle = extern struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,

    pub fn init(x: f32, y: f32, width: f32, height: f32) Rectangle {
        return Rectangle{ .x = x, .y = y, .width = width, .height = height };
    }

    pub fn checkCollision(self: Rectangle, rec2: Rectangle) bool {
        return rl.checkCollisionRecs(self, rec2);
    }

    pub fn getCollision(self: Rectangle, rec2: Rectangle) Rectangle {
        return rl.getCollisionRec(self, rec2);
    }
};

pub const Image = extern struct {
    data: *anyopaque,
    width: c_int,
    height: c_int,
    mipmaps: c_int,
    format: PixelFormat,

    pub fn init(fileName: [:0]const u8) Image {
        return rl.loadImage(fileName);
    }

    pub fn initRaw(fileName: [:0]const u8, width: i32, height: i32, format: PixelFormat, headerSize: i32) Image {
        return rl.loadImageRaw(fileName, width, height, @intFromEnum(format), headerSize);
    }

    pub fn initAnim(fileName: [:0]const u8, frames: *i32) Image {
        return rl.loadImageAnim(fileName, frames);
    }

    pub fn fromTexture(texture: Texture) Image {
        return rl.loadImageFromTexture(texture);
    }

    pub fn fromScreen() Image {
        return rl.loadImageFromScreen();
    }

    pub fn unload(self: Image) void {
        rl.unloadImage(self);
    }

    pub fn initText(text: [:0]const u8, fontSize: i32, color: Color) Image {
        return rl.imageText(text, fontSize, color);
    }

    pub fn initTextEx(font: Font, text: [:0]const u8, fontSize: f32, spacing: f32, t: Color) Image {
        return rl.imageTextEx(font, text, fontSize, spacing, t);
    }

    pub fn genColor(width: i32, height: i32, color: Color) Image {
        return rl.genImageColor(width, height, color);
    }

    pub fn genGradientLinear(width: i32, height: i32, direction: i32, start: Color, end: Color) Image {
        return rl.genImageGradientLinear(width, height, direction, start, end);
    }

    pub fn genGradientRadial(width: i32, height: i32, density: f32, inner: Color, outer: Color) Image {
        return rl.genImageGradientRadial(width, height, density, inner, outer);
    }

    pub fn genGradientSquare(width: i32, height: i32, density: f32, inner: Color, outer: Color) Image {
        return rl.genImageGradientSquare(width, height, density, inner, outer);
    }

    pub fn genChecked(width: i32, height: i32, checksX: i32, checksY: i32, col1: Color, col2: Color) Image {
        return rl.genImageChecked(width, height, checksX, checksY, col1, col2);
    }

    pub fn genWhiteNoise(width: i32, height: i32, factor: f32) Image {
        return rl.genImageWhiteNoise(width, height, factor);
    }

    pub fn genPerlinNoise(width: i32, height: i32, offsetX: i32, offsetY: i32, scale: f32) Image {
        return rl.genImagePerlinNoise(width, height, offsetX, offsetY, scale);
    }

    pub fn genCellular(width: i32, height: i32, tileSize: i32) Image {
        return rl.genImageCellular(width, height, tileSize);
    }

    pub fn genText(width: i32, height: i32, text: [:0]const u8) Image {
        return rl.genImageText(width, height, text);
    }

    pub fn copy(self: Image) Image {
        return rl.imageCopy(self);
    }

    pub fn copyRec(self: Image, rec: Rectangle) Image {
        return rl.imageFromImage(self, rec);
    }

    // @todo: use PixelFormat enum for newFormat
    pub fn setFormat(self: *Image, newFormat: i32) void {
        return rl.imageFormat(self, newFormat);
    }

    pub fn toPOT(self: *Image, fill: Color) void {
        rl.imageToPOT(self, fill);
    }

    pub fn crop(self: *Image, c: Rectangle) void {
        rl.imageCrop(self, c);
    }

    pub fn alphaCrop(self: *Image, threshold: f32) void {
        rl.imageAlphaCrop(self, threshold);
    }

    pub fn alphaClear(self: *Image, color: Color, threshold: f32) void {
        rl.imageAlphaClear(self, color, threshold);
    }

    pub fn alphaMask(self: *Image, am: Image) void {
        rl.imageAlphaMask(self, am);
    }

    pub fn alphaPremultiply(self: *Image) void {
        rl.imageAlphaPremultiply(self);
    }

    pub fn blurGaussian(self: *Image, blurSize: i32) void {
        rl.imageBlurGaussian(self, blurSize);
    }

    pub fn resize(self: *Image, newWidth: i32, newHeight: i32) void {
        rl.imageResize(self, newWidth, newHeight);
    }

    pub fn resizeNN(self: *Image, newWidth: i32, newHeight: i32) void {
        rl.imageResizeNN(self, newWidth, newHeight);
    }

    pub fn resizeCanvas(self: *Image, newWidth: i32, newHeight: i32, offsetX: i32, offsetY: i32, fill: Color) void {
        rl.imageResizeCanvas(self, newWidth, newHeight, offsetX, offsetY, fill);
    }

    pub fn mimaps(self: *Image) void {
        rl.imageMipmaps(self);
    }

    pub fn dither(self: *Image, rBpp: i32, gBpp: i32, bBpp: i32, aBpp: i32) void {
        rl.imageDither(self, rBpp, gBpp, bBpp, aBpp);
    }

    pub fn flipVertical(self: *Image) void {
        rl.imageFlipVertical(self);
    }

    pub fn flipHorizontal(self: *Image) void {
        rl.imageFlipHorizontal(self);
    }

    pub fn rotate(self: *Image, degrees: i32) void {
        rl.imageRotate(self, degrees);
    }

    pub fn rotateCW(self: *Image) void {
        rl.imageRotateCW(self);
    }

    pub fn rotateCCW(self: *Image) void {
        rl.imageRotateCCW(self);
    }

    pub fn tint(self: *Image, color: Color) void {
        rl.imageColorTint(self, color);
    }

    pub fn invert(self: *Image) void {
        rl.imageColorInvert(self);
    }

    pub fn grayscale(self: *Image) void {
        rl.imageColorGrayscale(self);
    }

    pub fn contrast(self: *Image, c: f32) void {
        rl.imageColorContrast(self, c);
    }

    pub fn brightness(self: *Image, b: i32) void {
        rl.imageColorBrightness(self, @as(c_int, b));
    }

    pub fn replaceColor(self: *Image, color: Color, replace: Color) void {
        rl.imageColorReplace(self, color, replace);
    }

    pub fn getAlphaBorder(self: Image, threshold: f32) Rectangle {
        return rl.getImageAlphaBorder(self, threshold);
    }

    pub fn getColor(self: Image, x: i32, y: i32) Color {
        return rl.getImageColor(self, x, y);
    }

    pub fn clearBackground(self: *Image, color: Color) void {
        rl.imageClearBackground(self, color);
    }

    pub fn drawPixel(self: *Image, posX: i32, posY: i32, color: Color) void {
        rl.imageDrawPixel(self, posX, posY, color);
    }

    pub fn drawPixelV(self: *Image, position: Vector2, color: Color) void {
        rl.imageDrawPixelV(self, position, color);
    }

    pub fn drawLine(self: *Image, startPosX: i32, startPosY: i32, endPosX: i32, endPosY: i32, color: Color) void {
        rl.imageDrawLine(self, startPosX, startPosY, endPosX, endPosY, color);
    }

    pub fn drawLineV(self: *Image, start: Vector2, end: Vector2, color: Color) void {
        rl.imageDrawLineV(self, start, end, color);
    }

    pub fn drawCircle(self: *Image, centerX: i32, centerY: i32, radius: i32, color: Color) void {
        rl.imageDrawCircle(self, centerX, centerY, radius, color);
    }

    pub fn drawCircleV(self: *Image, center: Vector2, radius: i32, color: Color) void {
        rl.imageDrawCircleV(self, center, radius, color);
    }

    pub fn drawCircleLines(self: *Image, centerX: i32, centerY: i32, radius: i32, color: Color) void {
        rl.imageDrawCircleLines(self, centerX, centerY, radius, color);
    }

    pub fn drawCircleLinesV(self: *Image, center: Vector2, radius: i32, color: Color) void {
        rl.imageDrawCircleLinesV(self, center, radius, color);
    }

    pub fn drawRectangle(self: *Image, posX: i32, posY: i32, width: i32, height: i32, color: Color) void {
        rl.imageDrawRectangle(self, posX, posY, width, height, color);
    }

    pub fn drawRectangleV(self: *Image, position: Vector2, size: Vector2, color: Color) void {
        rl.imageDrawRectangleV(self, position, size, color);
    }

    pub fn drawRectangleRec(self: *Image, rec: Rectangle, color: Color) void {
        rl.imageDrawRectangleRec(self, rec, color);
    }

    pub fn drawRectangleLines(self: *Image, rec: Rectangle, thick: i32, color: Color) void {
        rl.imageDrawRectangleLines(self, rec, thick, color);
    }

    pub fn drawImage(self: *Image, src: Image, srcRec: Rectangle, dstRec: Rectangle, t: Color) void {
        rl.imageDraw(self, src, srcRec, dstRec, t);
    }

    pub fn drawText(self: *Image, text: [:0]const u8, posX: i32, posY: i32, fontSize: i32, color: Color) void {
        rl.imageDrawText(self, text, posX, posY, fontSize, color);
    }

    pub fn drawTextEx(self: *Image, font: Font, text: [:0]const u8, position: Vector2, fontSize: f32, spacing: f32, t: Color) void {
        rl.imageDrawTextEx(self, font, text, position, fontSize, spacing, t);
    }

    pub fn exportToFile(self: Image, fileName: [:0]const u8) bool {
        return rl.exportImage(self, fileName);
    }

    pub fn exportAsCode(self: Image, fileName: [:0]const u8) bool {
        return rl.exportImageAsCode(self, fileName);
    }

    pub fn useAsWindowIcon(self: Image) void {
        rl.setWindowIcon(self);
    }

    pub fn toTexture(self: Image) Texture {
        return Texture.fromImage(self);
    }

    // @todo: use CubemapLayout enum for layout
    pub fn asCubemap(self: Image, layout: i32) Texture {
        return Texture.fromCubemap(self, layout);
    }
};

pub const Texture = extern struct {
    id: c_uint,
    width: c_int,
    height: c_int,
    mipmaps: c_int,
    format: PixelFormat,

    pub fn init(fileName: [:0]const u8) Texture {
        return rl.loadTexture(fileName);
    }

    pub fn fromImage(image: Image) Texture {
        return rl.loadTextureFromImage(image);
    }

    pub fn fromCubemap(image: Image, layout: i32) Texture {
        return rl.loadTextureCubemap(image, layout);
    }

    pub fn unload(self: Texture) void {
        rl.unloadTexture(self);
    }

    pub fn draw(self: Texture, posX: i32, posY: i32, tint: Color) void {
        rl.drawTexture(self, posX, posY, tint);
    }

    pub fn drawV(self: Texture, position: Vector2, tint: Color) void {
        rl.drawTextureV(self, position, tint);
    }

    pub fn drawEx(self: Texture, position: Vector2, rotation: f32, scale: f32, tint: Color) void {
        rl.drawTextureEx(self, position, rotation, scale, tint);
    }

    pub fn drawRec(self: Texture, source: Rectangle, position: Vector2, tint: Color) void {
        rl.drawTextureRec(self, source, position, tint);
    }

    pub fn drawPro(self: Texture, source: Rectangle, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) void {
        rl.drawTexturePro(self, source, dest, origin, rotation, tint);
    }

    pub fn drawNPatch(self: Texture, nPatchInfo: NPatchInfo, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) void {
        rl.drawTextureNPatch(self, nPatchInfo, dest, origin, rotation, tint);
    }
};
pub const Texture2D = Texture;
pub const TextureCubemap = Texture;

pub const RenderTexture = extern struct {
    id: c_uint,
    texture: Texture,
    depth: Texture,

    pub fn init(width: i32, height: i32) RenderTexture {
        return rl.loadRenderTexture(width, height);
    }

    pub fn unload(self: RenderTexture) void {
        rl.unloadRenderTexture(self);
    }

    pub fn begin(self: RenderTexture2D) void {
        rl.beginTextureMode(self);
    }

    pub fn end(_: RenderTexture2D) void {
        rl.endTextureMode();
    }
};
pub const RenderTexture2D = RenderTexture;

pub const NPatchInfo = extern struct {
    source: Rectangle,
    left: c_int,
    top: c_int,
    right: c_int,
    bottom: c_int,
    layout: c_int,
};

pub const GlyphInfo = extern struct {
    value: c_int,
    offsetX: c_int,
    offsetY: c_int,
    advanceX: c_int,
    image: Image,
};

pub const Font = extern struct {
    baseSize: c_int,
    glyphCount: c_int,
    glyphPadding: c_int,
    texture: Texture2D,
    recs: [*c]Rectangle,
    glyphs: [*c]GlyphInfo,

    pub fn init(fileName: [:0]const u8) Font {
        return rl.loadFont(fileName);
    }

    pub fn initEx(fileName: [:0]const u8, fontSize: i32, fontChars: []i32) Font {
        return rl.loadFontEx(fileName, fontSize, fontChars);
    }

    pub fn fromImage(image: Image, key: Color, firstChar: i32) Font {
        return rl.loadFontFromImage(image, key, firstChar);
    }

    pub fn fromMemory(fileType: [:0]const u8, fileData: ?[]const u8, fontSize: i32, fontChars: []i32) Font {
        return rl.loadFontFromMemory(fileType, fileData, fontSize, fontChars);
    }

    pub fn unload(self: Font) void {
        rl.unloadFont(self);
    }

    pub fn isReady(self: Font) bool {
        return rl.isFontReady(self);
    }

    pub fn exportAsCode(self: Font, fileName: [:0]const u8) bool {
        return rl.exportFontAsCode(self, fileName);
    }
};

pub const Camera3D = extern struct {
    position: Vector3,
    target: Vector3,
    up: Vector3,
    fovy: f32,
    projection: CameraProjection,

    pub fn begin(self: Camera3D) void {
        rl.beginMode3D(self);
    }

    pub fn update(self: *Camera3D, mode: rl.CameraMode) void {
        rl.updateCamera(self, mode);
    }

    pub fn getMatrix(self: Camera3D) Matrix {
        return rl.getCameraMatrix(self);
    }

    pub fn end(_: Camera3D) void {
        rl.endMode3D();
    }
};
pub const Camera = Camera3D;

pub const Camera2D = extern struct {
    offset: Vector2,
    target: Vector2,
    rotation: f32,
    zoom: f32,

    pub fn begin(self: Camera2D) void {
        rl.beginMode2D(self);
    }

    pub fn getMatrix(self: Camera2D) Matrix {
        return rl.getCameraMatrix2D(self);
    }

    pub fn end(_: Camera2D) void {
        rl.endMode2D();
    }
};

pub const Mesh = extern struct {
    vertexCount: c_int,
    triangleCount: c_int,
    vertices: [*c]f32,
    texcoords: [*c]f32,
    texcoords2: [*c]f32,
    normals: [*c]f32,
    tangents: [*c]f32,
    colors: [*c]u8,
    indices: [*c]c_ushort,
    animVertices: [*c]f32,
    animNormals: [*c]f32,
    boneIds: [*c]u8,
    boneWeights: [*c]f32,
    vaoId: c_uint,
    vboId: [*c]c_uint,

    pub fn draw(self: Mesh, material: Material, transform: Matrix) void {
        rl.drawMesh(self, material, transform);
    }

    pub fn drawInstanced(self: Mesh, material: Material, transforms: []const Matrix) void {
        rl.drawMeshInstanced(self, material, transforms);
    }
};

pub const Shader = extern struct {
    id: c_uint,
    locs: [*c]c_int,

    pub fn activate(self: Shader) void {
        rl.beginShaderMode(self);
    }

    pub fn deactivate(_: Shader) void {
        rl.endShaderMode();
    }
};

pub const MaterialMap = extern struct {
    texture: Texture2D,
    color: Color,
    value: f32,
};

pub const Material = extern struct {
    shader: Shader,
    maps: [*c]MaterialMap,
    params: [4]f32,
};

pub const Transform = extern struct {
    translation: Vector3,
    rotation: Quaternion,
    scale: Vector3,
};

pub const BoneInfo = extern struct {
    name: [32]u8,
    parent: c_int,
};

pub const Model = extern struct {
    transform: Matrix,
    meshCount: c_int,
    materialCount: c_int,
    meshes: [*c]Mesh,
    materials: [*c]Material,
    meshMaterial: [*c]c_int,
    boneCount: c_int,
    bones: [*c]BoneInfo,
    bindPose: [*c]Transform,

    pub fn init(fileName: [:0]const u8) Model {
        return rl.loadModel(fileName);
    }

    pub fn fromMesh(mesh: Mesh) Model {
        return rl.loadModelFromMesh(mesh);
    }

    pub fn unload(self: Model) void {
        rl.unloadModel(self);
    }

    pub fn draw(self: Model, position: Vector3, scale: f32, tint: Color) void {
        return rl.drawModel(self, position, scale, tint);
    }

    pub fn drawEx(self: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: f32, scale: Vector3, tint: Color) void {
        return rl.drawModelEx(self, position, rotationAxis, rotationAngle, scale, tint);
    }

    pub fn drawWires(self: Model, position: Vector3, scale: f32, tint: Color) void {
        return rl.drawModelWires(self, position, scale, tint);
    }

    pub fn drawWiresEx(self: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: f32, scale: Vector3, tint: Color) void {
        return rl.drawModelWiresEx(self, position, rotationAxis, rotationAngle, scale, tint);
    }
};

pub const ModelAnimation = extern struct {
    boneCount: c_int,
    frameCount: c_int,
    bones: [*c]BoneInfo,
    framePoses: [*c][*c]Transform,
    name: [32]u8,
};

pub const Ray = extern struct {
    position: Vector3,
    direction: Vector3,
};

pub const RayCollision = extern struct {
    hit: bool,
    distance: f32,
    point: Vector3,
    normal: Vector3,
};

pub const BoundingBox = extern struct {
    min: Vector3,
    max: Vector3,
};

pub const Wave = extern struct {
    frameCount: c_uint,
    sampleRate: c_uint,
    sampleSize: c_uint,
    channels: c_uint,
    data: *anyopaque,
};

pub const rAudioBuffer = opaque {};
pub const rAudioProcessor = opaque {};

pub const AudioStream = extern struct {
    buffer: *rAudioBuffer,
    processor: *rAudioProcessor,
    sampleRate: c_uint,
    sampleSize: c_uint,
    channels: c_uint,
};

pub const Sound = extern struct {
    stream: AudioStream,
    frameCount: c_uint,
};

pub const Music = extern struct {
    stream: AudioStream,
    frameCount: c_uint,
    looping: bool,
    ctxType: c_int,
    ctxData: *anyopaque,
};

pub const VrDeviceInfo = extern struct {
    hResolution: c_int,
    vResolution: c_int,
    hScreenSize: f32,
    vScreenSize: f32,
    vScreenCenter: f32,
    eyeToScreenDistance: f32,
    lensSeparationDistance: f32,
    interpupillaryDistance: f32,
    lensDistortionValues: [4]f32,
    chromaAbCorrection: [4]f32,
};

pub const VrStereoConfig = extern struct {
    projection: [2]Matrix,
    viewOffset: [2]Matrix,
    leftLensCenter: [2]f32,
    rightLensCenter: [2]f32,
    leftScreenCenter: [2]f32,
    rightScreenCenter: [2]f32,
    scale: [2]f32,
    scaleIn: [2]f32,
};

pub const FilePathList = extern struct {
    capacity: c_uint,
    count: c_uint,
    paths: [*c][*c]u8,
};

pub const ConfigFlags = enum(c_int) {
    flag_fullscreen_mode = 2,
    flag_window_resizable = 4,
    flag_window_undecorated = 8,
    flag_window_transparent = 16,
    flag_msaa_4x_hint = 32,
    flag_vsync_hint = 64,
    flag_window_hidden = 128,
    flag_window_always_run = 256,
    flag_window_minimized = 512,
    flag_window_maximized = 1024,
    flag_window_unfocused = 2048,
    flag_window_topmost = 4096,
    flag_window_highdpi = 8192,
    flag_window_mouse_passthrough = 16384,
    flag_borderless_windowed_mode = 32768,
    flag_interlaced_hint = 65536,
    _,
};

pub const TraceLogLevel = enum(c_int) {
    log_all = 0,
    log_trace = 1,
    log_debug = 2,
    log_info = 3,
    log_warning = 4,
    log_error = 5,
    log_fatal = 6,
    log_none = 7,
};

pub const KeyboardKey = enum(c_int) {
    key_null = 0,
    key_apostrophe = 39,
    key_comma = 44,
    key_minus = 45,
    key_period = 46,
    key_slash = 47,
    key_zero = 48,
    key_one = 49,
    key_two = 50,
    key_three = 51,
    key_four = 52,
    key_five = 53,
    key_six = 54,
    key_seven = 55,
    key_eight = 56,
    key_nine = 57,
    key_semicolon = 59,
    key_equal = 61,
    key_a = 65,
    key_b = 66,
    key_c = 67,
    key_d = 68,
    key_e = 69,
    key_f = 70,
    key_g = 71,
    key_h = 72,
    key_i = 73,
    key_j = 74,
    key_k = 75,
    key_l = 76,
    key_m = 77,
    key_n = 78,
    key_o = 79,
    key_p = 80,
    key_q = 81,
    key_r = 82,
    key_s = 83,
    key_t = 84,
    key_u = 85,
    key_v = 86,
    key_w = 87,
    key_x = 88,
    key_y = 89,
    key_z = 90,
    key_space = 32,
    key_escape = 256,
    key_enter = 257,
    key_tab = 258,
    key_backspace = 259,
    key_insert = 260,
    key_delete = 261,
    key_right = 262,
    key_left = 263,
    key_down = 264,
    key_up = 265,
    key_page_up = 266,
    key_page_down = 267,
    key_home = 268,
    key_end = 269,
    key_caps_lock = 280,
    key_scroll_lock = 281,
    key_num_lock = 282,
    key_print_screen = 283,
    key_pause = 284,
    key_f1 = 290,
    key_f2 = 291,
    key_f3 = 292,
    key_f4 = 293,
    key_f5 = 294,
    key_f6 = 295,
    key_f7 = 296,
    key_f8 = 297,
    key_f9 = 298,
    key_f10 = 299,
    key_f11 = 300,
    key_f12 = 301,
    key_left_shift = 340,
    key_left_control = 341,
    key_left_alt = 342,
    key_left_super = 343,
    key_right_shift = 344,
    key_right_control = 345,
    key_right_alt = 346,
    key_right_super = 347,
    key_kb_menu = 348,
    key_left_bracket = 91,
    key_backslash = 92,
    key_right_bracket = 93,
    key_grave = 96,
    key_kp_0 = 320,
    key_kp_1 = 321,
    key_kp_2 = 322,
    key_kp_3 = 323,
    key_kp_4 = 324,
    key_kp_5 = 325,
    key_kp_6 = 326,
    key_kp_7 = 327,
    key_kp_8 = 328,
    key_kp_9 = 329,
    key_kp_decimal = 330,
    key_kp_divide = 331,
    key_kp_multiply = 332,
    key_kp_subtract = 333,
    key_kp_add = 334,
    key_kp_enter = 335,
    key_kp_equal = 336,
    key_back = 4,
    //key_menu = 82,
    key_volume_up = 24,
    key_volume_down = 25,
};

pub const MouseButton = enum(c_int) {
    mouse_button_left = 0,
    mouse_button_right = 1,
    mouse_button_middle = 2,
    mouse_button_side = 3,
    mouse_button_extra = 4,
    mouse_button_forward = 5,
    mouse_button_back = 6,
};

pub const MouseCursor = enum(c_int) {
    mouse_cursor_default = 0,
    mouse_cursor_arrow = 1,
    mouse_cursor_ibeam = 2,
    mouse_cursor_crosshair = 3,
    mouse_cursor_pointing_hand = 4,
    mouse_cursor_resize_ew = 5,
    mouse_cursor_resize_ns = 6,
    mouse_cursor_resize_nwse = 7,
    mouse_cursor_resize_nesw = 8,
    mouse_cursor_resize_all = 9,
    mouse_cursor_not_allowed = 10,
};

pub const GamepadButton = enum(c_int) {
    gamepad_button_unknown = 0,
    gamepad_button_left_face_up = 1,
    gamepad_button_left_face_right = 2,
    gamepad_button_left_face_down = 3,
    gamepad_button_left_face_left = 4,
    gamepad_button_right_face_up = 5,
    gamepad_button_right_face_right = 6,
    gamepad_button_right_face_down = 7,
    gamepad_button_right_face_left = 8,
    gamepad_button_left_trigger_1 = 9,
    gamepad_button_left_trigger_2 = 10,
    gamepad_button_right_trigger_1 = 11,
    gamepad_button_right_trigger_2 = 12,
    gamepad_button_middle_left = 13,
    gamepad_button_middle = 14,
    gamepad_button_middle_right = 15,
    gamepad_button_left_thumb = 16,
    gamepad_button_right_thumb = 17,
};

pub const GamepadAxis = enum(c_int) {
    gamepad_axis_left_x = 0,
    gamepad_axis_left_y = 1,
    gamepad_axis_right_x = 2,
    gamepad_axis_right_y = 3,
    gamepad_axis_left_trigger = 4,
    gamepad_axis_right_trigger = 5,
};

pub const MaterialMapIndex = enum(c_int) {
    material_map_albedo = 0,
    material_map_metalness = 1,
    material_map_normal = 2,
    material_map_roughness = 3,
    material_map_occlusion = 4,
    material_map_emission = 5,
    material_map_height = 6,
    material_map_cubemap = 7,
    material_map_irradiance = 8,
    material_map_prefilter = 9,
    material_map_brdf = 10,
};

pub const ShaderLocationIndex = enum(c_int) {
    shader_loc_vertex_position = 0,
    shader_loc_vertex_texcoord01 = 1,
    shader_loc_vertex_texcoord02 = 2,
    shader_loc_vertex_normal = 3,
    shader_loc_vertex_tangent = 4,
    shader_loc_vertex_color = 5,
    shader_loc_matrix_mvp = 6,
    shader_loc_matrix_view = 7,
    shader_loc_matrix_projection = 8,
    shader_loc_matrix_model = 9,
    shader_loc_matrix_normal = 10,
    shader_loc_vector_view = 11,
    shader_loc_color_diffuse = 12,
    shader_loc_color_specular = 13,
    shader_loc_color_ambient = 14,
    shader_loc_map_albedo = 15,
    shader_loc_map_metalness = 16,
    shader_loc_map_normal = 17,
    shader_loc_map_roughness = 18,
    shader_loc_map_occlusion = 19,
    shader_loc_map_emission = 20,
    shader_loc_map_height = 21,
    shader_loc_map_cubemap = 22,
    shader_loc_map_irradiance = 23,
    shader_loc_map_prefilter = 24,
    shader_loc_map_brdf = 25,
};

pub const ShaderUniformDataType = enum(c_int) {
    shader_uniform_float = 0,
    shader_uniform_vec2 = 1,
    shader_uniform_vec3 = 2,
    shader_uniform_vec4 = 3,
    shader_uniform_int = 4,
    shader_uniform_ivec2 = 5,
    shader_uniform_ivec3 = 6,
    shader_uniform_ivec4 = 7,
    shader_uniform_sampler2d = 8,
};

pub const ShaderAttribute = enum(c_int) {
    shader_attrib_float = 0,
    shader_attrib_vec2 = 1,
    shader_attrib_vec3 = 2,
    shader_attrib_vec4 = 3,
};

pub const PixelFormat = enum(c_int) {
    pixelformat_uncompressed_grayscale = 1,
    pixelformat_uncompressed_gray_alpha = 2,
    pixelformat_uncompressed_r5g6b5 = 3,
    pixelformat_uncompressed_r8g8b8 = 4,
    pixelformat_uncompressed_r5g5b5a1 = 5,
    pixelformat_uncompressed_r4g4b4a4 = 6,
    pixelformat_uncompressed_r8g8b8a8 = 7,
    pixelformat_uncompressed_r32 = 8,
    pixelformat_uncompressed_r32g32b32 = 9,
    pixelformat_uncompressed_r32g32b32a32 = 10,
    pixelformat_compressed_dxt1_rgb = 11,
    pixelformat_compressed_dxt1_rgba = 12,
    pixelformat_compressed_dxt3_rgba = 13,
    pixelformat_compressed_dxt5_rgba = 14,
    pixelformat_compressed_etc1_rgb = 15,
    pixelformat_compressed_etc2_rgb = 16,
    pixelformat_compressed_etc2_eac_rgba = 17,
    pixelformat_compressed_pvrt_rgb = 18,
    pixelformat_compressed_pvrt_rgba = 19,
    pixelformat_compressed_astc_4x4_rgba = 20,
    pixelformat_compressed_astc_8x8_rgba = 21,
};

pub const TextureFilter = enum(c_int) {
    texture_filter_point = 0,
    texture_filter_bilinear = 1,
    texture_filter_trilinear = 2,
    texture_filter_anisotropic_4x = 3,
    texture_filter_anisotropic_8x = 4,
    texture_filter_anisotropic_16x = 5,
};

pub const TextureWrap = enum(c_int) {
    texture_wrap_repeat = 0,
    texture_wrap_clamp = 1,
    texture_wrap_mirror_repeat = 2,
    texture_wrap_mirror_clamp = 3,
};

pub const CubemapLayout = enum(c_int) {
    cubemap_layout_auto_detect = 0,
    cubemap_layout_line_vertical = 1,
    cubemap_layout_line_horizontal = 2,
    cubemap_layout_cross_three_by_four = 3,
    cubemap_layout_cross_four_by_three = 4,
    cubemap_layout_panorama = 5,
};

pub const FontType = enum(c_int) {
    font_default = 0,
    font_bitmap = 1,
    font_sdf = 2,
};

pub const BlendMode = enum(c_int) {
    blend_alpha = 0,
    blend_additive = 1,
    blend_multiplied = 2,
    blend_add_colors = 3,
    blend_subtract_colors = 4,
    blend_alpha_premultiply = 5,
    blend_custom = 6,
    blend_custom_separate = 7,
};

pub const Gesture = enum(c_int) {
    gesture_none = 0,
    gesture_tap = 1,
    gesture_doubletap = 2,
    gesture_hold = 4,
    gesture_drag = 8,
    gesture_swipe_right = 16,
    gesture_swipe_left = 32,
    gesture_swipe_up = 64,
    gesture_swipe_down = 128,
    gesture_pinch_in = 256,
    gesture_pinch_out = 512,
};

pub const CameraMode = enum(c_int) {
    camera_custom = 0,
    camera_free = 1,
    camera_orbital = 2,
    camera_first_person = 3,
    camera_third_person = 4,
};

pub const CameraProjection = enum(c_int) {
    camera_perspective = 0,
    camera_orthographic = 1,
};

pub const NPatchType = enum(c_int) {
    npatch_nine_patch = 0,
    npatch_three_patch_vertical = 1,
    npatch_three_patch_horizontal = 2,
};

// pub const TraceLogCallback = ?fn (c_int, [*c]const u8, [*c]struct___va_list_tag) callconv(.C) void;
pub const LoadFileDataCallback = *const fn ([*c]const u8, [*c]c_uint) callconv(.C) [*c]u8;
pub const SaveFileDataCallback = *const fn ([*c]const u8, ?*anyopaque, c_uint) callconv(.C) bool;
pub const LoadFileTextCallback = *const fn ([*c]const u8) callconv(.C) [*c]u8;
pub const SaveFileTextCallback = *const fn ([*c]const u8, [*c]u8) callconv(.C) bool;
pub const AudioCallback = ?*const fn (?*anyopaque, c_uint) callconv(.C) void;

pub const AutomationEvent = extern struct {
    frame: c_uint = @import("std").mem.zeroes(c_uint),
    type: c_uint = @import("std").mem.zeroes(c_uint),
    params: [4]c_int = @import("std").mem.zeroes([4]c_int),
};
pub const AutomationEventList = extern struct {
    capacity: c_uint = @import("std").mem.zeroes(c_uint),
    count: c_uint = @import("std").mem.zeroes(c_uint),
    events: [*c]AutomationEvent = @import("std").mem.zeroes([*c]AutomationEvent),
};

pub const RAYLIB_VERSION_MAJOR = @as(i32, 4);
pub const RAYLIB_VERSION_MINOR = @as(i32, 6);
pub const RAYLIB_VERSION_PATCH = @as(i32, 0);
pub const RAYLIB_VERSION = "4.6-dev";

pub const MAX_TOUCH_POINTS = 10;
pub const MAX_MATERIAL_MAPS = 12;
pub const MAX_SHADER_LOCATIONS = 32;

pub const MATERIAL_MAP_DIFFUSE = MaterialMapIndex.material_map_albedo;
pub const MATERIAL_MAP_SPECULAR = MaterialMapIndex.material_map_metalness;
pub const SHADER_LOC_MAP_DIFFUSE = ShaderLocationIndex.shader_loc_map_albedo;
pub const SHADER_LOC_MAP_SPECULAR = ShaderLocationIndex.shader_loc_map_metalness;

const cdef = @import("raylib-zig-ext.zig");

pub fn setWindowIcons(images: []Image) void {
    cdef.SetWindowIcons(@as([*c]Image, @ptrCast(images)), @as(c_int, @intCast(images.len)));
}

pub fn loadShader(vsFileName: ?[:0]const u8, fsFileName: ?[:0]const u8) Shader {
    var vsFileNameFinal = @as([*c]const u8, 0);
    var fsFileNameFinal = @as([*c]const u8, 0);
    if (vsFileName) |vsFileNameSure| {
        vsFileNameFinal = @as([*c]const u8, @ptrCast(vsFileNameSure));
    }
    if (fsFileName) |fsFileNameSure| {
        fsFileNameFinal = @as([*c]const u8, @ptrCast(fsFileNameSure));
    }
    return cdef.LoadShader(vsFileNameFinal, fsFileNameFinal);
}

pub fn loadShaderFromMemory(vsCode: ?[:0]const u8, fsCode: ?[:0]const u8) Shader {
    var vsCodeFinal = @as([*c]const u8, 0);
    var fsCodeFinal = @as([*c]const u8, 0);
    if (vsCode) |vsCodeSure| {
        vsCodeFinal = @as([*c]const u8, @ptrCast(vsCodeSure));
    }
    if (fsCode) |fsCodeSure| {
        fsCodeFinal = @as([*c]const u8, @ptrCast(fsCodeSure));
    }
    return cdef.LoadShaderFromMemory(vsCodeFinal, fsCodeFinal);
}

pub fn loadFileData(fileName: [:0]const u8) ![]u8 {
    var bytesRead: i32 = 0;
    var res: []u8 = undefined;

    const ptr = cdef.LoadFileData(@as([*c]const u8, @ptrCast(fileName)), @as([*c]c_uint, @ptrCast(&bytesRead)));
    if (ptr == 0) return RaylibError.GenericError;

    res.ptr = @as([*]u8, @ptrCast(ptr));
    res.len = @as(usize, @intCast(bytesRead));
    return res;
}

pub fn saveFileData(fileName: [:0]const u8, data: []u8) bool {
    return cdef.SaveFileData(@as([*c]const u8, @ptrCast(fileName)), @as(*anyopaque, @ptrCast(data.ptr)), @as(c_uint, @intCast(data.len)));
}

pub fn exportDataAsCode(data: []const u8, fileName: [:0]const u8) bool {
    return cdef.ExportDataAsCode(@as([*c]const u8, @ptrCast(data)), @as(c_uint, @intCast(data.len)), @as([*c]const u8, @ptrCast(fileName)));
}

pub fn compressData(data: []const u8) []u8 {
    var compDataSize: i32 = 0;
    var res: []u8 = undefined;
    res.ptr = cdef.CompressData(@as([*c]const u8, @ptrCast(data)), @as(c_int, @intCast(data.len)), @as([*c]c_int, @ptrCast(&compDataSize)));
    res.len = @as(usize, @intCast(compDataSize));
    return res;
}

pub fn decompressData(compData: []const u8) []u8 {
    var dataSize: i32 = 0;
    var res: []u8 = undefined;
    res.ptr = cdef.DecompressData(@as([*c]const u8, @ptrCast(compData)), @as(c_int, @intCast(compData.len)), @as([*c]c_int, @ptrCast(&dataSize)));
    res.len = @as(usize, @intCast(dataSize));
    return res;
}

pub fn encodeDataBase64(data: []const u8) []u8 {
    var outputSize: i32 = 0;
    var res: []u8 = undefined;
    res.ptr = cdef.EncodeDataBase64(@as([*c]const u8, @ptrCast(data)), @as(c_int, @intCast(data.len)), @as([*c]c_int, @ptrCast(&outputSize)));
    res.len = @as(usize, @intCast(outputSize));
    return res;
}

pub fn decodeDataBase64(data: []const u8) []u8 {
    var outputSize: i32 = 0;
    var res: []u8 = undefined;
    res.ptr = cdef.DecodeDataBase64(@as([*c]const u8, @ptrCast(data)), @as([*c]c_int, @ptrCast(&outputSize)));
    res.len = @as(usize, @intCast(outputSize));
    return res;
}

pub fn loadImageFromMemory(fileType: [:0]const u8, fileData: []const u8) Image {
    return cdef.LoadImageFromMemory(@as([*c]const u8, @ptrCast(fileType)), @as([*c]const u8, @ptrCast(fileData)), @as(c_int, @intCast(fileData.len)));
}

pub fn loadImageColors(image: Image) ![]Color {
    var res: []Color = undefined;

    const ptr = cdef.LoadImageColors(image);
    if (ptr == 0) return RaylibError.GenericError;

    res.ptr = @as([*]Color, @ptrCast(ptr));
    res.len = @as(usize, @intCast(image.width * image.height));
    return res;
}

pub fn loadImagePalette(image: Image, maxPaletteSize: i32) ![]Color {
    var colorCount: i32 = 0;
    var res: []Color = undefined;

    const ptr = cdef.LoadImagePalette(image, @as(c_int, maxPaletteSize), @as([*c]c_int, @ptrCast(&colorCount)));
    if (ptr == 0) return RaylibError.GenericError;

    res.ptr = @as([*]Color, @ptrCast(ptr));
    res.len = @as(usize, @intCast(colorCount));
    return res;
}

pub fn loadFontFromMemory(fileType: [:0]const u8, fileData: ?[]const u8, fontSize: i32, fontChars: []i32) Font {
    var fileDataFinal = @as([*c]const u8, 0);
    var fileDataLen: i32 = 0;
    if (fileData) |fileDataSure| {
        fileDataFinal = @as([*c]const u8, @ptrCast(fileDataSure));
        fileDataLen = @as(i32, @intCast(fileDataSure.len));
    }
    return cdef.LoadFontFromMemory(@as([*c]const u8, @ptrCast(fileType)), @as([*c]const u8, @ptrCast(fileDataFinal)), @as(c_int, @intCast(fileDataLen)), @as(c_int, fontSize), @as([*c]c_int, @ptrCast(fontChars)), @as(c_int, @intCast(fontChars.len)));
}

pub fn loadFontData(fileData: []const u8, fontSize: i32, fontChars: []i32, ty: i32) ![]GlyphInfo {
    var res: []GlyphInfo = undefined;

    const ptr = cdef.LoadFontData(@as([*c]const u8, @ptrCast(fileData)), @as(c_int, @intCast(fileData.len)), @as(c_int, fontSize), @as([*c]c_int, @ptrCast(fontChars)), @as(c_int, @intCast(fontChars.len)), @as(c_int, ty));
    if (ptr == 0) return RaylibError.GenericError;

    res.ptr = @as([*]GlyphInfo, @ptrCast(ptr));
    res.len = @as(usize, @intCast(fontChars.len));
    return res;
}

pub fn loadCodepoints(text: [:0]const u8) ![]i32 {
    if (@sizeOf(c_int) != @sizeOf(i32)) {
        @compileError("Can't cast pointer to c_int array to i32 because they don't have the same size");
    }
    var count: i32 = 0;
    var res: []i32 = undefined;

    const ptr = cdef.LoadCodepoints(@as([*c]const u8, @ptrCast(text)), @as([*c]c_int, @ptrCast(&count)));
    if (ptr == 0) return RaylibError.GenericError;

    res.ptr = @as([*]i32, @ptrCast(ptr));
    res.len = @as(usize, @intCast(count));
    return res;
}

pub fn textFormat(text: [:0]const u8, args: anytype) [:0]const u8 {
    return std.mem.span(@call(.auto, cdef.TextFormat, .{@as([*c]const u8, @ptrCast(text))} ++ args));
}

pub fn textSplit(text: [:0]const u8, delimiter: u8) [][:0]const u8 {
    var count: i32 = 0;
    var res: [][:0]const u8 = undefined;
    res.ptr = @as([*][:0]const u8, @ptrCast(cdef.TextSplit(@as([*c]const u8, @ptrCast(text)), delimiter, @as([*c]c_int, @ptrCast(&count)))));
    res.len = @as(usize, @intCast(count));
    return res;
}

pub fn drawMeshInstanced(mesh: Mesh, material: Material, transforms: []const Matrix) void {
    cdef.DrawMeshInstanced(mesh, material, @as([*c]const Matrix, @ptrCast(transforms)), @as(c_int, @intCast(transforms.len)));
}

pub fn loadMaterials(fileName: [:0]const u8) ![]Material {
    var materialCount: i32 = 0;
    var res: []Material = undefined;

    const ptr = cdef.LoadMaterials(@as([*c]const u8, @ptrCast(fileName)), @as([*c]c_int, @ptrCast(&materialCount)));
    if (ptr == 0) return RaylibError.GenericError;

    res.ptr = @as([*]Material, @ptrCast(ptr));
    res.len = @as(usize, @intCast(materialCount));
    return res;
}

pub fn loadModelAnimations(fileName: [:0]const u8) ![]ModelAnimation {
    var animCount: i32 = 0;
    var res: []ModelAnimation = undefined;

    const ptr = cdef.LoadModelAnimations(@as([*c]const u8, @ptrCast(fileName)), @as([*c]c_uint, @ptrCast(&animCount)));
    if (ptr == 0) return RaylibError.GenericError;

    res.ptr = @as([*]ModelAnimation, @ptrCast(ptr));
    res.len = @as(usize, @intCast(animCount));
    return res;
}

pub fn unloadModelAnimations(animations: []ModelAnimation) void {
    cdef.UnloadModelAnimations(@as([*c]ModelAnimation, @ptrCast(animations)), @as(c_uint, @intCast(animations.len)));
}

pub fn loadWaveFromMemory(fileType: [:0]const u8, fileData: []const u8) Wave {
    return cdef.LoadWaveFromMemory(@as([*c]const u8, @ptrCast(fileType)), @as([*c]const u8, @ptrCast(fileData)), @as(c_int, @intCast(fileData.len)));
}

pub fn loadWaveSamples(wave: Wave) []f32 {
    var res: []f32 = undefined;
    res.ptr = @as([*]f32, @ptrCast(cdef.LoadWaveSamples(wave)));
    res.len = @as(usize, @intCast(wave.frameCount * wave.channels));
    return res;
}

pub fn loadMusicStreamFromMemory(fileType: [:0]const u8, data: []const u8) Music {
    return cdef.LoadMusicStreamFromMemory(@as([*c]const u8, @ptrCast(fileType)), @as([*c]const u8, @ptrCast(data)), @as(c_int, @intCast(data.len)));
}

pub fn drawLineStrip(points: []const Vector2, color: Color) void {
    cdef.DrawLineStrip(@as([*c]Vector2, @ptrCast(points)), @as(c_int, @intCast(points.len)), color);
}

pub fn drawTriangleFan(points: []const Vector2, color: Color) void {
    cdef.DrawTriangleFan(@as([*c]Vector2, @ptrCast(points)), @as(c_int, @intCast(points.len)), color);
}

pub fn drawTriangleStrip(points: []const Vector2, color: Color) void {
    cdef.DrawTriangleStrip(@as([*c]Vector2, @ptrCast(points)), @as(c_int, @intCast(points.len)), color);
}

pub fn checkCollisionPointPoly(point: Vector2, points: []const Vector2) bool {
    return cdef.CheckCollisionPointPoly(point, @as([*c]Vector2, @ptrCast(points)), @as(c_int, @intCast(points.len)));
}

pub fn loadFontEx(fileName: [:0]const u8, fontSize: i32, fontChars: []i32) Font {
    return cdef.LoadFontEx(@as([*c]const u8, @ptrCast(fileName)), @as(c_int, fontSize), @as([*c]c_int, @ptrCast(fontChars)), @as(c_int, @intCast(fontChars.len)));
}

pub fn genImageFontAtlas(chars: []const GlyphInfo, recs: [][]Rectangle, fontSize: i32, padding: i32, packMethod: i32) Image {
    return cdef.GenImageFontAtlas(@as([*c]const GlyphInfo, @ptrCast(chars)), @as([*c][*c]Rectangle, @ptrCast(recs)), @as(c_int, @intCast(recs.len)), @as(c_int, fontSize), @as(c_int, padding), @as(c_int, packMethod));
}

pub fn unloadFontData(chars: []GlyphInfo) void {
    cdef.UnloadFontData(@as([*c]GlyphInfo, @ptrCast(chars)), @as(c_int, @intCast(chars.len)));
}

pub fn loadUTF8(codepoints: []const c_int) [:0]u8 {
    return std.mem.span(cdef.LoadUTF8(@as([*c]const c_int, @ptrCast(codepoints)), @as(c_int, @intCast(codepoints.len))));
}

pub fn textJoin(textList: [][:0]const u8, delimiter: [:0]const u8) [:0]const u8 {
    return std.mem.span(cdef.TextJoin(@as([*c][*c]const u8, @ptrCast(textList)), @as(c_int, @intCast(textList.len)), @as([*c]const u8, @ptrCast(delimiter))));
}

pub fn drawTriangleStrip3D(points: []const Vector3, color: Color) void {
    cdef.DrawTriangleStrip3D(@as([*c]Vector3, @ptrCast(points)), @as(c_int, @intCast(points.len)), color);
}

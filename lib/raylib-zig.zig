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

pub fn drawLineStrip(points: []Vector2, color: Color) void {
    cdef.DrawLineStrip(@as([*c]Vector2, @ptrCast(points)), @as(c_int, @intCast(points.len)), color);
}

pub fn drawTriangleFan(points: []Vector2, color: Color) void {
    cdef.DrawTriangleFan(@as([*c]Vector2, @ptrCast(points)), @as(c_int, @intCast(points.len)), color);
}

pub fn drawTriangleStrip(points: []Vector2, color: Color) void {
    cdef.DrawTriangleStrip(@as([*c]Vector2, @ptrCast(points)), @as(c_int, @intCast(points.len)), color);
}

pub fn checkCollisionPointPoly(point: Vector2, points: []Vector2) bool {
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

pub fn initWindow(width: i32, height: i32, title: [:0]const u8) void {
    cdef.InitWindow(@as(c_int, width), @as(c_int, height), @as([*c]const u8, @ptrCast(title)));
}

pub fn closeWindow() void {
    cdef.CloseWindow();
}

pub fn windowShouldClose() bool {
    return cdef.WindowShouldClose();
}

pub fn isWindowReady() bool {
    return cdef.IsWindowReady();
}

pub fn isWindowFullscreen() bool {
    return cdef.IsWindowFullscreen();
}

pub fn isWindowHidden() bool {
    return cdef.IsWindowHidden();
}

pub fn isWindowMinimized() bool {
    return cdef.IsWindowMinimized();
}

pub fn isWindowMaximized() bool {
    return cdef.IsWindowMaximized();
}

pub fn isWindowFocused() bool {
    return cdef.IsWindowFocused();
}

pub fn isWindowResized() bool {
    return cdef.IsWindowResized();
}

pub fn isWindowState(flag: u32) bool {
    return cdef.IsWindowState(@as(c_uint, flag));
}

pub fn setWindowState(flags: ConfigFlags) void {
    cdef.SetWindowState(flags);
}

pub fn clearWindowState(flags: ConfigFlags) void {
    cdef.ClearWindowState(flags);
}

pub fn toggleFullscreen() void {
    cdef.ToggleFullscreen();
}

pub fn toggleBorderlessWindowed() void {
    cdef.ToggleBorderlessWindowed();
}

pub fn maximizeWindow() void {
    cdef.MaximizeWindow();
}

pub fn minimizeWindow() void {
    cdef.MinimizeWindow();
}

pub fn restoreWindow() void {
    cdef.RestoreWindow();
}

pub fn setWindowIcon(image: Image) void {
    cdef.SetWindowIcon(image);
}

pub fn setWindowTitle(title: [:0]const u8) void {
    cdef.SetWindowTitle(@as([*c]const u8, @ptrCast(title)));
}

pub fn setWindowPosition(x: i32, y: i32) void {
    cdef.SetWindowPosition(@as(c_int, x), @as(c_int, y));
}

pub fn setWindowMonitor(monitor: i32) void {
    cdef.SetWindowMonitor(@as(c_int, monitor));
}

pub fn setWindowMinSize(width: i32, height: i32) void {
    cdef.SetWindowMinSize(@as(c_int, width), @as(c_int, height));
}

pub fn setWindowMaxSize(width: i32, height: i32) void {
    cdef.SetWindowMaxSize(@as(c_int, width), @as(c_int, height));
}

pub fn setWindowSize(width: i32, height: i32) void {
    cdef.SetWindowSize(@as(c_int, width), @as(c_int, height));
}

pub fn setWindowOpacity(opacity: f32) void {
    cdef.SetWindowOpacity(opacity);
}

pub fn setWindowFocused() void {
    cdef.SetWindowFocused();
}

pub fn getWindowHandle() *anyopaque {
    return cdef.GetWindowHandle();
}

pub fn getScreenWidth() i32 {
    return @as(i32, cdef.GetScreenWidth());
}

pub fn getScreenHeight() i32 {
    return @as(i32, cdef.GetScreenHeight());
}

pub fn getRenderWidth() i32 {
    return @as(i32, cdef.GetRenderWidth());
}

pub fn getRenderHeight() i32 {
    return @as(i32, cdef.GetRenderHeight());
}

pub fn getMonitorCount() i32 {
    return @as(i32, cdef.GetMonitorCount());
}

pub fn getCurrentMonitor() i32 {
    return @as(i32, cdef.GetCurrentMonitor());
}

pub fn getMonitorPosition(monitor: i32) Vector2 {
    return cdef.GetMonitorPosition(@as(c_int, monitor));
}

pub fn getMonitorWidth(monitor: i32) i32 {
    return @as(i32, cdef.GetMonitorWidth(@as(c_int, monitor)));
}

pub fn getMonitorHeight(monitor: i32) i32 {
    return @as(i32, cdef.GetMonitorHeight(@as(c_int, monitor)));
}

pub fn getMonitorPhysicalWidth(monitor: i32) i32 {
    return @as(i32, cdef.GetMonitorPhysicalWidth(@as(c_int, monitor)));
}

pub fn getMonitorPhysicalHeight(monitor: i32) i32 {
    return @as(i32, cdef.GetMonitorPhysicalHeight(@as(c_int, monitor)));
}

pub fn getMonitorRefreshRate(monitor: i32) i32 {
    return @as(i32, cdef.GetMonitorRefreshRate(@as(c_int, monitor)));
}

pub fn getWindowPosition() Vector2 {
    return cdef.GetWindowPosition();
}

pub fn getWindowScaleDPI() Vector2 {
    return cdef.GetWindowScaleDPI();
}

pub fn getMonitorName(monitor: i32) [:0]const u8 {
    return std.mem.span(cdef.GetMonitorName(@as(c_int, monitor)));
}

pub fn setClipboardText(text: [:0]const u8) void {
    cdef.SetClipboardText(@as([*c]const u8, @ptrCast(text)));
}

pub fn getClipboardText() [:0]const u8 {
    return std.mem.span(cdef.GetClipboardText());
}

pub fn enableEventWaiting() void {
    cdef.EnableEventWaiting();
}

pub fn disableEventWaiting() void {
    cdef.DisableEventWaiting();
}

pub fn showCursor() void {
    cdef.ShowCursor();
}

pub fn hideCursor() void {
    cdef.HideCursor();
}

pub fn isCursorHidden() bool {
    return cdef.IsCursorHidden();
}

pub fn enableCursor() void {
    cdef.EnableCursor();
}

pub fn disableCursor() void {
    cdef.DisableCursor();
}

pub fn isCursorOnScreen() bool {
    return cdef.IsCursorOnScreen();
}

pub fn clearBackground(color: Color) void {
    cdef.ClearBackground(color);
}

pub fn beginDrawing() void {
    cdef.BeginDrawing();
}

pub fn endDrawing() void {
    cdef.EndDrawing();
}

pub fn beginMode2D(camera: Camera2D) void {
    cdef.BeginMode2D(camera);
}

pub fn endMode2D() void {
    cdef.EndMode2D();
}

pub fn beginMode3D(camera: Camera3D) void {
    cdef.BeginMode3D(camera);
}

pub fn endMode3D() void {
    cdef.EndMode3D();
}

pub fn beginTextureMode(target: RenderTexture2D) void {
    cdef.BeginTextureMode(target);
}

pub fn endTextureMode() void {
    cdef.EndTextureMode();
}

pub fn beginShaderMode(shader: Shader) void {
    cdef.BeginShaderMode(shader);
}

pub fn endShaderMode() void {
    cdef.EndShaderMode();
}

pub fn beginBlendMode(mode: i32) void {
    cdef.BeginBlendMode(@as(c_int, mode));
}

pub fn endBlendMode() void {
    cdef.EndBlendMode();
}

pub fn beginScissorMode(x: i32, y: i32, width: i32, height: i32) void {
    cdef.BeginScissorMode(@as(c_int, x), @as(c_int, y), @as(c_int, width), @as(c_int, height));
}

pub fn endScissorMode() void {
    cdef.EndScissorMode();
}

pub fn beginVrStereoMode(config: VrStereoConfig) void {
    cdef.BeginVrStereoMode(config);
}

pub fn endVrStereoMode() void {
    cdef.EndVrStereoMode();
}

pub fn loadVrStereoConfig(device: VrDeviceInfo) VrStereoConfig {
    return cdef.LoadVrStereoConfig(device);
}

pub fn unloadVrStereoConfig(config: VrStereoConfig) void {
    cdef.UnloadVrStereoConfig(config);
}

pub fn isShaderReady(shader: Shader) bool {
    return cdef.IsShaderReady(shader);
}

pub fn getShaderLocation(shader: Shader, uniformName: [:0]const u8) i32 {
    return @as(i32, cdef.GetShaderLocation(shader, @as([*c]const u8, @ptrCast(uniformName))));
}

pub fn getShaderLocationAttrib(shader: Shader, attribName: [:0]const u8) i32 {
    return @as(i32, cdef.GetShaderLocationAttrib(shader, @as([*c]const u8, @ptrCast(attribName))));
}

pub fn setShaderValue(shader: Shader, locIndex: i32, value: *const anyopaque, uniformType: i32) void {
    cdef.SetShaderValue(shader, @as(c_int, locIndex), value, @as(c_int, uniformType));
}

pub fn setShaderValueV(shader: Shader, locIndex: i32, value: *const anyopaque, uniformType: i32, count: i32) void {
    cdef.SetShaderValueV(shader, @as(c_int, locIndex), value, @as(c_int, uniformType), @as(c_int, count));
}

pub fn setShaderValueMatrix(shader: Shader, locIndex: i32, mat: Matrix) void {
    cdef.SetShaderValueMatrix(shader, @as(c_int, locIndex), mat);
}

pub fn setShaderValueTexture(shader: Shader, locIndex: i32, texture: Texture2D) void {
    cdef.SetShaderValueTexture(shader, @as(c_int, locIndex), texture);
}

pub fn unloadShader(shader: Shader) void {
    cdef.UnloadShader(shader);
}

pub fn getMouseRay(mousePosition: Vector2, camera: Camera) Ray {
    return cdef.GetMouseRay(mousePosition, camera);
}

pub fn getCameraMatrix(camera: Camera) Matrix {
    return cdef.GetCameraMatrix(camera);
}

pub fn getCameraMatrix2D(camera: Camera2D) Matrix {
    return cdef.GetCameraMatrix2D(camera);
}

pub fn getWorldToScreen(position: Vector3, camera: Camera) Vector2 {
    return cdef.GetWorldToScreen(position, camera);
}

pub fn getScreenToWorld2D(position: Vector2, camera: Camera2D) Vector2 {
    return cdef.GetScreenToWorld2D(position, camera);
}

pub fn getWorldToScreenEx(position: Vector3, camera: Camera, width: i32, height: i32) Vector2 {
    return cdef.GetWorldToScreenEx(position, camera, @as(c_int, width), @as(c_int, height));
}

pub fn getWorldToScreen2D(position: Vector2, camera: Camera2D) Vector2 {
    return cdef.GetWorldToScreen2D(position, camera);
}

pub fn setTargetFPS(fps: i32) void {
    cdef.SetTargetFPS(@as(c_int, fps));
}

pub fn getFrameTime() f32 {
    return cdef.GetFrameTime();
}

pub fn getTime() f64 {
    return cdef.GetTime();
}

pub fn getFPS() i32 {
    return @as(i32, cdef.GetFPS());
}

pub fn swapScreenBuffer() void {
    cdef.SwapScreenBuffer();
}

pub fn pollInputEvents() void {
    cdef.PollInputEvents();
}

pub fn waitTime(seconds: f64) void {
    cdef.WaitTime(seconds);
}

pub fn setRandomSeed(seed: u32) void {
    cdef.SetRandomSeed(@as(c_uint, seed));
}

pub fn getRandomValue(min: i32, max: i32) i32 {
    return @as(i32, cdef.GetRandomValue(@as(c_int, min), @as(c_int, max)));
}

pub fn unloadRandomSequence(sequence: []i32) void {
    cdef.UnloadRandomSequence(@as([*c]c_int, @ptrCast(sequence)));
}

pub fn takeScreenshot(fileName: [:0]const u8) void {
    cdef.TakeScreenshot(@as([*c]const u8, @ptrCast(fileName)));
}

pub fn setConfigFlags(flags: ConfigFlags) void {
    cdef.SetConfigFlags(flags);
}

pub fn openURL(url: [:0]const u8) void {
    cdef.OpenURL(@as([*c]const u8, @ptrCast(url)));
}

pub fn traceLog(logLevel: TraceLogLevel, text: [:0]const u8) void {
    cdef.TraceLog(logLevel, @as([*c]const u8, @ptrCast(text)));
}

pub fn setTraceLogLevel(logLevel: TraceLogLevel) void {
    cdef.SetTraceLogLevel(logLevel);
}

pub fn memAlloc(size: u32) *anyopaque {
    return cdef.MemAlloc(@as(c_uint, size));
}

pub fn memRealloc(ptr: *anyopaque, size: u32) *anyopaque {
    return cdef.MemRealloc(ptr, @as(c_uint, size));
}

pub fn memFree(ptr: *anyopaque) void {
    cdef.MemFree(ptr);
}

pub fn setLoadFileDataCallback(callback: LoadFileDataCallback) void {
    cdef.SetLoadFileDataCallback(callback);
}

pub fn setSaveFileDataCallback(callback: SaveFileDataCallback) void {
    cdef.SetSaveFileDataCallback(callback);
}

pub fn setLoadFileTextCallback(callback: LoadFileTextCallback) void {
    cdef.SetLoadFileTextCallback(callback);
}

pub fn setSaveFileTextCallback(callback: SaveFileTextCallback) void {
    cdef.SetSaveFileTextCallback(callback);
}

pub fn unloadFileData(data: []u8) void {
    cdef.UnloadFileData(@as([*c]u8, @ptrCast(data)));
}

pub fn loadFileText(fileName: [:0]const u8) [:0]u8 {
    return std.mem.span(cdef.LoadFileText(@as([*c]const u8, @ptrCast(fileName))));
}

pub fn unloadFileText(text: [:0]u8) void {
    cdef.UnloadFileText(@as([*c]u8, @ptrCast(text)));
}

pub fn saveFileText(fileName: [:0]const u8, text: [:0]u8) bool {
    return cdef.SaveFileText(@as([*c]const u8, @ptrCast(fileName)), @as([*c]u8, @ptrCast(text)));
}

pub fn fileExists(fileName: [:0]const u8) bool {
    return cdef.FileExists(@as([*c]const u8, @ptrCast(fileName)));
}

pub fn directoryExists(dirPath: [:0]const u8) bool {
    return cdef.DirectoryExists(@as([*c]const u8, @ptrCast(dirPath)));
}

pub fn isFileExtension(fileName: [:0]const u8, ext: [:0]const u8) bool {
    return cdef.IsFileExtension(@as([*c]const u8, @ptrCast(fileName)), @as([*c]const u8, @ptrCast(ext)));
}

pub fn getFileLength(fileName: [:0]const u8) i32 {
    return @as(i32, cdef.GetFileLength(@as([*c]const u8, @ptrCast(fileName))));
}

pub fn getFileExtension(fileName: [:0]const u8) [:0]const u8 {
    return std.mem.span(cdef.GetFileExtension(@as([*c]const u8, @ptrCast(fileName))));
}

pub fn getFileName(filePath: [:0]const u8) [:0]const u8 {
    return std.mem.span(cdef.GetFileName(@as([*c]const u8, @ptrCast(filePath))));
}

pub fn getFileNameWithoutExt(filePath: [:0]const u8) [:0]const u8 {
    return std.mem.span(cdef.GetFileNameWithoutExt(@as([*c]const u8, @ptrCast(filePath))));
}

pub fn getDirectoryPath(filePath: [:0]const u8) [:0]const u8 {
    return std.mem.span(cdef.GetDirectoryPath(@as([*c]const u8, @ptrCast(filePath))));
}

pub fn getPrevDirectoryPath(dirPath: [:0]const u8) [:0]const u8 {
    return std.mem.span(cdef.GetPrevDirectoryPath(@as([*c]const u8, @ptrCast(dirPath))));
}

pub fn getWorkingDirectory() [:0]const u8 {
    return std.mem.span(cdef.GetWorkingDirectory());
}

pub fn getApplicationDirectory() [:0]const u8 {
    return std.mem.span(cdef.GetApplicationDirectory());
}

pub fn changeDirectory(dir: [:0]const u8) bool {
    return cdef.ChangeDirectory(@as([*c]const u8, @ptrCast(dir)));
}

pub fn isPathFile(path: [:0]const u8) bool {
    return cdef.IsPathFile(@as([*c]const u8, @ptrCast(path)));
}

pub fn loadDirectoryFiles(dirPath: [:0]const u8) FilePathList {
    return cdef.LoadDirectoryFiles(@as([*c]const u8, @ptrCast(dirPath)));
}

pub fn loadDirectoryFilesEx(basePath: [:0]const u8, filter: [:0]const u8, scanSubdirs: bool) FilePathList {
    return cdef.LoadDirectoryFilesEx(@as([*c]const u8, @ptrCast(basePath)), @as([*c]const u8, @ptrCast(filter)), scanSubdirs);
}

pub fn unloadDirectoryFiles(files: FilePathList) void {
    cdef.UnloadDirectoryFiles(files);
}

pub fn isFileDropped() bool {
    return cdef.IsFileDropped();
}

pub fn loadDroppedFiles() FilePathList {
    return cdef.LoadDroppedFiles();
}

pub fn unloadDroppedFiles(files: FilePathList) void {
    cdef.UnloadDroppedFiles(files);
}

pub fn getFileModTime(fileName: [:0]const u8) i64 {
    return @as(i64, cdef.GetFileModTime(@as([*c]const u8, @ptrCast(fileName))));
}

pub fn loadAutomationEventList(fileName: [:0]const u8) AutomationEventList {
    return cdef.LoadAutomationEventList(@as([*c]const u8, @ptrCast(fileName)));
}

pub fn unloadAutomationEventList(list: *AutomationEventList) void {
    cdef.UnloadAutomationEventList(@as([*c]AutomationEventList, @ptrCast(list)));
}

pub fn exportAutomationEventList(list: AutomationEventList, fileName: [:0]const u8) bool {
    return cdef.ExportAutomationEventList(list, @as([*c]const u8, @ptrCast(fileName)));
}

pub fn setAutomationEventList(list: *AutomationEventList) void {
    cdef.SetAutomationEventList(@as([*c]AutomationEventList, @ptrCast(list)));
}

pub fn setAutomationEventBaseFrame(frame: i32) void {
    cdef.SetAutomationEventBaseFrame(@as(c_int, frame));
}

pub fn startAutomationEventRecording() void {
    cdef.StartAutomationEventRecording();
}

pub fn stopAutomationEventRecording() void {
    cdef.StopAutomationEventRecording();
}

pub fn playAutomationEvent(event: AutomationEvent) void {
    cdef.PlayAutomationEvent(event);
}

pub fn isKeyPressed(key: KeyboardKey) bool {
    return cdef.IsKeyPressed(key);
}

pub fn isKeyPressedRepeat(key: KeyboardKey) bool {
    return cdef.IsKeyPressedRepeat(key);
}

pub fn isKeyDown(key: KeyboardKey) bool {
    return cdef.IsKeyDown(key);
}

pub fn isKeyReleased(key: KeyboardKey) bool {
    return cdef.IsKeyReleased(key);
}

pub fn isKeyUp(key: KeyboardKey) bool {
    return cdef.IsKeyUp(key);
}

pub fn getKeyPressed() KeyboardKey {
    return cdef.GetKeyPressed();
}

pub fn getCharPressed() i32 {
    return @as(i32, cdef.GetCharPressed());
}

pub fn setExitKey(key: KeyboardKey) void {
    cdef.SetExitKey(key);
}

pub fn isGamepadAvailable(gamepad: i32) bool {
    return cdef.IsGamepadAvailable(@as(c_int, gamepad));
}

pub fn getGamepadName(gamepad: i32) [:0]const u8 {
    return std.mem.span(cdef.GetGamepadName(@as(c_int, gamepad)));
}

pub fn isGamepadButtonPressed(gamepad: i32, button: GamepadButton) bool {
    return cdef.IsGamepadButtonPressed(@as(c_int, gamepad), button);
}

pub fn isGamepadButtonDown(gamepad: i32, button: GamepadButton) bool {
    return cdef.IsGamepadButtonDown(@as(c_int, gamepad), button);
}

pub fn isGamepadButtonReleased(gamepad: i32, button: GamepadButton) bool {
    return cdef.IsGamepadButtonReleased(@as(c_int, gamepad), button);
}

pub fn isGamepadButtonUp(gamepad: i32, button: GamepadButton) bool {
    return cdef.IsGamepadButtonUp(@as(c_int, gamepad), button);
}

pub fn getGamepadButtonPressed() GamepadButton {
    return cdef.GetGamepadButtonPressed();
}

pub fn getGamepadAxisCount(gamepad: i32) i32 {
    return @as(i32, cdef.GetGamepadAxisCount(@as(c_int, gamepad)));
}

pub fn getGamepadAxisMovement(gamepad: i32, axis: i32) f32 {
    return cdef.GetGamepadAxisMovement(@as(c_int, gamepad), @as(c_int, axis));
}

pub fn setGamepadMappings(mappings: [:0]const u8) i32 {
    return @as(i32, cdef.SetGamepadMappings(@as([*c]const u8, @ptrCast(mappings))));
}

pub fn isMouseButtonPressed(button: MouseButton) bool {
    return cdef.IsMouseButtonPressed(button);
}

pub fn isMouseButtonDown(button: MouseButton) bool {
    return cdef.IsMouseButtonDown(button);
}

pub fn isMouseButtonReleased(button: MouseButton) bool {
    return cdef.IsMouseButtonReleased(button);
}

pub fn isMouseButtonUp(button: MouseButton) bool {
    return cdef.IsMouseButtonUp(button);
}

pub fn getMouseX() i32 {
    return @as(i32, cdef.GetMouseX());
}

pub fn getMouseY() i32 {
    return @as(i32, cdef.GetMouseY());
}

pub fn getMousePosition() Vector2 {
    return cdef.GetMousePosition();
}

pub fn getMouseDelta() Vector2 {
    return cdef.GetMouseDelta();
}

pub fn setMousePosition(x: i32, y: i32) void {
    cdef.SetMousePosition(@as(c_int, x), @as(c_int, y));
}

pub fn setMouseOffset(offsetX: i32, offsetY: i32) void {
    cdef.SetMouseOffset(@as(c_int, offsetX), @as(c_int, offsetY));
}

pub fn setMouseScale(scaleX: f32, scaleY: f32) void {
    cdef.SetMouseScale(scaleX, scaleY);
}

pub fn getMouseWheelMove() f32 {
    return cdef.GetMouseWheelMove();
}

pub fn getMouseWheelMoveV() Vector2 {
    return cdef.GetMouseWheelMoveV();
}

pub fn setMouseCursor(cursor: i32) void {
    cdef.SetMouseCursor(@as(c_int, cursor));
}

pub fn getTouchX() i32 {
    return @as(i32, cdef.GetTouchX());
}

pub fn getTouchY() i32 {
    return @as(i32, cdef.GetTouchY());
}

pub fn getTouchPosition(index: i32) Vector2 {
    return cdef.GetTouchPosition(@as(c_int, index));
}

pub fn getTouchPointId(index: i32) i32 {
    return @as(i32, cdef.GetTouchPointId(@as(c_int, index)));
}

pub fn getTouchPointCount() i32 {
    return @as(i32, cdef.GetTouchPointCount());
}

pub fn setGesturesEnabled(flags: u32) void {
    cdef.SetGesturesEnabled(@as(c_uint, flags));
}

pub fn isGestureDetected(gesture: Gesture) bool {
    return cdef.IsGestureDetected(gesture);
}

pub fn getGestureDetected() Gesture {
    return cdef.GetGestureDetected();
}

pub fn getGestureHoldDuration() f32 {
    return cdef.GetGestureHoldDuration();
}

pub fn getGestureDragVector() Vector2 {
    return cdef.GetGestureDragVector();
}

pub fn getGestureDragAngle() f32 {
    return cdef.GetGestureDragAngle();
}

pub fn getGesturePinchVector() Vector2 {
    return cdef.GetGesturePinchVector();
}

pub fn getGesturePinchAngle() f32 {
    return cdef.GetGesturePinchAngle();
}

pub fn updateCamera(camera: *Camera, mode: CameraMode) void {
    cdef.UpdateCamera(@as([*c]Camera, @ptrCast(camera)), mode);
}

pub fn updateCameraPro(camera: *Camera, movement: Vector3, rotation: Vector3, zoom: f32) void {
    cdef.UpdateCameraPro(@as([*c]Camera, @ptrCast(camera)), movement, rotation, zoom);
}

pub fn setShapesTexture(texture: Texture2D, source: Rectangle) void {
    cdef.SetShapesTexture(texture, source);
}

pub fn drawPixel(posX: i32, posY: i32, color: Color) void {
    cdef.DrawPixel(@as(c_int, posX), @as(c_int, posY), color);
}

pub fn drawPixelV(position: Vector2, color: Color) void {
    cdef.DrawPixelV(position, color);
}

pub fn drawLine(startPosX: i32, startPosY: i32, endPosX: i32, endPosY: i32, color: Color) void {
    cdef.DrawLine(@as(c_int, startPosX), @as(c_int, startPosY), @as(c_int, endPosX), @as(c_int, endPosY), color);
}

pub fn drawLineV(startPos: Vector2, endPos: Vector2, color: Color) void {
    cdef.DrawLineV(startPos, endPos, color);
}

pub fn drawLineEx(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void {
    cdef.DrawLineEx(startPos, endPos, thick, color);
}

pub fn drawLineBezier(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void {
    cdef.DrawLineBezier(startPos, endPos, thick, color);
}

pub fn drawCircle(centerX: i32, centerY: i32, radius: f32, color: Color) void {
    cdef.DrawCircle(@as(c_int, centerX), @as(c_int, centerY), radius, color);
}

pub fn drawCircleSector(center: Vector2, radius: f32, startAngle: f32, endAngle: f32, segments: i32, color: Color) void {
    cdef.DrawCircleSector(center, radius, startAngle, endAngle, @as(c_int, segments), color);
}

pub fn drawCircleSectorLines(center: Vector2, radius: f32, startAngle: f32, endAngle: f32, segments: i32, color: Color) void {
    cdef.DrawCircleSectorLines(center, radius, startAngle, endAngle, @as(c_int, segments), color);
}

pub fn drawCircleGradient(centerX: i32, centerY: i32, radius: f32, color1: Color, color2: Color) void {
    cdef.DrawCircleGradient(@as(c_int, centerX), @as(c_int, centerY), radius, color1, color2);
}

pub fn drawCircleV(center: Vector2, radius: f32, color: Color) void {
    cdef.DrawCircleV(center, radius, color);
}

pub fn drawCircleLines(centerX: i32, centerY: i32, radius: f32, color: Color) void {
    cdef.DrawCircleLines(@as(c_int, centerX), @as(c_int, centerY), radius, color);
}

pub fn drawCircleLinesV(center: Vector2, radius: f32, color: Color) void {
    cdef.DrawCircleLinesV(center, radius, color);
}

pub fn drawEllipse(centerX: i32, centerY: i32, radiusH: f32, radiusV: f32, color: Color) void {
    cdef.DrawEllipse(@as(c_int, centerX), @as(c_int, centerY), radiusH, radiusV, color);
}

pub fn drawEllipseLines(centerX: i32, centerY: i32, radiusH: f32, radiusV: f32, color: Color) void {
    cdef.DrawEllipseLines(@as(c_int, centerX), @as(c_int, centerY), radiusH, radiusV, color);
}

pub fn drawRing(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: f32, endAngle: f32, segments: i32, color: Color) void {
    cdef.DrawRing(center, innerRadius, outerRadius, startAngle, endAngle, @as(c_int, segments), color);
}

pub fn drawRingLines(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: f32, endAngle: f32, segments: i32, color: Color) void {
    cdef.DrawRingLines(center, innerRadius, outerRadius, startAngle, endAngle, @as(c_int, segments), color);
}

pub fn drawRectangle(posX: i32, posY: i32, width: i32, height: i32, color: Color) void {
    cdef.DrawRectangle(@as(c_int, posX), @as(c_int, posY), @as(c_int, width), @as(c_int, height), color);
}

pub fn drawRectangleV(position: Vector2, size: Vector2, color: Color) void {
    cdef.DrawRectangleV(position, size, color);
}

pub fn drawRectangleRec(rec: Rectangle, color: Color) void {
    cdef.DrawRectangleRec(rec, color);
}

pub fn drawRectanglePro(rec: Rectangle, origin: Vector2, rotation: f32, color: Color) void {
    cdef.DrawRectanglePro(rec, origin, rotation, color);
}

pub fn drawRectangleGradientV(posX: i32, posY: i32, width: i32, height: i32, color1: Color, color2: Color) void {
    cdef.DrawRectangleGradientV(@as(c_int, posX), @as(c_int, posY), @as(c_int, width), @as(c_int, height), color1, color2);
}

pub fn drawRectangleGradientH(posX: i32, posY: i32, width: i32, height: i32, color1: Color, color2: Color) void {
    cdef.DrawRectangleGradientH(@as(c_int, posX), @as(c_int, posY), @as(c_int, width), @as(c_int, height), color1, color2);
}

pub fn drawRectangleGradientEx(rec: Rectangle, col1: Color, col2: Color, col3: Color, col4: Color) void {
    cdef.DrawRectangleGradientEx(rec, col1, col2, col3, col4);
}

pub fn drawRectangleLines(posX: i32, posY: i32, width: i32, height: i32, color: Color) void {
    cdef.DrawRectangleLines(@as(c_int, posX), @as(c_int, posY), @as(c_int, width), @as(c_int, height), color);
}

pub fn drawRectangleLinesEx(rec: Rectangle, lineThick: f32, color: Color) void {
    cdef.DrawRectangleLinesEx(rec, lineThick, color);
}

pub fn drawRectangleRounded(rec: Rectangle, roundness: f32, segments: i32, color: Color) void {
    cdef.DrawRectangleRounded(rec, roundness, @as(c_int, segments), color);
}

pub fn drawRectangleRoundedLines(rec: Rectangle, roundness: f32, segments: i32, lineThick: f32, color: Color) void {
    cdef.DrawRectangleRoundedLines(rec, roundness, @as(c_int, segments), lineThick, color);
}

pub fn drawTriangle(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void {
    cdef.DrawTriangle(v1, v2, v3, color);
}

pub fn drawTriangleLines(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void {
    cdef.DrawTriangleLines(v1, v2, v3, color);
}

pub fn drawPoly(center: Vector2, sides: i32, radius: f32, rotation: f32, color: Color) void {
    cdef.DrawPoly(center, @as(c_int, sides), radius, rotation, color);
}

pub fn drawPolyLines(center: Vector2, sides: i32, radius: f32, rotation: f32, color: Color) void {
    cdef.DrawPolyLines(center, @as(c_int, sides), radius, rotation, color);
}

pub fn drawPolyLinesEx(center: Vector2, sides: i32, radius: f32, rotation: f32, lineThick: f32, color: Color) void {
    cdef.DrawPolyLinesEx(center, @as(c_int, sides), radius, rotation, lineThick, color);
}

pub fn drawSplineLinear(points: []Vector2, pointCount: i32, thick: f32, color: Color) void {
    cdef.DrawSplineLinear(@as([*c]Vector2, @ptrCast(points)), @as(c_int, pointCount), thick, color);
}

pub fn drawSplineBasis(points: []Vector2, pointCount: i32, thick: f32, color: Color) void {
    cdef.DrawSplineBasis(@as([*c]Vector2, @ptrCast(points)), @as(c_int, pointCount), thick, color);
}

pub fn drawSplineCatmullRom(points: []Vector2, pointCount: i32, thick: f32, color: Color) void {
    cdef.DrawSplineCatmullRom(@as([*c]Vector2, @ptrCast(points)), @as(c_int, pointCount), thick, color);
}

pub fn drawSplineBezierQuadratic(points: []Vector2, pointCount: i32, thick: f32, color: Color) void {
    cdef.DrawSplineBezierQuadratic(@as([*c]Vector2, @ptrCast(points)), @as(c_int, pointCount), thick, color);
}

pub fn drawSplineBezierCubic(points: []Vector2, pointCount: i32, thick: f32, color: Color) void {
    cdef.DrawSplineBezierCubic(@as([*c]Vector2, @ptrCast(points)), @as(c_int, pointCount), thick, color);
}

pub fn drawSplineSegmentLinear(p1: Vector2, p2: Vector2, thick: f32, color: Color) void {
    cdef.DrawSplineSegmentLinear(p1, p2, thick, color);
}

pub fn drawSplineSegmentBasis(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, thick: f32, color: Color) void {
    cdef.DrawSplineSegmentBasis(p1, p2, p3, p4, thick, color);
}

pub fn drawSplineSegmentCatmullRom(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, thick: f32, color: Color) void {
    cdef.DrawSplineSegmentCatmullRom(p1, p2, p3, p4, thick, color);
}

pub fn drawSplineSegmentBezierQuadratic(p1: Vector2, c2: Vector2, p3: Vector2, thick: f32, color: Color) void {
    cdef.DrawSplineSegmentBezierQuadratic(p1, c2, p3, thick, color);
}

pub fn drawSplineSegmentBezierCubic(p1: Vector2, c2: Vector2, c3: Vector2, p4: Vector2, thick: f32, color: Color) void {
    cdef.DrawSplineSegmentBezierCubic(p1, c2, c3, p4, thick, color);
}

pub fn getSplinePointLinear(startPos: Vector2, endPos: Vector2, t: f32) Vector2 {
    return cdef.GetSplinePointLinear(startPos, endPos, t);
}

pub fn getSplinePointBasis(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, t: f32) Vector2 {
    return cdef.GetSplinePointBasis(p1, p2, p3, p4, t);
}

pub fn getSplinePointCatmullRom(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, t: f32) Vector2 {
    return cdef.GetSplinePointCatmullRom(p1, p2, p3, p4, t);
}

pub fn getSplinePointBezierQuad(p1: Vector2, c2: Vector2, p3: Vector2, t: f32) Vector2 {
    return cdef.GetSplinePointBezierQuad(p1, c2, p3, t);
}

pub fn getSplinePointBezierCubic(p1: Vector2, c2: Vector2, c3: Vector2, p4: Vector2, t: f32) Vector2 {
    return cdef.GetSplinePointBezierCubic(p1, c2, c3, p4, t);
}

pub fn checkCollisionRecs(rec1: Rectangle, rec2: Rectangle) bool {
    return cdef.CheckCollisionRecs(rec1, rec2);
}

pub fn checkCollisionCircles(center1: Vector2, radius1: f32, center2: Vector2, radius2: f32) bool {
    return cdef.CheckCollisionCircles(center1, radius1, center2, radius2);
}

pub fn checkCollisionCircleRec(center: Vector2, radius: f32, rec: Rectangle) bool {
    return cdef.CheckCollisionCircleRec(center, radius, rec);
}

pub fn checkCollisionPointRec(point: Vector2, rec: Rectangle) bool {
    return cdef.CheckCollisionPointRec(point, rec);
}

pub fn checkCollisionPointCircle(point: Vector2, center: Vector2, radius: f32) bool {
    return cdef.CheckCollisionPointCircle(point, center, radius);
}

pub fn checkCollisionPointTriangle(point: Vector2, p1: Vector2, p2: Vector2, p3: Vector2) bool {
    return cdef.CheckCollisionPointTriangle(point, p1, p2, p3);
}

pub fn checkCollisionLines(startPos1: Vector2, endPos1: Vector2, startPos2: Vector2, endPos2: Vector2, collisionPoint: *Vector2) bool {
    return cdef.CheckCollisionLines(startPos1, endPos1, startPos2, endPos2, @as([*c]Vector2, @ptrCast(collisionPoint)));
}

pub fn checkCollisionPointLine(point: Vector2, p1: Vector2, p2: Vector2, threshold: i32) bool {
    return cdef.CheckCollisionPointLine(point, p1, p2, @as(c_int, threshold));
}

pub fn getCollisionRec(rec1: Rectangle, rec2: Rectangle) Rectangle {
    return cdef.GetCollisionRec(rec1, rec2);
}

pub fn loadImage(fileName: [:0]const u8) Image {
    return cdef.LoadImage(@as([*c]const u8, @ptrCast(fileName)));
}

pub fn loadImageRaw(fileName: [:0]const u8, width: i32, height: i32, format: i32, headerSize: i32) Image {
    return cdef.LoadImageRaw(@as([*c]const u8, @ptrCast(fileName)), @as(c_int, width), @as(c_int, height), @as(c_int, format), @as(c_int, headerSize));
}

pub fn loadImageSvg(fileNameOrString: [:0]const u8, width: i32, height: i32) Image {
    return cdef.LoadImageSvg(@as([*c]const u8, @ptrCast(fileNameOrString)), @as(c_int, width), @as(c_int, height));
}

pub fn loadImageAnim(fileName: [:0]const u8, frames: *i32) Image {
    return cdef.LoadImageAnim(@as([*c]const u8, @ptrCast(fileName)), @as([*c]c_int, @ptrCast(frames)));
}

pub fn loadImageFromTexture(texture: Texture2D) Image {
    return cdef.LoadImageFromTexture(texture);
}

pub fn loadImageFromScreen() Image {
    return cdef.LoadImageFromScreen();
}

pub fn isImageReady(image: Image) bool {
    return cdef.IsImageReady(image);
}

pub fn unloadImage(image: Image) void {
    cdef.UnloadImage(image);
}

pub fn exportImage(image: Image, fileName: [:0]const u8) bool {
    return cdef.ExportImage(image, @as([*c]const u8, @ptrCast(fileName)));
}

pub fn exportImageToMemory(image: Image, fileType: [:0]const u8, fileSize: *i32) [:0]u8 {
    return std.mem.span(cdef.ExportImageToMemory(image, @as([*c]const u8, @ptrCast(fileType)), @as([*c]c_int, @ptrCast(fileSize))));
}

pub fn exportImageAsCode(image: Image, fileName: [:0]const u8) bool {
    return cdef.ExportImageAsCode(image, @as([*c]const u8, @ptrCast(fileName)));
}

pub fn genImageColor(width: i32, height: i32, color: Color) Image {
    return cdef.GenImageColor(@as(c_int, width), @as(c_int, height), color);
}

pub fn genImageGradientLinear(width: i32, height: i32, direction: i32, start: Color, end: Color) Image {
    return cdef.GenImageGradientLinear(@as(c_int, width), @as(c_int, height), @as(c_int, direction), start, end);
}

pub fn genImageGradientRadial(width: i32, height: i32, density: f32, inner: Color, outer: Color) Image {
    return cdef.GenImageGradientRadial(@as(c_int, width), @as(c_int, height), density, inner, outer);
}

pub fn genImageGradientSquare(width: i32, height: i32, density: f32, inner: Color, outer: Color) Image {
    return cdef.GenImageGradientSquare(@as(c_int, width), @as(c_int, height), density, inner, outer);
}

pub fn genImageChecked(width: i32, height: i32, checksX: i32, checksY: i32, col1: Color, col2: Color) Image {
    return cdef.GenImageChecked(@as(c_int, width), @as(c_int, height), @as(c_int, checksX), @as(c_int, checksY), col1, col2);
}

pub fn genImageWhiteNoise(width: i32, height: i32, factor: f32) Image {
    return cdef.GenImageWhiteNoise(@as(c_int, width), @as(c_int, height), factor);
}

pub fn genImagePerlinNoise(width: i32, height: i32, offsetX: i32, offsetY: i32, scale: f32) Image {
    return cdef.GenImagePerlinNoise(@as(c_int, width), @as(c_int, height), @as(c_int, offsetX), @as(c_int, offsetY), scale);
}

pub fn genImageCellular(width: i32, height: i32, tileSize: i32) Image {
    return cdef.GenImageCellular(@as(c_int, width), @as(c_int, height), @as(c_int, tileSize));
}

pub fn genImageText(width: i32, height: i32, text: [:0]const u8) Image {
    return cdef.GenImageText(@as(c_int, width), @as(c_int, height), @as([*c]const u8, @ptrCast(text)));
}

pub fn imageCopy(image: Image) Image {
    return cdef.ImageCopy(image);
}

pub fn imageFromImage(image: Image, rec: Rectangle) Image {
    return cdef.ImageFromImage(image, rec);
}

pub fn imageText(text: [:0]const u8, fontSize: i32, color: Color) Image {
    return cdef.ImageText(@as([*c]const u8, @ptrCast(text)), @as(c_int, fontSize), color);
}

pub fn imageTextEx(font: Font, text: [:0]const u8, fontSize: f32, spacing: f32, tint: Color) Image {
    return cdef.ImageTextEx(font, @as([*c]const u8, @ptrCast(text)), fontSize, spacing, tint);
}

pub fn imageFormat(image: *Image, newFormat: i32) void {
    cdef.ImageFormat(@as([*c]Image, @ptrCast(image)), @as(c_int, newFormat));
}

pub fn imageToPOT(image: *Image, fill: Color) void {
    cdef.ImageToPOT(@as([*c]Image, @ptrCast(image)), fill);
}

pub fn imageCrop(image: *Image, crop: Rectangle) void {
    cdef.ImageCrop(@as([*c]Image, @ptrCast(image)), crop);
}

pub fn imageAlphaCrop(image: *Image, threshold: f32) void {
    cdef.ImageAlphaCrop(@as([*c]Image, @ptrCast(image)), threshold);
}

pub fn imageAlphaClear(image: *Image, color: Color, threshold: f32) void {
    cdef.ImageAlphaClear(@as([*c]Image, @ptrCast(image)), color, threshold);
}

pub fn imageAlphaMask(image: *Image, alphaMask: Image) void {
    cdef.ImageAlphaMask(@as([*c]Image, @ptrCast(image)), alphaMask);
}

pub fn imageAlphaPremultiply(image: *Image) void {
    cdef.ImageAlphaPremultiply(@as([*c]Image, @ptrCast(image)));
}

pub fn imageBlurGaussian(image: *Image, blurSize: i32) void {
    cdef.ImageBlurGaussian(@as([*c]Image, @ptrCast(image)), @as(c_int, blurSize));
}

pub fn imageResize(image: *Image, newWidth: i32, newHeight: i32) void {
    cdef.ImageResize(@as([*c]Image, @ptrCast(image)), @as(c_int, newWidth), @as(c_int, newHeight));
}

pub fn imageResizeNN(image: *Image, newWidth: i32, newHeight: i32) void {
    cdef.ImageResizeNN(@as([*c]Image, @ptrCast(image)), @as(c_int, newWidth), @as(c_int, newHeight));
}

pub fn imageResizeCanvas(image: *Image, newWidth: i32, newHeight: i32, offsetX: i32, offsetY: i32, fill: Color) void {
    cdef.ImageResizeCanvas(@as([*c]Image, @ptrCast(image)), @as(c_int, newWidth), @as(c_int, newHeight), @as(c_int, offsetX), @as(c_int, offsetY), fill);
}

pub fn imageMipmaps(image: *Image) void {
    cdef.ImageMipmaps(@as([*c]Image, @ptrCast(image)));
}

pub fn imageDither(image: *Image, rBpp: i32, gBpp: i32, bBpp: i32, aBpp: i32) void {
    cdef.ImageDither(@as([*c]Image, @ptrCast(image)), @as(c_int, rBpp), @as(c_int, gBpp), @as(c_int, bBpp), @as(c_int, aBpp));
}

pub fn imageFlipVertical(image: *Image) void {
    cdef.ImageFlipVertical(@as([*c]Image, @ptrCast(image)));
}

pub fn imageFlipHorizontal(image: *Image) void {
    cdef.ImageFlipHorizontal(@as([*c]Image, @ptrCast(image)));
}

pub fn imageRotate(image: *Image, degrees: i32) void {
    cdef.ImageRotate(@as([*c]Image, @ptrCast(image)), @as(c_int, degrees));
}

pub fn imageRotateCW(image: *Image) void {
    cdef.ImageRotateCW(@as([*c]Image, @ptrCast(image)));
}

pub fn imageRotateCCW(image: *Image) void {
    cdef.ImageRotateCCW(@as([*c]Image, @ptrCast(image)));
}

pub fn imageColorTint(image: *Image, color: Color) void {
    cdef.ImageColorTint(@as([*c]Image, @ptrCast(image)), color);
}

pub fn imageColorInvert(image: *Image) void {
    cdef.ImageColorInvert(@as([*c]Image, @ptrCast(image)));
}

pub fn imageColorGrayscale(image: *Image) void {
    cdef.ImageColorGrayscale(@as([*c]Image, @ptrCast(image)));
}

pub fn imageColorContrast(image: *Image, contrast: f32) void {
    cdef.ImageColorContrast(@as([*c]Image, @ptrCast(image)), contrast);
}

pub fn imageColorBrightness(image: *Image, brightness: i32) void {
    cdef.ImageColorBrightness(@as([*c]Image, @ptrCast(image)), @as(c_int, brightness));
}

pub fn imageColorReplace(image: *Image, color: Color, replace: Color) void {
    cdef.ImageColorReplace(@as([*c]Image, @ptrCast(image)), color, replace);
}

pub fn unloadImageColors(colors: []Color) void {
    cdef.UnloadImageColors(@as([*c]Color, @ptrCast(colors)));
}

pub fn unloadImagePalette(colors: []Color) void {
    cdef.UnloadImagePalette(@as([*c]Color, @ptrCast(colors)));
}

pub fn getImageAlphaBorder(image: Image, threshold: f32) Rectangle {
    return cdef.GetImageAlphaBorder(image, threshold);
}

pub fn getImageColor(image: Image, x: i32, y: i32) Color {
    return cdef.GetImageColor(image, @as(c_int, x), @as(c_int, y));
}

pub fn imageClearBackground(dst: *Image, color: Color) void {
    cdef.ImageClearBackground(@as([*c]Image, @ptrCast(dst)), color);
}

pub fn imageDrawPixel(dst: *Image, posX: i32, posY: i32, color: Color) void {
    cdef.ImageDrawPixel(@as([*c]Image, @ptrCast(dst)), @as(c_int, posX), @as(c_int, posY), color);
}

pub fn imageDrawPixelV(dst: *Image, position: Vector2, color: Color) void {
    cdef.ImageDrawPixelV(@as([*c]Image, @ptrCast(dst)), position, color);
}

pub fn imageDrawLine(dst: *Image, startPosX: i32, startPosY: i32, endPosX: i32, endPosY: i32, color: Color) void {
    cdef.ImageDrawLine(@as([*c]Image, @ptrCast(dst)), @as(c_int, startPosX), @as(c_int, startPosY), @as(c_int, endPosX), @as(c_int, endPosY), color);
}

pub fn imageDrawLineV(dst: *Image, start: Vector2, end: Vector2, color: Color) void {
    cdef.ImageDrawLineV(@as([*c]Image, @ptrCast(dst)), start, end, color);
}

pub fn imageDrawCircle(dst: *Image, centerX: i32, centerY: i32, radius: i32, color: Color) void {
    cdef.ImageDrawCircle(@as([*c]Image, @ptrCast(dst)), @as(c_int, centerX), @as(c_int, centerY), @as(c_int, radius), color);
}

pub fn imageDrawCircleV(dst: *Image, center: Vector2, radius: i32, color: Color) void {
    cdef.ImageDrawCircleV(@as([*c]Image, @ptrCast(dst)), center, @as(c_int, radius), color);
}

pub fn imageDrawCircleLines(dst: *Image, centerX: i32, centerY: i32, radius: i32, color: Color) void {
    cdef.ImageDrawCircleLines(@as([*c]Image, @ptrCast(dst)), @as(c_int, centerX), @as(c_int, centerY), @as(c_int, radius), color);
}

pub fn imageDrawCircleLinesV(dst: *Image, center: Vector2, radius: i32, color: Color) void {
    cdef.ImageDrawCircleLinesV(@as([*c]Image, @ptrCast(dst)), center, @as(c_int, radius), color);
}

pub fn imageDrawRectangle(dst: *Image, posX: i32, posY: i32, width: i32, height: i32, color: Color) void {
    cdef.ImageDrawRectangle(@as([*c]Image, @ptrCast(dst)), @as(c_int, posX), @as(c_int, posY), @as(c_int, width), @as(c_int, height), color);
}

pub fn imageDrawRectangleV(dst: *Image, position: Vector2, size: Vector2, color: Color) void {
    cdef.ImageDrawRectangleV(@as([*c]Image, @ptrCast(dst)), position, size, color);
}

pub fn imageDrawRectangleRec(dst: *Image, rec: Rectangle, color: Color) void {
    cdef.ImageDrawRectangleRec(@as([*c]Image, @ptrCast(dst)), rec, color);
}

pub fn imageDrawRectangleLines(dst: *Image, rec: Rectangle, thick: i32, color: Color) void {
    cdef.ImageDrawRectangleLines(@as([*c]Image, @ptrCast(dst)), rec, @as(c_int, thick), color);
}

pub fn imageDraw(dst: *Image, src: Image, srcRec: Rectangle, dstRec: Rectangle, tint: Color) void {
    cdef.ImageDraw(@as([*c]Image, @ptrCast(dst)), src, srcRec, dstRec, tint);
}

pub fn imageDrawText(dst: *Image, text: [:0]const u8, posX: i32, posY: i32, fontSize: i32, color: Color) void {
    cdef.ImageDrawText(@as([*c]Image, @ptrCast(dst)), @as([*c]const u8, @ptrCast(text)), @as(c_int, posX), @as(c_int, posY), @as(c_int, fontSize), color);
}

pub fn imageDrawTextEx(dst: *Image, font: Font, text: [:0]const u8, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void {
    cdef.ImageDrawTextEx(@as([*c]Image, @ptrCast(dst)), font, @as([*c]const u8, @ptrCast(text)), position, fontSize, spacing, tint);
}

pub fn loadTexture(fileName: [:0]const u8) Texture2D {
    return cdef.LoadTexture(@as([*c]const u8, @ptrCast(fileName)));
}

pub fn loadTextureFromImage(image: Image) Texture2D {
    return cdef.LoadTextureFromImage(image);
}

pub fn loadTextureCubemap(image: Image, layout: i32) TextureCubemap {
    return cdef.LoadTextureCubemap(image, @as(c_int, layout));
}

pub fn loadRenderTexture(width: i32, height: i32) RenderTexture2D {
    return cdef.LoadRenderTexture(@as(c_int, width), @as(c_int, height));
}

pub fn isTextureReady(texture: Texture2D) bool {
    return cdef.IsTextureReady(texture);
}

pub fn unloadTexture(texture: Texture2D) void {
    cdef.UnloadTexture(texture);
}

pub fn isRenderTextureReady(target: RenderTexture2D) bool {
    return cdef.IsRenderTextureReady(target);
}

pub fn unloadRenderTexture(target: RenderTexture2D) void {
    cdef.UnloadRenderTexture(target);
}

pub fn updateTexture(texture: Texture2D, pixels: *const anyopaque) void {
    cdef.UpdateTexture(texture, pixels);
}

pub fn updateTextureRec(texture: Texture2D, rec: Rectangle, pixels: *const anyopaque) void {
    cdef.UpdateTextureRec(texture, rec, pixels);
}

pub fn genTextureMipmaps(texture: *Texture2D) void {
    cdef.GenTextureMipmaps(@as([*c]Texture2D, @ptrCast(texture)));
}

pub fn setTextureFilter(texture: Texture2D, filter: i32) void {
    cdef.SetTextureFilter(texture, @as(c_int, filter));
}

pub fn setTextureWrap(texture: Texture2D, wrap: i32) void {
    cdef.SetTextureWrap(texture, @as(c_int, wrap));
}

pub fn drawTexture(texture: Texture2D, posX: i32, posY: i32, tint: Color) void {
    cdef.DrawTexture(texture, @as(c_int, posX), @as(c_int, posY), tint);
}

pub fn drawTextureV(texture: Texture2D, position: Vector2, tint: Color) void {
    cdef.DrawTextureV(texture, position, tint);
}

pub fn drawTextureEx(texture: Texture2D, position: Vector2, rotation: f32, scale: f32, tint: Color) void {
    cdef.DrawTextureEx(texture, position, rotation, scale, tint);
}

pub fn drawTextureRec(texture: Texture2D, source: Rectangle, position: Vector2, tint: Color) void {
    cdef.DrawTextureRec(texture, source, position, tint);
}

pub fn drawTexturePro(texture: Texture2D, source: Rectangle, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) void {
    cdef.DrawTexturePro(texture, source, dest, origin, rotation, tint);
}

pub fn drawTextureNPatch(texture: Texture2D, nPatchInfo: NPatchInfo, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) void {
    cdef.DrawTextureNPatch(texture, nPatchInfo, dest, origin, rotation, tint);
}

pub fn fade(color: Color, alpha: f32) Color {
    return cdef.Fade(color, alpha);
}

pub fn colorToInt(color: Color) i32 {
    return @as(i32, cdef.ColorToInt(color));
}

pub fn colorNormalize(color: Color) Vector4 {
    return cdef.ColorNormalize(color);
}

pub fn colorFromNormalized(normalized: Vector4) Color {
    return cdef.ColorFromNormalized(normalized);
}

pub fn colorToHSV(color: Color) Vector3 {
    return cdef.ColorToHSV(color);
}

pub fn colorFromHSV(hue: f32, saturation: f32, value: f32) Color {
    return cdef.ColorFromHSV(hue, saturation, value);
}

pub fn colorTint(color: Color, tint: Color) Color {
    return cdef.ColorTint(color, tint);
}

pub fn colorBrightness(color: Color, factor: f32) Color {
    return cdef.ColorBrightness(color, factor);
}

pub fn colorContrast(color: Color, contrast: f32) Color {
    return cdef.ColorContrast(color, contrast);
}

pub fn colorAlpha(color: Color, alpha: f32) Color {
    return cdef.ColorAlpha(color, alpha);
}

pub fn colorAlphaBlend(dst: Color, src: Color, tint: Color) Color {
    return cdef.ColorAlphaBlend(dst, src, tint);
}

pub fn getColor(hexValue: u32) Color {
    return cdef.GetColor(@as(c_uint, hexValue));
}

pub fn getPixelColor(srcPtr: *anyopaque, format: i32) Color {
    return cdef.GetPixelColor(srcPtr, @as(c_int, format));
}

pub fn setPixelColor(dstPtr: *anyopaque, color: Color, format: i32) void {
    cdef.SetPixelColor(dstPtr, color, @as(c_int, format));
}

pub fn getPixelDataSize(width: i32, height: i32, format: i32) i32 {
    return @as(i32, cdef.GetPixelDataSize(@as(c_int, width), @as(c_int, height), @as(c_int, format)));
}

pub fn getFontDefault() Font {
    return cdef.GetFontDefault();
}

pub fn loadFont(fileName: [:0]const u8) Font {
    return cdef.LoadFont(@as([*c]const u8, @ptrCast(fileName)));
}

pub fn loadFontFromImage(image: Image, key: Color, firstChar: i32) Font {
    return cdef.LoadFontFromImage(image, key, @as(c_int, firstChar));
}

pub fn isFontReady(font: Font) bool {
    return cdef.IsFontReady(font);
}

pub fn unloadFont(font: Font) void {
    cdef.UnloadFont(font);
}

pub fn exportFontAsCode(font: Font, fileName: [:0]const u8) bool {
    return cdef.ExportFontAsCode(font, @as([*c]const u8, @ptrCast(fileName)));
}

pub fn drawFPS(posX: i32, posY: i32) void {
    cdef.DrawFPS(@as(c_int, posX), @as(c_int, posY));
}

pub fn drawText(text: [:0]const u8, posX: i32, posY: i32, fontSize: i32, color: Color) void {
    cdef.DrawText(@as([*c]const u8, @ptrCast(text)), @as(c_int, posX), @as(c_int, posY), @as(c_int, fontSize), color);
}

pub fn drawTextEx(font: Font, text: [:0]const u8, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void {
    cdef.DrawTextEx(font, @as([*c]const u8, @ptrCast(text)), position, fontSize, spacing, tint);
}

pub fn drawTextPro(font: Font, text: [:0]const u8, position: Vector2, origin: Vector2, rotation: f32, fontSize: f32, spacing: f32, tint: Color) void {
    cdef.DrawTextPro(font, @as([*c]const u8, @ptrCast(text)), position, origin, rotation, fontSize, spacing, tint);
}

pub fn drawTextCodepoint(font: Font, codepoint: i32, position: Vector2, fontSize: f32, tint: Color) void {
    cdef.DrawTextCodepoint(font, @as(c_int, codepoint), position, fontSize, tint);
}

pub fn setTextLineSpacing(spacing: i32) void {
    cdef.SetTextLineSpacing(@as(c_int, spacing));
}

pub fn measureText(text: [:0]const u8, fontSize: i32) i32 {
    return @as(i32, cdef.MeasureText(@as([*c]const u8, @ptrCast(text)), @as(c_int, fontSize)));
}

pub fn measureTextEx(font: Font, text: [:0]const u8, fontSize: f32, spacing: f32) Vector2 {
    return cdef.MeasureTextEx(font, @as([*c]const u8, @ptrCast(text)), fontSize, spacing);
}

pub fn getGlyphIndex(font: Font, codepoint: i32) i32 {
    return @as(i32, cdef.GetGlyphIndex(font, @as(c_int, codepoint)));
}

pub fn getGlyphInfo(font: Font, codepoint: i32) GlyphInfo {
    return cdef.GetGlyphInfo(font, @as(c_int, codepoint));
}

pub fn getGlyphAtlasRec(font: Font, codepoint: i32) Rectangle {
    return cdef.GetGlyphAtlasRec(font, @as(c_int, codepoint));
}

pub fn unloadUTF8(text: [:0]u8) void {
    cdef.UnloadUTF8(@as([*c]u8, @ptrCast(text)));
}

pub fn unloadCodepoints(codepoints: []i32) void {
    cdef.UnloadCodepoints(@as([*c]c_int, @ptrCast(codepoints)));
}

pub fn getCodepointCount(text: [:0]const u8) i32 {
    return @as(i32, cdef.GetCodepointCount(@as([*c]const u8, @ptrCast(text))));
}

pub fn getCodepoint(text: [:0]const u8, codepointSize: *i32) i32 {
    return @as(i32, cdef.GetCodepoint(@as([*c]const u8, @ptrCast(text)), @as([*c]c_int, @ptrCast(codepointSize))));
}

pub fn getCodepointNext(text: [:0]const u8, codepointSize: *i32) i32 {
    return @as(i32, cdef.GetCodepointNext(@as([*c]const u8, @ptrCast(text)), @as([*c]c_int, @ptrCast(codepointSize))));
}

pub fn getCodepointPrevious(text: [:0]const u8, codepointSize: *i32) i32 {
    return @as(i32, cdef.GetCodepointPrevious(@as([*c]const u8, @ptrCast(text)), @as([*c]c_int, @ptrCast(codepointSize))));
}

pub fn codepointToUTF8(codepoint: i32, utf8Size: *i32) [:0]const u8 {
    return std.mem.span(cdef.CodepointToUTF8(@as(c_int, codepoint), @as([*c]c_int, @ptrCast(utf8Size))));
}

pub fn textCopy(dst: *u8, src: [:0]const u8) i32 {
    return @as(i32, cdef.TextCopy(@as([*c]u8, @ptrCast(dst)), @as([*c]const u8, @ptrCast(src))));
}

pub fn textIsEqual(text1: [:0]const u8, text2: [:0]const u8) bool {
    return cdef.TextIsEqual(@as([*c]const u8, @ptrCast(text1)), @as([*c]const u8, @ptrCast(text2)));
}

pub fn textLength(text: [:0]const u8) u32 {
    return @as(u32, cdef.TextLength(@as([*c]const u8, @ptrCast(text))));
}

pub fn textSubtext(text: [:0]const u8, position: i32, length: i32) [:0]const u8 {
    return std.mem.span(cdef.TextSubtext(@as([*c]const u8, @ptrCast(text)), @as(c_int, position), @as(c_int, length)));
}

pub fn textReplace(text: [:0]u8, replace: [:0]const u8, by: [:0]const u8) [:0]u8 {
    return std.mem.span(cdef.TextReplace(@as([*c]u8, @ptrCast(text)), @as([*c]const u8, @ptrCast(replace)), @as([*c]const u8, @ptrCast(by))));
}

pub fn textInsert(text: [:0]const u8, insert: [:0]const u8, position: i32) [:0]u8 {
    return std.mem.span(cdef.TextInsert(@as([*c]const u8, @ptrCast(text)), @as([*c]const u8, @ptrCast(insert)), @as(c_int, position)));
}

pub fn textAppend(text: [:0]u8, append: [:0]const u8, position: *i32) void {
    cdef.TextAppend(@as([*c]u8, @ptrCast(text)), @as([*c]const u8, @ptrCast(append)), @as([*c]c_int, @ptrCast(position)));
}

pub fn textFindIndex(text: [:0]const u8, find: [:0]const u8) i32 {
    return @as(i32, cdef.TextFindIndex(@as([*c]const u8, @ptrCast(text)), @as([*c]const u8, @ptrCast(find))));
}

pub fn textToUpper(text: [:0]const u8) [:0]const u8 {
    return std.mem.span(cdef.TextToUpper(@as([*c]const u8, @ptrCast(text))));
}

pub fn textToLower(text: [:0]const u8) [:0]const u8 {
    return std.mem.span(cdef.TextToLower(@as([*c]const u8, @ptrCast(text))));
}

pub fn textToPascal(text: [:0]const u8) [:0]const u8 {
    return std.mem.span(cdef.TextToPascal(@as([*c]const u8, @ptrCast(text))));
}

pub fn textToInteger(text: [:0]const u8) i32 {
    return @as(i32, cdef.TextToInteger(@as([*c]const u8, @ptrCast(text))));
}

pub fn drawLine3D(startPos: Vector3, endPos: Vector3, color: Color) void {
    cdef.DrawLine3D(startPos, endPos, color);
}

pub fn drawPoint3D(position: Vector3, color: Color) void {
    cdef.DrawPoint3D(position, color);
}

pub fn drawCircle3D(center: Vector3, radius: f32, rotationAxis: Vector3, rotationAngle: f32, color: Color) void {
    cdef.DrawCircle3D(center, radius, rotationAxis, rotationAngle, color);
}

pub fn drawTriangle3D(v1: Vector3, v2: Vector3, v3: Vector3, color: Color) void {
    cdef.DrawTriangle3D(v1, v2, v3, color);
}

pub fn drawCube(position: Vector3, width: f32, height: f32, length: f32, color: Color) void {
    cdef.DrawCube(position, width, height, length, color);
}

pub fn drawCubeV(position: Vector3, size: Vector3, color: Color) void {
    cdef.DrawCubeV(position, size, color);
}

pub fn drawCubeWires(position: Vector3, width: f32, height: f32, length: f32, color: Color) void {
    cdef.DrawCubeWires(position, width, height, length, color);
}

pub fn drawCubeWiresV(position: Vector3, size: Vector3, color: Color) void {
    cdef.DrawCubeWiresV(position, size, color);
}

pub fn drawSphere(centerPos: Vector3, radius: f32, color: Color) void {
    cdef.DrawSphere(centerPos, radius, color);
}

pub fn drawSphereEx(centerPos: Vector3, radius: f32, rings: i32, slices: i32, color: Color) void {
    cdef.DrawSphereEx(centerPos, radius, @as(c_int, rings), @as(c_int, slices), color);
}

pub fn drawSphereWires(centerPos: Vector3, radius: f32, rings: i32, slices: i32, color: Color) void {
    cdef.DrawSphereWires(centerPos, radius, @as(c_int, rings), @as(c_int, slices), color);
}

pub fn drawCylinder(position: Vector3, radiusTop: f32, radiusBottom: f32, height: f32, slices: i32, color: Color) void {
    cdef.DrawCylinder(position, radiusTop, radiusBottom, height, @as(c_int, slices), color);
}

pub fn drawCylinderEx(startPos: Vector3, endPos: Vector3, startRadius: f32, endRadius: f32, sides: i32, color: Color) void {
    cdef.DrawCylinderEx(startPos, endPos, startRadius, endRadius, @as(c_int, sides), color);
}

pub fn drawCylinderWires(position: Vector3, radiusTop: f32, radiusBottom: f32, height: f32, slices: i32, color: Color) void {
    cdef.DrawCylinderWires(position, radiusTop, radiusBottom, height, @as(c_int, slices), color);
}

pub fn drawCylinderWiresEx(startPos: Vector3, endPos: Vector3, startRadius: f32, endRadius: f32, sides: i32, color: Color) void {
    cdef.DrawCylinderWiresEx(startPos, endPos, startRadius, endRadius, @as(c_int, sides), color);
}

pub fn drawCapsule(startPos: Vector3, endPos: Vector3, radius: f32, slices: i32, rings: i32, color: Color) void {
    cdef.DrawCapsule(startPos, endPos, radius, @as(c_int, slices), @as(c_int, rings), color);
}

pub fn drawCapsuleWires(startPos: Vector3, endPos: Vector3, radius: f32, slices: i32, rings: i32, color: Color) void {
    cdef.DrawCapsuleWires(startPos, endPos, radius, @as(c_int, slices), @as(c_int, rings), color);
}

pub fn drawPlane(centerPos: Vector3, size: Vector2, color: Color) void {
    cdef.DrawPlane(centerPos, size, color);
}

pub fn drawRay(ray: Ray, color: Color) void {
    cdef.DrawRay(ray, color);
}

pub fn drawGrid(slices: i32, spacing: f32) void {
    cdef.DrawGrid(@as(c_int, slices), spacing);
}

pub fn loadModel(fileName: [:0]const u8) Model {
    return cdef.LoadModel(@as([*c]const u8, @ptrCast(fileName)));
}

pub fn loadModelFromMesh(mesh: Mesh) Model {
    return cdef.LoadModelFromMesh(mesh);
}

pub fn isModelReady(model: Model) bool {
    return cdef.IsModelReady(model);
}

pub fn unloadModel(model: Model) void {
    cdef.UnloadModel(model);
}

pub fn getModelBoundingBox(model: Model) BoundingBox {
    return cdef.GetModelBoundingBox(model);
}

pub fn drawModel(model: Model, position: Vector3, scale: f32, tint: Color) void {
    cdef.DrawModel(model, position, scale, tint);
}

pub fn drawModelEx(model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: f32, scale: Vector3, tint: Color) void {
    cdef.DrawModelEx(model, position, rotationAxis, rotationAngle, scale, tint);
}

pub fn drawModelWires(model: Model, position: Vector3, scale: f32, tint: Color) void {
    cdef.DrawModelWires(model, position, scale, tint);
}

pub fn drawModelWiresEx(model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: f32, scale: Vector3, tint: Color) void {
    cdef.DrawModelWiresEx(model, position, rotationAxis, rotationAngle, scale, tint);
}

pub fn drawBoundingBox(box: BoundingBox, color: Color) void {
    cdef.DrawBoundingBox(box, color);
}

pub fn drawBillboard(camera: Camera, texture: Texture2D, position: Vector3, size: f32, tint: Color) void {
    cdef.DrawBillboard(camera, texture, position, size, tint);
}

pub fn drawBillboardRec(camera: Camera, texture: Texture2D, source: Rectangle, position: Vector3, size: Vector2, tint: Color) void {
    cdef.DrawBillboardRec(camera, texture, source, position, size, tint);
}

pub fn drawBillboardPro(camera: Camera, texture: Texture2D, source: Rectangle, position: Vector3, up: Vector3, size: Vector2, origin: Vector2, rotation: f32, tint: Color) void {
    cdef.DrawBillboardPro(camera, texture, source, position, up, size, origin, rotation, tint);
}

pub fn uploadMesh(mesh: *Mesh, dynamic: bool) void {
    cdef.UploadMesh(@as([*c]Mesh, @ptrCast(mesh)), dynamic);
}

pub fn updateMeshBuffer(mesh: Mesh, index: i32, data: *const anyopaque, dataSize: i32, offset: i32) void {
    cdef.UpdateMeshBuffer(mesh, @as(c_int, index), data, @as(c_int, dataSize), @as(c_int, offset));
}

pub fn unloadMesh(mesh: Mesh) void {
    cdef.UnloadMesh(mesh);
}

pub fn drawMesh(mesh: Mesh, material: Material, transform: Matrix) void {
    cdef.DrawMesh(mesh, material, transform);
}

pub fn exportMesh(mesh: Mesh, fileName: [:0]const u8) bool {
    return cdef.ExportMesh(mesh, @as([*c]const u8, @ptrCast(fileName)));
}

pub fn getMeshBoundingBox(mesh: Mesh) BoundingBox {
    return cdef.GetMeshBoundingBox(mesh);
}

pub fn genMeshTangents(mesh: *Mesh) void {
    cdef.GenMeshTangents(@as([*c]Mesh, @ptrCast(mesh)));
}

pub fn genMeshPoly(sides: i32, radius: f32) Mesh {
    return cdef.GenMeshPoly(@as(c_int, sides), radius);
}

pub fn genMeshPlane(width: f32, length: f32, resX: i32, resZ: i32) Mesh {
    return cdef.GenMeshPlane(width, length, @as(c_int, resX), @as(c_int, resZ));
}

pub fn genMeshCube(width: f32, height: f32, length: f32) Mesh {
    return cdef.GenMeshCube(width, height, length);
}

pub fn genMeshSphere(radius: f32, rings: i32, slices: i32) Mesh {
    return cdef.GenMeshSphere(radius, @as(c_int, rings), @as(c_int, slices));
}

pub fn genMeshHemiSphere(radius: f32, rings: i32, slices: i32) Mesh {
    return cdef.GenMeshHemiSphere(radius, @as(c_int, rings), @as(c_int, slices));
}

pub fn genMeshCylinder(radius: f32, height: f32, slices: i32) Mesh {
    return cdef.GenMeshCylinder(radius, height, @as(c_int, slices));
}

pub fn genMeshCone(radius: f32, height: f32, slices: i32) Mesh {
    return cdef.GenMeshCone(radius, height, @as(c_int, slices));
}

pub fn genMeshTorus(radius: f32, size: f32, radSeg: i32, sides: i32) Mesh {
    return cdef.GenMeshTorus(radius, size, @as(c_int, radSeg), @as(c_int, sides));
}

pub fn genMeshKnot(radius: f32, size: f32, radSeg: i32, sides: i32) Mesh {
    return cdef.GenMeshKnot(radius, size, @as(c_int, radSeg), @as(c_int, sides));
}

pub fn genMeshHeightmap(heightmap: Image, size: Vector3) Mesh {
    return cdef.GenMeshHeightmap(heightmap, size);
}

pub fn genMeshCubicmap(cubicmap: Image, cubeSize: Vector3) Mesh {
    return cdef.GenMeshCubicmap(cubicmap, cubeSize);
}

pub fn loadMaterialDefault() Material {
    return cdef.LoadMaterialDefault();
}

pub fn isMaterialReady(material: Material) bool {
    return cdef.IsMaterialReady(material);
}

pub fn unloadMaterial(material: Material) void {
    cdef.UnloadMaterial(material);
}

pub fn setMaterialTexture(material: *Material, mapType: i32, texture: Texture2D) void {
    cdef.SetMaterialTexture(@as([*c]Material, @ptrCast(material)), @as(c_int, mapType), texture);
}

pub fn setModelMeshMaterial(model: *Model, meshId: i32, materialId: i32) void {
    cdef.SetModelMeshMaterial(@as([*c]Model, @ptrCast(model)), @as(c_int, meshId), @as(c_int, materialId));
}

pub fn updateModelAnimation(model: Model, anim: ModelAnimation, frame: i32) void {
    cdef.UpdateModelAnimation(model, anim, @as(c_int, frame));
}

pub fn unloadModelAnimation(anim: ModelAnimation) void {
    cdef.UnloadModelAnimation(anim);
}

pub fn isModelAnimationValid(model: Model, anim: ModelAnimation) bool {
    return cdef.IsModelAnimationValid(model, anim);
}

pub fn checkCollisionSpheres(center1: Vector3, radius1: f32, center2: Vector3, radius2: f32) bool {
    return cdef.CheckCollisionSpheres(center1, radius1, center2, radius2);
}

pub fn checkCollisionBoxes(box1: BoundingBox, box2: BoundingBox) bool {
    return cdef.CheckCollisionBoxes(box1, box2);
}

pub fn checkCollisionBoxSphere(box: BoundingBox, center: Vector3, radius: f32) bool {
    return cdef.CheckCollisionBoxSphere(box, center, radius);
}

pub fn getRayCollisionSphere(ray: Ray, center: Vector3, radius: f32) RayCollision {
    return cdef.GetRayCollisionSphere(ray, center, radius);
}

pub fn getRayCollisionBox(ray: Ray, box: BoundingBox) RayCollision {
    return cdef.GetRayCollisionBox(ray, box);
}

pub fn getRayCollisionMesh(ray: Ray, mesh: Mesh, transform: Matrix) RayCollision {
    return cdef.GetRayCollisionMesh(ray, mesh, transform);
}

pub fn getRayCollisionTriangle(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3) RayCollision {
    return cdef.GetRayCollisionTriangle(ray, p1, p2, p3);
}

pub fn getRayCollisionQuad(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3, p4: Vector3) RayCollision {
    return cdef.GetRayCollisionQuad(ray, p1, p2, p3, p4);
}

pub fn initAudioDevice() void {
    cdef.InitAudioDevice();
}

pub fn closeAudioDevice() void {
    cdef.CloseAudioDevice();
}

pub fn isAudioDeviceReady() bool {
    return cdef.IsAudioDeviceReady();
}

pub fn setMasterVolume(volume: f32) void {
    cdef.SetMasterVolume(volume);
}

pub fn getMasterVolume() f32 {
    return cdef.GetMasterVolume();
}

pub fn loadWave(fileName: [:0]const u8) Wave {
    return cdef.LoadWave(@as([*c]const u8, @ptrCast(fileName)));
}

pub fn isWaveReady(wave: Wave) bool {
    return cdef.IsWaveReady(wave);
}

pub fn loadSound(fileName: [:0]const u8) Sound {
    return cdef.LoadSound(@as([*c]const u8, @ptrCast(fileName)));
}

pub fn loadSoundFromWave(wave: Wave) Sound {
    return cdef.LoadSoundFromWave(wave);
}

pub fn loadSoundAlias(source: Sound) Sound {
    return cdef.LoadSoundAlias(source);
}

pub fn isSoundReady(sound: Sound) bool {
    return cdef.IsSoundReady(sound);
}

pub fn updateSound(sound: Sound, data: *const anyopaque, sampleCount: i32) void {
    cdef.UpdateSound(sound, data, @as(c_int, sampleCount));
}

pub fn unloadWave(wave: Wave) void {
    cdef.UnloadWave(wave);
}

pub fn unloadSound(sound: Sound) void {
    cdef.UnloadSound(sound);
}

pub fn unloadSoundAlias(alias: Sound) void {
    cdef.UnloadSoundAlias(alias);
}

pub fn exportWave(wave: Wave, fileName: [:0]const u8) bool {
    return cdef.ExportWave(wave, @as([*c]const u8, @ptrCast(fileName)));
}

pub fn exportWaveAsCode(wave: Wave, fileName: [:0]const u8) bool {
    return cdef.ExportWaveAsCode(wave, @as([*c]const u8, @ptrCast(fileName)));
}

pub fn playSound(sound: Sound) void {
    cdef.PlaySound(sound);
}

pub fn stopSound(sound: Sound) void {
    cdef.StopSound(sound);
}

pub fn pauseSound(sound: Sound) void {
    cdef.PauseSound(sound);
}

pub fn resumeSound(sound: Sound) void {
    cdef.ResumeSound(sound);
}

pub fn isSoundPlaying(sound: Sound) bool {
    return cdef.IsSoundPlaying(sound);
}

pub fn setSoundVolume(sound: Sound, volume: f32) void {
    cdef.SetSoundVolume(sound, volume);
}

pub fn setSoundPitch(sound: Sound, pitch: f32) void {
    cdef.SetSoundPitch(sound, pitch);
}

pub fn setSoundPan(sound: Sound, pan: f32) void {
    cdef.SetSoundPan(sound, pan);
}

pub fn waveCopy(wave: Wave) Wave {
    return cdef.WaveCopy(wave);
}

pub fn waveCrop(wave: *Wave, initSample: i32, finalSample: i32) void {
    cdef.WaveCrop(@as([*c]Wave, @ptrCast(wave)), @as(c_int, initSample), @as(c_int, finalSample));
}

pub fn waveFormat(wave: *Wave, sampleRate: i32, sampleSize: i32, channels: i32) void {
    cdef.WaveFormat(@as([*c]Wave, @ptrCast(wave)), @as(c_int, sampleRate), @as(c_int, sampleSize), @as(c_int, channels));
}

pub fn unloadWaveSamples(samples: []f32) void {
    cdef.UnloadWaveSamples(@as([*c]f32, @ptrCast(samples)));
}

pub fn loadMusicStream(fileName: [:0]const u8) Music {
    return cdef.LoadMusicStream(@as([*c]const u8, @ptrCast(fileName)));
}

pub fn isMusicReady(music: Music) bool {
    return cdef.IsMusicReady(music);
}

pub fn unloadMusicStream(music: Music) void {
    cdef.UnloadMusicStream(music);
}

pub fn playMusicStream(music: Music) void {
    cdef.PlayMusicStream(music);
}

pub fn isMusicStreamPlaying(music: Music) bool {
    return cdef.IsMusicStreamPlaying(music);
}

pub fn updateMusicStream(music: Music) void {
    cdef.UpdateMusicStream(music);
}

pub fn stopMusicStream(music: Music) void {
    cdef.StopMusicStream(music);
}

pub fn pauseMusicStream(music: Music) void {
    cdef.PauseMusicStream(music);
}

pub fn resumeMusicStream(music: Music) void {
    cdef.ResumeMusicStream(music);
}

pub fn seekMusicStream(music: Music, position: f32) void {
    cdef.SeekMusicStream(music, position);
}

pub fn setMusicVolume(music: Music, volume: f32) void {
    cdef.SetMusicVolume(music, volume);
}

pub fn setMusicPitch(music: Music, pitch: f32) void {
    cdef.SetMusicPitch(music, pitch);
}

pub fn setMusicPan(music: Music, pan: f32) void {
    cdef.SetMusicPan(music, pan);
}

pub fn getMusicTimeLength(music: Music) f32 {
    return cdef.GetMusicTimeLength(music);
}

pub fn getMusicTimePlayed(music: Music) f32 {
    return cdef.GetMusicTimePlayed(music);
}

pub fn loadAudioStream(sampleRate: u32, sampleSize: u32, channels: u32) AudioStream {
    return cdef.LoadAudioStream(@as(c_uint, sampleRate), @as(c_uint, sampleSize), @as(c_uint, channels));
}

pub fn isAudioStreamReady(stream: AudioStream) bool {
    return cdef.IsAudioStreamReady(stream);
}

pub fn unloadAudioStream(stream: AudioStream) void {
    cdef.UnloadAudioStream(stream);
}

pub fn updateAudioStream(stream: AudioStream, data: *const anyopaque, frameCount: i32) void {
    cdef.UpdateAudioStream(stream, data, @as(c_int, frameCount));
}

pub fn isAudioStreamProcessed(stream: AudioStream) bool {
    return cdef.IsAudioStreamProcessed(stream);
}

pub fn playAudioStream(stream: AudioStream) void {
    cdef.PlayAudioStream(stream);
}

pub fn pauseAudioStream(stream: AudioStream) void {
    cdef.PauseAudioStream(stream);
}

pub fn resumeAudioStream(stream: AudioStream) void {
    cdef.ResumeAudioStream(stream);
}

pub fn isAudioStreamPlaying(stream: AudioStream) bool {
    return cdef.IsAudioStreamPlaying(stream);
}

pub fn stopAudioStream(stream: AudioStream) void {
    cdef.StopAudioStream(stream);
}

pub fn setAudioStreamVolume(stream: AudioStream, volume: f32) void {
    cdef.SetAudioStreamVolume(stream, volume);
}

pub fn setAudioStreamPitch(stream: AudioStream, pitch: f32) void {
    cdef.SetAudioStreamPitch(stream, pitch);
}

pub fn setAudioStreamPan(stream: AudioStream, pan: f32) void {
    cdef.SetAudioStreamPan(stream, pan);
}

pub fn setAudioStreamBufferSizeDefault(size: i32) void {
    cdef.SetAudioStreamBufferSizeDefault(@as(c_int, size));
}

pub fn setAudioStreamCallback(stream: AudioStream, callback: AudioCallback) void {
    cdef.SetAudioStreamCallback(stream, callback);
}

pub fn attachAudioStreamProcessor(stream: AudioStream, processor: AudioCallback) void {
    cdef.AttachAudioStreamProcessor(stream, processor);
}

pub fn detachAudioStreamProcessor(stream: AudioStream, processor: AudioCallback) void {
    cdef.DetachAudioStreamProcessor(stream, processor);
}

pub fn attachAudioMixedProcessor(processor: AudioCallback) void {
    cdef.AttachAudioMixedProcessor(processor);
}

pub fn detachAudioMixedProcessor(processor: AudioCallback) void {
    cdef.DetachAudioMixedProcessor(processor);
}

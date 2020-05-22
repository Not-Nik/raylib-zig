//
// raylib-zig
// Zig version:
// Author: Nikolas Wipper
// Date: 2020-02-15
//

pub const Vector2 = extern struct {
    x: f32,
    y: f32,
};

pub const Vector3 = extern struct {
    x: f32,
    y: f32,
    z: f32,
};

pub const float3 = extern struct {
    v: [3]f32,
};

pub const float16 = extern struct {
    v: [16]f32,
};

pub const Vector4 = extern struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32,
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
};

pub const LIGHTGRAY  = Color { .r = 200,    .g = 200,   .b = 200,   .a = 255 };
pub const GRAY       = Color { .r = 130,    .g = 130,   .b = 130,   .a = 255 };
pub const DARKGRAY   = Color { .r = 80,     .g = 80,    .b = 80,    .a = 255 };
pub const YELLOW     = Color { .r = 253,    .g = 249,   .b = 0,     .a = 255 };
pub const GOLD       = Color { .r = 255,    .g = 203,   .b = 0,     .a = 255 };
pub const ORANGE     = Color { .r = 255,    .g = 161,   .b = 0,     .a = 255 };
pub const PINK       = Color { .r = 255,    .g = 109,   .b = 194,   .a = 255 };
pub const RED        = Color { .r = 230,    .g = 41,    .b = 55,    .a = 255 };
pub const MAROON     = Color { .r = 190,    .g = 33,    .b = 55,    .a = 255 };
pub const GREEN      = Color { .r = 0,      .g = 228,   .b = 48,    .a = 255 };
pub const LIME       = Color { .r = 0,      .g = 158,   .b = 47,    .a = 255 };
pub const DARKGREEN  = Color { .r = 0,      .g = 117,   .b = 44,    .a = 255 };
pub const SKYBLUE    = Color { .r = 102,    .g = 191,   .b = 255,   .a = 255 };
pub const BLUE       = Color { .r = 0,      .g = 121,   .b = 241,   .a = 255 };
pub const DARKBLUE   = Color { .r = 0,      .g = 82,    .b = 172,   .a = 255 };
pub const PURPLE     = Color { .r = 200,    .g = 122,   .b = 255,   .a = 255 };
pub const VIOLET     = Color { .r = 135,    .g = 60,    .b = 190,   .a = 255 };
pub const DARKPURPLE = Color { .r = 112,    .g = 31,    .b = 126,   .a = 255 };
pub const BEIGE      = Color { .r = 211,    .g = 176,   .b = 131,   .a = 255 };
pub const BROWN      = Color { .r = 127,    .g = 106,   .b = 79,    .a = 255 };
pub const DARKBROWN  = Color { .r = 76,     .g = 63,    .b = 47,    .a = 255 };

pub const WHITE      = Color {.r = 255,     .g = 255,   .b = 255,   .a = 255 };
pub const BLACK      = Color { .r = 0,      .g = 0,     .b = 0,     .a = 255 };
pub const BLANK      = Color { .r = 0,      .g = 0,     .b = 0,     .a = 0   };
pub const MAGENTA    = Color { .r = 255,    .g = 0,     .b = 255,   .a = 255 };
pub const RAYWHITE   = Color { .r = 245,    .g = 245,   .b = 245,   .a = 255 };

pub const Rectangle = extern struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,
};

pub const Image = extern struct {
    data: ?*c_void,
    width: c_int,
    height: c_int,
    mipmaps: c_int,
    format: PixelFormat,

    pub fn init(fileName: [*c]const u8) Image {
        return LoadImage(fileName);
    }

    pub fn initEx(pixels: [*c]Color, width: c_int, height: c_int) Image {
        return LoadImageEx(pixels, width, height);
    }

    pub fn initPro(data: ?*c_void, width: c_int, height: c_int, format: PixelFormat) Image {
        return LoadImagePro(data, width, height, format);
    }

    pub fn initRaw(fileName: [*c]const u8, width: c_int, height: c_int, format: PixelFormat, headerSize: c_int) Image {
        return LoadImageRaw(fileName, width, height, format, headerSize);
    }

    pub fn initText(text: [*c]const u8, fontSize: c_int, color: Color) Image {
        return ImageText(text, fontSize, color);
    }

    pub fn initTextEx(font: Font, text: [*c]const u8, fontSize: f32, spacing: f32, tint: Color) Image {
        return ImageTextEx(font, text, fontSize, spacing, tint);
    }

    pub fn copy(image: Image) Image {
        return ImageCopy(image);
    }

    pub fn copyRec(image: Image, rec: Rectangle) Image {
        return ImageFromImage(image, rec);
    }

    pub fn GenColor(width: c_int, height: c_int, color: Color) Image {
        return GenImageColor(width, height, color);
    }

    pub fn GenGradientV(width: c_int, height: c_int, top: Color, bottom: Color) Image {
        return GenImageGradientV(width, height, top, bottom);
    }

    pub fn GenGradientV(width: c_int, height: c_int, left: Color, right: Color) Image {
        return GenImageGradientV(width, height, left, right);
    }

    pub fn GenGradientRadial(width: c_int, height: c_int, density: f32, inner: Color, outer: Color) Image {
        return GenImageGradientRadial(width, height, density, innter, outer);
    }

    pub fn GenChecked(width: c_int, height: c_int, checksX: c_int, checksY: c_int, col1: Color, col2: Color) Image {
        return GenImageChecked(width, height, checksX, checksY, col1, col2);
    }

    pub fn GenWhiteNoise(width: c_int, height: c_int, factor: f32) Image {
        return GenImageWhiteNoise(width, height, factor);
    }

    pub fn GenPerlinNoise(width: c_int, height: c_int, offsetX: c_int, offsetY: c_int, scale: f32) Image {
        return GenImagePerlinNoise(width, height, offsetX, offsetY, scale);
    }

    pub fn GenCellular(width: c_int, height: c_int, tileSize: c_int) Image {
        return GenImageCellular(width, height, tileSize);
    }

    pub fn GetData(self: Image) [*c]Color {
        return GetImageData(self);
    }

    pub fn GetDataNormalized(self: Image) [*c]Color {
        return GetImageDataNormalized(self);
    }

    pub fn UseAsWindowIcon(self: Image) void {
        SetWindowIcon(self);
    }
};

pub const Texture2D = extern struct {
    id: c_uint,
    width: c_int,
    height: c_int,
    mipmaps: c_int,
    format: c_int,
};

pub const Texture = Texture2D;
pub const TextureCubemap = Texture2D;

pub const RenderTexture2D = extern struct {
    id: c_uint,
    texture: Texture2D,
    depth: Texture2D,
    depthTexture: bool,

    pub fn Begin(self: RenderTexture2D) void {
        BeginTextureMode(self);
    }

    pub fn End(self: RenderTexture2D) void {
        EndTextureMode();
    }
};
pub const RenderTexture = RenderTexture2D;

pub const NPatchInfo = extern struct {
    sourceRec: Rectangle,
    left: c_int,
    top: c_int,
    right: c_int,
    bottom: c_int,
    type: c_int,
};

pub const CharInfo = extern struct {
    value: c_int,
    offsetX: c_int,
    offsetY: c_int,
    advanceX: c_int,
    image: Image,
};

pub const Font = extern struct {
    baseSize: c_int,
    charsCount: c_int,
    texture: Texture2D,
    recs: [*c]Rectangle,
    chars: [*c]CharInfo,
};

pub const Camera3D = extern struct {
    position: Vector3,
    target: Vector3,
    up: Vector3,
    fovy: f32,
    type: CameraType,

    pub fn Begin(self: Camera3D) void {
        BeginMode3D(self);
    }

    pub fn Update(self: *Camera3D) void {
        UpdateCamera(self);
    }

    pub fn GetMatrix(self: Camera3D) Matrix {
        return GetCameraMatrix(self);
    }

    pub fn SetMode(self: Camera3D, mode: CameraMode) void {
        SetCameraMode(self, mode);
    }

    pub fn End(self: Camera3D) void {
        EndMode3D();
    }
};
pub const Camera = Camera3D;

pub const Camera2D = extern struct {
    offset: Vector2,
    target: Vector2,
    rotation: f32,
    zoom: f32,

    pub fn Begin(self: Camera2D) void {
        BeginMode2D(self);
    }

    pub fn GetMatrix(self: Camera2D) Matrix {
        return GetCameraMatrix2D(self);
    }

    pub fn End(self: Camera2D) void {
        EndMode2D();
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
    boneIds: [*c]c_int,
    boneWeights: [*c]f32,
    vaoId: c_uint,
    vboId: [*c]c_uint,
};

pub const Shader = extern struct {
    id: c_uint,
    locs: [*c]c_int,
};

pub const MaterialMap = extern struct {
    texture: Texture2D,
    color: Color,
    value: f32,
};

pub const Material = extern struct {
    shader: Shader,
    maps: [*c]MaterialMap,
    params: [*c]f32,
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
    meshes: [*c]Mesh,
    materialCount: c_int,
    materials: [*c]Material,
    meshMaterial: [*c]c_int,
    boneCount: c_int,
    bones: [*c]BoneInfo,
    bindPose: [*c]Transform,
};

pub const ModelAnimation = extern struct {
    boneCount: c_int,
    bones: [*c]BoneInfo,
    frameCount: c_int,
    framePoses: [*c][*c]Transform,
};

pub const Ray = extern struct {
    position: Vector3,
    direction: Vector3,
};

pub const RayHitInfo = extern struct {
    hit: bool,
    distance: f32,
    position: Vector3,
    normal: Vector3,
};

pub const BoundingBox = extern struct {
    min: Vector3,
    max: Vector3,

    pub fn init(mesh: Mesh) BoundingBox {
        return MeshBoundingBox(mesh);
    }

    pub fn Draw(self: BoundingBox, color: Color) void {
        DrawBoundingBox(self, color);
    }
};

pub const Wave = extern struct {
    sampleCount: c_uint,
    sampleRate: c_uint,
    sampleSize: c_uint,
    channels: c_uint,
    data: ?*c_void,
};

pub const rAudioBuffer = @OpaqueType();
pub const AudioStream = extern struct {
    sampleRate: c_uint,
    sampleSize: c_uint,
    channels: c_uint,
    buffer: ?*rAudioBuffer,
};

pub const Sound = extern struct {
    sampleCount: c_uint,
    stream: AudioStream,
};

pub const Music = extern struct {
    ctxType: c_int,
    ctxData: ?*c_void,
    sampleCount: c_uint,
    loopCount: c_uint,
    stream: AudioStream,
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
const ConfigFlag = extern enum(c_int) {
    FLAG_RESERVED = 1,
    FLAG_FULLSCREEN_MODE = 2,
    FLAG_WINDOW_RESIZABLE = 4,
    FLAG_WINDOW_UNDECORATED = 8,
    FLAG_WINDOW_TRANSPARENT = 16,
    FLAG_WINDOW_HIDDEN = 128,
    FLAG_WINDOW_ALWAYS_RUN = 256,
    FLAG_MSAA_4X_HINT = 32,
    FLAG_VSYNC_HINT = 64,
};

pub const TraceLogType = extern enum(c_int) {
    LOG_ALL = 0,
    LOG_TRACE = 1,
    LOG_DEBUG = 2,
    LOG_INFO = 3,
    LOG_WARNING = 4,
    LOG_ERROR = 5,
    LOG_FATAL = 6,
    LOG_NONE = 7,
};
pub const KeyboardKey = extern enum(c_int) {
    KEY_NULL = 0,
    KEY_APOSTROPHE = 39,
    KEY_COMMA = 44,
    KEY_MINUS = 45,
    KEY_PERIOD = 46,
    KEY_SLASH = 47,
    KEY_ZERO = 48,
    KEY_ONE = 49,
    KEY_TWO = 50,
    KEY_THREE = 51,
    KEY_FOUR = 52,
    KEY_FIVE = 53,
    KEY_SIX = 54,
    KEY_SEVEN = 55,
    KEY_EIGHT = 56,
    KEY_NINE = 57,
    KEY_SEMICOLON = 59,
    KEY_EQUAL = 61,
    KEY_A = 65,
    KEY_B = 66,
    KEY_C = 67,
    KEY_D = 68,
    KEY_E = 69,
    KEY_F = 70,
    KEY_G = 71,
    KEY_H = 72,
    KEY_I = 73,
    KEY_J = 74,
    KEY_K = 75,
    KEY_L = 76,
    KEY_M = 77,
    KEY_N = 78,
    KEY_O = 79,
    KEY_P = 80,
    KEY_Q = 81,
    KEY_R = 82,
    KEY_S = 83,
    KEY_T = 84,
    KEY_U = 85,
    KEY_V = 86,
    KEY_W = 87,
    KEY_X = 88,
    KEY_Y = 89,
    KEY_Z = 90,
    KEY_SPACE = 32,
    KEY_ESCAPE = 256,
    KEY_ENTER = 257,
    KEY_TAB = 258,
    KEY_BACKSPACE = 259,
    KEY_INSERT = 260,
    KEY_DELETE = 261,
    KEY_RIGHT = 262,
    KEY_LEFT = 263,
    KEY_DOWN = 264,
    KEY_UP = 265,
    KEY_PAGE_UP = 266,
    KEY_PAGE_DOWN = 267,
    KEY_HOME = 268,
    KEY_END = 269,
    KEY_CAPS_LOCK = 280,
    KEY_SCROLL_LOCK = 281,
    KEY_NUM_LOCK = 282,
    KEY_PRINT_SCREEN = 283,
    KEY_PAUSE = 284,
    KEY_F1 = 290,
    KEY_F2 = 291,
    KEY_F3 = 292,
    KEY_F4 = 293,
    KEY_F5 = 294,
    KEY_F6 = 295,
    KEY_F7 = 296,
    KEY_F8 = 297,
    KEY_F9 = 298,
    KEY_F10 = 299,
    KEY_F11 = 300,
    KEY_F12 = 301,
    KEY_LEFT_SHIFT = 340,
    KEY_LEFT_CONTROL = 341,
    KEY_LEFT_ALT = 342,
    KEY_LEFT_SUPER = 343,
    KEY_RIGHT_SHIFT = 344,
    KEY_RIGHT_CONTROL = 345,
    KEY_RIGHT_ALT = 346,
    KEY_RIGHT_SUPER = 347,
    KEY_KB_MENU = 348,
    KEY_LEFT_BRACKET = 91,
    KEY_BACKSLASH = 92,
    KEY_RIGHT_BRACKET = 93,
    KEY_GRAVE = 96,
    KEY_KP_0 = 320,
    KEY_KP_1 = 321,
    KEY_KP_2 = 322,
    KEY_KP_3 = 323,
    KEY_KP_4 = 324,
    KEY_KP_5 = 325,
    KEY_KP_6 = 326,
    KEY_KP_7 = 327,
    KEY_KP_8 = 328,
    KEY_KP_9 = 329,
    KEY_KP_DECIMAL = 330,
    KEY_KP_DIVIDE = 331,
    KEY_KP_MULTIPLY = 332,
    KEY_KP_SUBTRACT = 333,
    KEY_KP_ADD = 334,
    KEY_KP_ENTER = 335,
    KEY_KP_EQUAL = 336,
};

pub const AndroidButton = extern enum(c_int) {
    KEY_BACK = 4,
    KEY_MENU = 82,
    KEY_VOLUME_UP = 24,
    KEY_VOLUME_DOWN = 25,
};

pub const MouseButton = extern enum(c_int) {
    MOUSE_LEFT_BUTTON = 0,
    MOUSE_RIGHT_BUTTON = 1,
    MOUSE_MIDDLE_BUTTON = 2,
};

pub const GamepadNumber = extern enum(c_int) {
    GAMEPAD_PLAYER1 = 0,
    GAMEPAD_PLAYER2 = 1,
    GAMEPAD_PLAYER3 = 2,
    GAMEPAD_PLAYER4 = 3,
};

pub const GamepadButton = extern enum(c_int) {
    GAMEPAD_BUTTON_UNKNOWN = 0,
    GAMEPAD_BUTTON_LEFT_FACE_UP = 1,
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT = 2,
    GAMEPAD_BUTTON_LEFT_FACE_DOWN = 3,
    GAMEPAD_BUTTON_LEFT_FACE_LEFT = 4,
    GAMEPAD_BUTTON_RIGHT_FACE_UP = 5,
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6,
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN = 7,
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT = 8,
    GAMEPAD_BUTTON_LEFT_TRIGGER_1 = 9,
    GAMEPAD_BUTTON_LEFT_TRIGGER_2 = 10,
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = 11,
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = 12,
    GAMEPAD_BUTTON_MIDDLE_LEFT = 13,
    GAMEPAD_BUTTON_MIDDLE = 14,
    GAMEPAD_BUTTON_MIDDLE_RIGHT = 15,
    GAMEPAD_BUTTON_LEFT_THUMB = 16,
    GAMEPAD_BUTTON_RIGHT_THUMB = 17,
};

pub const GamepadAxis = extern enum(c_int) {
    GAMEPAD_AXIS_UNKNOWN = 0,
    GAMEPAD_AXIS_LEFT_X = 1,
    GAMEPAD_AXIS_LEFT_Y = 2,
    GAMEPAD_AXIS_RIGHT_X = 3,
    GAMEPAD_AXIS_RIGHT_Y = 4,
    GAMEPAD_AXIS_LEFT_TRIGGER = 5,
    GAMEPAD_AXIS_RIGHT_TRIGGER = 6,
};

pub const ShaderLocationIndex = extern enum(c_int) {
    LOC_VERTEX_POSITION = 0,
    LOC_VERTEX_TEXCOORD01 = 1,
    LOC_VERTEX_TEXCOORD02 = 2,
    LOC_VERTEX_NORMAL = 3,
    LOC_VERTEX_TANGENT = 4,
    LOC_VERTEX_COLOR = 5,
    LOC_MATRIX_MVP = 6,
    LOC_MATRIX_MODEL = 7,
    LOC_MATRIX_VIEW = 8,
    LOC_MATRIX_PROJECTION = 9,
    LOC_VECTOR_VIEW = 10,
    LOC_COLOR_DIFFUSE = 11,
    LOC_COLOR_SPECULAR = 12,
    LOC_COLOR_AMBIENT = 13,
    LOC_MAP_ALBEDO = 14,
    LOC_MAP_METALNESS = 15,
    LOC_MAP_NORMAL = 16,
    LOC_MAP_ROUGHNESS = 17,
    LOC_MAP_OCCLUSION = 18,
    LOC_MAP_EMISSION = 19,
    LOC_MAP_HEIGHT = 20,
    LOC_MAP_CUBEMAP = 21,
    LOC_MAP_IRRADIANCE = 22,
    LOC_MAP_PREFILTER = 23,
    LOC_MAP_BRDF = 24,
};

pub const ShaderUniformDataType = extern enum(c_int) {
    UNIFORM_FLOAT = 0,
    UNIFORM_VEC2 = 1,
    UNIFORM_VEC3 = 2,
    UNIFORM_VEC4 = 3,
    UNIFORM_INT = 4,
    UNIFORM_IVEC2 = 5,
    UNIFORM_IVEC3 = 6,
    UNIFORM_IVEC4 = 7,
    UNIFORM_SAMPLER2D = 8,
};

pub const MaterialMapType = extern enum(c_int) {
    MAP_ALBEDO = 0,
    MAP_METALNESS = 1,
    MAP_NORMAL = 2,
    MAP_ROUGHNESS = 3,
    MAP_OCCLUSION = 4,
    MAP_EMISSION = 5,
    MAP_HEIGHT = 6,
    MAP_CUBEMAP = 7,
    MAP_IRRADIANCE = 8,
    MAP_PREFILTER = 9,
    MAP_BRDF = 10,
};

pub const PixelFormat = extern enum(c_int) {
    UNCOMPRESSED_GRAYSCALE = 1,
    UNCOMPRESSED_GRAY_ALPHA = 2,
    UNCOMPRESSED_R5G6B5 = 3,
    UNCOMPRESSED_R8G8B8 = 4,
    UNCOMPRESSED_R5G5B5A1 = 5,
    UNCOMPRESSED_R4G4B4A4 = 6,
    UNCOMPRESSED_R8G8B8A8 = 7,
    UNCOMPRESSED_R32 = 8,
    UNCOMPRESSED_R32G32B32 = 9,
    UNCOMPRESSED_R32G32B32A32 = 10,
    COMPRESSED_DXT1_RGB = 11,
    COMPRESSED_DXT1_RGBA = 12,
    COMPRESSED_DXT3_RGBA = 13,
    COMPRESSED_DXT5_RGBA = 14,
    COMPRESSED_ETC1_RGB = 15,
    COMPRESSED_ETC2_RGB = 16,
    COMPRESSED_ETC2_EAC_RGBA = 17,
    COMPRESSED_PVRT_RGB = 18,
    COMPRESSED_PVRT_RGBA = 19,
    COMPRESSED_ASTC_4x4_RGBA = 20,
    COMPRESSED_ASTC_8x8_RGBA = 21,
};

pub const TextureFilterMode = extern enum(c_int) {
    FILTER_POINT = 0,
    FILTER_BILINEAR = 1,
    FILTER_TRILINEAR = 2,
    FILTER_ANISOTROPIC_4X = 3,
    FILTER_ANISOTROPIC_8X = 4,
    FILTER_ANISOTROPIC_16X = 5,
};

pub const CubemapLayoutType = extern enum(c_int) {
    CUBEMAP_AUTO_DETECT = 0,
    CUBEMAP_LINE_VERTICAL = 1,
    CUBEMAP_LINE_HORIZONTAL = 2,
    CUBEMAP_CROSS_THREE_BY_FOUR = 3,
    CUBEMAP_CROSS_FOUR_BY_THREE = 4,
    CUBEMAP_PANORAMA = 5,
};

pub const TextureWrapMode = extern enum(c_int) {
    WRAP_REPEAT = 0,
    WRAP_CLAMP = 1,
    WRAP_MIRROR_REPEAT = 2,
    WRAP_MIRROR_CLAMP = 3,
};

pub const FontType = extern enum(c_int) {
    FONT_DEFAULT = 0,
    FONT_BITMAP = 1,
    FONT_SDF = 2,
};

pub const BlendMode = extern enum(c_int) {
    BLEND_ALPHA = 0,
    BLEND_ADDITIVE = 1,
    BLEND_MULTIPLIED = 2,
};

pub const GestureType = extern enum(c_int) {
    GESTURE_NONE = 0,
    GESTURE_TAP = 1,
    GESTURE_DOUBLETAP = 2,
    GESTURE_HOLD = 4,
    GESTURE_DRAG = 8,
    GESTURE_SWIPE_RIGHT = 16,
    GESTURE_SWIPE_LEFT = 32,
    GESTURE_SWIPE_UP = 64,
    GESTURE_SWIPE_DOWN = 128,
    GESTURE_PINCH_IN = 256,
    GESTURE_PINCH_OUT = 512,
};

pub const CameraMode = extern enum(c_int) {
    CAMERA_CUSTOM = 0,
    CAMERA_FREE = 1,
    CAMERA_ORBITAL = 2,
    CAMERA_FIRST_PERSON = 3,
    CAMERA_THIRD_PERSON = 4,
};

pub const CameraType = extern enum(c_int) {
    CAMERA_PERSPECTIVE = 0,
    CAMERA_ORTHOGRAPHIC = 1,
};

pub const NPatchType = extern enum(c_int) {
    NPT_9PATCH = 0,
    NPT_3PATCH_VERTICAL = 1,
    NPT_3PATCH_HORIZONTAL = 2,
};

pub const MAP_DIFFUSE = MaterialMapType.MAP_ALBEDO;
pub const MAP_SPECULAR = MaterialMapType.MAP_METALNESS;
pub const LOC_MAP_SPECULAR = LOC_MAP_METALNESS;
pub const LOC_MAP_DIFFUSE = LOC_MAP_ALBEDO;

pub const MAX_TOUCH_POINTS = 10;
pub const MAX_MATERIAL_MAPS = 12;
pub const MAX_SHADER_LOCATIONS = 32;

pub const PI = 3.141593;

pub const SpriteFont = Font;
pub const SubText = TextSubtext;
pub const ShowWindow = UnhideWindow;
pub const FormatText = TextFormat;

pub usingnamespace @import("raylib-wa.zig");

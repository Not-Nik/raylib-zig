//
// rayzig
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
    width: i32,
    height: i32,
    mipmaps: i32,
    format: i32,
};

pub const Texture2D = extern struct {
    id: ui32,
    width: i32,
    height: i32,
    mipmaps: i32,
    format: i32,
};
pub const Texture = Texture2D;
pub const TextureCubemap = Texture2D;

pub const RenderTexture2D = extern struct {
    id: ui32,
    texture: Texture2D,
    depth: Texture2D,
    depthTexture: bool,
};
pub const RenderTexture = RenderTexture2D;

pub const NPatchInfo = extern struct {
    sourceRec: Rectangle,
    left: i32,
    top: i32,
    right: i32,
    bottom: i32,
    type: i32,
};

pub const CharInfo = extern struct {
    value: i32,
    rec: Rectangle,
    offsetX: i32,
    offsetY: i32,
    advanceX: i32,
    data: [*c]u8,
};

pub const Font = extern struct {
    texture: Texture2D,
    baseSize: i32,
    charsCount: i32,
    chars: [*c]CharInfo,
};

pub const Camera3D = extern struct {
    position: Vector3,
    target: Vector3,
    up: Vector3,
    fovy: f32,
    type: i32,
};
pub const Camera = Camera3D;

pub const Camera2D = extern struct {
    offset: Vector2,
    target: Vector2,
    rotation: f32,
    zoom: f32,
};

pub const Mesh = extern struct {
    vertexCount: i32,
    triangleCount: i32,
    vertices: [*c]f32,
    texcoords: [*c]f32,
    texcoords2: [*c]f32,
    normals: [*c]f32,
    tangents: [*c]f32,
    colors: [*c]u8,
    indices: [*c]c_ushort,
    animVertices: [*c]f32,
    animNormals: [*c]f32,
    boneIds: [*c]i32,
    boneWeights: [*c]f32,
    vaoId: ui32,
    vboId: [7]ui32,
};

pub const Shader = extern struct {
    id: ui32,
    locs: [32]i32,
};

pub const MaterialMap = extern struct {
    texture: Texture2D,
    color: Color,
    value: f32,
};

pub const Material = extern struct {
    shader: Shader,
    maps: [12]MaterialMap,
    params: [*c]f32,
};

pub const Transform = extern struct {
    translation: Vector3,
    rotation: Quaternion,
    scale: Vector3,
};

pub const BoneInfo = extern struct {
    name: [32]u8,
    parent: i32,
};

pub const Model = extern struct {
    transform: Matrix,
    meshCount: i32,
    meshes: [*c]Mesh,
    materialCount: i32,
    materials: [*c]Material,
    meshMaterial: [*c]i32,
    boneCount: i32,
    bones: [*c]BoneInfo,
    bindPose: [*c]Transform,
};

pub const ModelAnimation = extern struct {
    boneCount: i32,
    bones: [*c]BoneInfo,
    frameCount: i32,
    framePoses: [*c]([*c]Transform),
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
};

pub const Wave = extern struct {
    sampleCount: ui32,
    sampleRate: ui32,
    sampleSize: ui32,
    channels: ui32,
    data: ?*c_void,
};

pub const Sound = extern struct {
    audioBuffer: ?*c_void,
    source: ui32,
    buffer: ui32,
    format: i32,
};

pub const MusicData = @OpaqueType();
pub const Music = ?*MusicData;

pub const AudioStream = extern struct {
    sampleRate: ui32,
    sampleSize: ui32,
    channels: ui32,
    audioBuffer: ?*c_void,
    format: i32,
    source: ui32,
    buffers: [2]ui32,
};

pub const VrDeviceInfo = extern struct {
    hResolution: i32,
    vResolution: i32,
    hScreenSize: f32,
    vScreenSize: f32,
    vScreenCenter: f32,
    eyeToScreenDistance: f32,
    lensSeparationDistance: f32,
    interpupillaryDistance: f32,
    lensDistortionValues: [4]f32,
    chromaAbCorrection: [4]f32,
};

pub const ConfigFlag = extern enum {
    FLAG_SHOW_LOGO = 1,
    FLAG_FULLSCREEN_MODE = 2,
    FLAG_WINDOW_RESIZABLE = 4,
    FLAG_WINDOW_UNDECORATED = 8,
    FLAG_WINDOW_TRANSPARENT = 16,
    FLAG_WINDOW_HIDDEN = 128,
    FLAG_MSAA_4X_HINT = 32,
    FLAG_VSYNC_HINT = 64,
};

pub const TraceLogType = extern enum {
    LOG_ALL = 0,
    LOG_TRACE = 1,
    LOG_DEBUG = 2,
    LOG_INFO = 3,
    LOG_WARNING = 4,
    LOG_ERROR = 5,
    LOG_FATAL = 6,
    LOG_NONE = 7,
};
pub const KeyboardKey = extern enum {
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

pub const AndroidButton = extern enum {
    KEY_BACK = 4,
    KEY_MENU = 82,
    KEY_VOLUME_UP = 24,
    KEY_VOLUME_DOWN = 25,
};

pub const MouseButton = extern enum {
    MOUSE_LEFT_BUTTON = 0,
    MOUSE_RIGHT_BUTTON = 1,
    MOUSE_MIDDLE_BUTTON = 2,
};

pub const GamepadNumber = extern enum {
    GAMEPAD_PLAYER1 = 0,
    GAMEPAD_PLAYER2 = 1,
    GAMEPAD_PLAYER3 = 2,
    GAMEPAD_PLAYER4 = 3,
};

pub const GamepadButton = extern enum {
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

pub const GamepadAxis = extern enum {
    GAMEPAD_AXIS_UNKNOWN = 0,
    GAMEPAD_AXIS_LEFT_X = 1,
    GAMEPAD_AXIS_LEFT_Y = 2,
    GAMEPAD_AXIS_RIGHT_X = 3,
    GAMEPAD_AXIS_RIGHT_Y = 4,
    GAMEPAD_AXIS_LEFT_TRIGGER = 5,
    GAMEPAD_AXIS_RIGHT_TRIGGER = 6,
};

pub const ShaderLocationIndex = extern enum {
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

pub const ShaderUniformDataType = extern enum {
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

pub const MaterialMapType = extern enum {
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

pub const PixelFormat = extern enum {
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

pub const TextureFilterMode = extern enum {
    FILTER_POINT = 0,
    FILTER_BILINEAR = 1,
    FILTER_TRILINEAR = 2,
    FILTER_ANISOTROPIC_4X = 3,
    FILTER_ANISOTROPIC_8X = 4,
    FILTER_ANISOTROPIC_16X = 5,
};

pub const CubemapLayoutType = extern enum {
    CUBEMAP_AUTO_DETECT = 0,
    CUBEMAP_LINE_VERTICAL = 1,
    CUBEMAP_LINE_HORIZONTAL = 2,
    CUBEMAP_CROSS_THREE_BY_FOUR = 3,
    CUBEMAP_CROSS_FOUR_BY_THREE = 4,
    CUBEMAP_PANORAMA = 5,
};

pub const TextureWrapMode = extern enum {
    WRAP_REPEAT = 0,
    WRAP_CLAMP = 1,
    WRAP_MIRROR_REPEAT = 2,
    WRAP_MIRROR_CLAMP = 3,
};

pub const FontType = extern enum {
    FONT_DEFAULT = 0,
    FONT_BITMAP = 1,
    FONT_SDF = 2,
};

pub const BlendMode = extern enum {
    BLEND_ALPHA = 0,
    BLEND_ADDITIVE = 1,
    BLEND_MULTIPLIED = 2,
};

pub const GestureType = extern enum {
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

pub const CameraMode = extern enum {
    CAMERA_CUSTOM = 0,
    CAMERA_FREE = 1,
    CAMERA_ORBITAL = 2,
    CAMERA_FIRST_PERSON = 3,
    CAMERA_THIRD_PERSON = 4,
};

pub const CameraType = extern enum {
    CAMERA_PERSPECTIVE = 0,
    CAMERA_ORTHOGRAPHIC = 1,
};

pub const NPatchType = extern enum {
    NPT_9PATCH = 0,
    NPT_3PATCH_VERTICAL = 1,
    NPT_3PATCH_HORIZONTAL = 2,
};

pub extern fn InitWindow(width: i32, height: i32, title: [*c]const u8) void;
pub extern fn WindowShouldClose() bool;
pub extern fn CloseWindow() void;
pub extern fn IsWindowReady() bool;
pub extern fn IsWindowMinimized() bool;
pub extern fn IsWindowResized() bool;
pub extern fn IsWindowHidden() bool;
pub extern fn ToggleFullscreen() void;
pub extern fn UnhideWindow() void;
pub extern fn HideWindow() void;
pub extern fn SetWindowIcon(image: Image) void;
pub extern fn SetWindowTitle(title: [*c]const u8) void;
pub extern fn SetWindowPosition(x: i32, y: i32) void;
pub extern fn SetWindowMonitor(monitor: i32) void;
pub extern fn SetWindowMinSize(width: i32, height: i32) void;
pub extern fn SetWindowSize(width: i32, height: i32) void;
pub extern fn GetWindowHandle() ?*c_void;
pub extern fn GetScreenWidth() i32;
pub extern fn GetScreenHeight() i32;
pub extern fn GetMonitorCount() i32;
pub extern fn GetMonitorWidth(monitor: i32) i32;
pub extern fn GetMonitorHeight(monitor: i32) i32;
pub extern fn GetMonitorPhysicalWidth(monitor: i32) i32;
pub extern fn GetMonitorPhysicalHeight(monitor: i32) i32;
pub extern fn GetMonitorName(monitor: i32) [*c]const u8;
pub extern fn GetClipboardText() [*c]const u8;
pub extern fn SetClipboardText(text: [*c]const u8) void;
pub extern fn ShowCursor() void;
pub extern fn HideCursor() void;
pub extern fn IsCursorHidden() bool;
pub extern fn EnableCursor() void;
pub extern fn DisableCursor() void;
pub extern fn ClearBackground(color: Color) void;
pub extern fn BeginDrawing() void;
pub extern fn EndDrawing() void;
pub extern fn BeginMode2D(camera: Camera2D) void;
pub extern fn EndMode2D() void;
pub extern fn BeginMode3D(camera: Camera3D) void;
pub extern fn EndMode3D() void;
pub extern fn BeginTextureMode(target: RenderTexture2D) void;
pub extern fn EndTextureMode() void;
pub extern fn GetMouseRay(mousePosition: Vector2, camera: Camera) Ray;
pub extern fn GetWorldToScreen(position: Vector3, camera: Camera) Vector2;
pub extern fn GetCameraMatrix(camera: Camera) Matrix;
pub extern fn SetTargetFPS(fps: i32) void;
pub extern fn GetFPS() i32;
pub extern fn GetFrameTime() f32;
pub extern fn GetTime() f64;
pub extern fn ColorToInt(color: Color) i32;
pub extern fn ColorNormalize(color: Color) Vector4;
pub extern fn ColorToHSV(color: Color) Vector3;
pub extern fn ColorFromHSV(hsv: Vector3) Color;
pub extern fn GetColor(hexValue: i32) Color;
pub extern fn Fade(color: Color, alpha: f32) Color;
pub extern fn SetConfigFlags(flags: u8) void;
pub extern fn SetTraceLogLevel(logType: i32) void;
pub extern fn SetTraceLogExit(logType: i32) void;
pub extern fn SetTraceLogCallback(callback: TraceLogCallback) void;
pub extern fn TraceLog(logType: i32, text: [*c]const u8, ...) void;
pub extern fn TakeScreenshot(fileName: [*c]const u8) void;
pub extern fn GetRandomValue(min: i32, max: i32) i32;
pub extern fn FileExists(fileName: [*c]const u8) bool;
pub extern fn IsFileExtension(fileName: [*c]const u8, ext: [*c]const u8) bool;
pub extern fn GetExtension(fileName: [*c]const u8) [*c]const u8;
pub extern fn GetFileName(filePath: [*c]const u8) [*c]const u8;
pub extern fn GetFileNameWithoutExt(filePath: [*c]const u8) [*c]const u8;
pub extern fn GetDirectoryPath(fileName: [*c]const u8) [*c]const u8;
pub extern fn GetWorkingDirectory() [*c]const u8;
pub extern fn GetDirectoryFiles(dirPath: [*c]const u8, count: [*c]i32) [*c]([*c]u8);
pub extern fn ClearDirectoryFiles() void;
pub extern fn ChangeDirectory(dir: [*c]const u8) bool;
pub extern fn IsFileDropped() bool;
pub extern fn GetDroppedFiles(count: [*c]i32) [*c]([*c]u8);
pub extern fn ClearDroppedFiles() void;
pub extern fn GetFileModTime(fileName: [*c]const u8) c_long;
pub extern fn StorageSaveValue(position: i32, value: i32) void;
pub extern fn StorageLoadValue(position: i32) i32;
pub extern fn OpenURL(url: [*c]const u8) void;
pub extern fn IsKeyPressed(key: i32) bool;
pub extern fn IsKeyDown(key: i32) bool;
pub extern fn IsKeyReleased(key: i32) bool;
pub extern fn IsKeyUp(key: i32) bool;
pub extern fn GetKeyPressed() i32;
pub extern fn SetExitKey(key: i32) void;
pub extern fn IsGamepadAvailable(gamepad: i32) bool;
pub extern fn IsGamepadName(gamepad: i32, name: [*c]const u8) bool;
pub extern fn GetGamepadName(gamepad: i32) [*c]const u8;
pub extern fn IsGamepadButtonPressed(gamepad: i32, button: i32) bool;
pub extern fn IsGamepadButtonDown(gamepad: i32, button: i32) bool;
pub extern fn IsGamepadButtonReleased(gamepad: i32, button: i32) bool;
pub extern fn IsGamepadButtonUp(gamepad: i32, button: i32) bool;
pub extern fn GetGamepadButtonPressed() i32;
pub extern fn GetGamepadAxisCount(gamepad: i32) i32;
pub extern fn GetGamepadAxisMovement(gamepad: i32, axis: i32) f32;
pub extern fn IsMouseButtonPressed(button: i32) bool;
pub extern fn IsMouseButtonDown(button: i32) bool;
pub extern fn IsMouseButtonReleased(button: i32) bool;
pub extern fn IsMouseButtonUp(button: i32) bool;
pub extern fn GetMouseX() i32;
pub extern fn GetMouseY() i32;
pub extern fn GetMousePosition() Vector2;
pub extern fn SetMousePosition(x: i32, y: i32) void;
pub extern fn SetMouseOffset(offsetX: i32, offsetY: i32) void;
pub extern fn SetMouseScale(scaleX: f32, scaleY: f32) void;
pub extern fn GetMouseWheelMove() i32;
pub extern fn GetTouchX() i32;
pub extern fn GetTouchY() i32;
pub extern fn GetTouchPosition(index: i32) Vector2;
pub extern fn SetGesturesEnabled(gestureFlags: ui32) void;
pub extern fn IsGestureDetected(gesture: i32) bool;
pub extern fn GetGestureDetected() i32;
pub extern fn GetTouchPointsCount() i32;
pub extern fn GetGestureHoldDuration() f32;
pub extern fn GetGestureDragVector() Vector2;
pub extern fn GetGestureDragAngle() f32;
pub extern fn GetGesturePinchVector() Vector2;
pub extern fn GetGesturePinchAngle() f32;
pub extern fn SetCameraMode(camera: Camera, mode: i32) void;
pub extern fn UpdateCamera(camera: [*c]Camera) void;
pub extern fn SetCameraPanControl(panKey: i32) void;
pub extern fn SetCameraAltControl(altKey: i32) void;
pub extern fn SetCameraSmoothZoomControl(szKey: i32) void;
pub extern fn SetCameraMoveControls(frontKey: i32, backKey: i32, rightKey: i32, leftKey: i32, upKey: i32, downKey: i32) void;
pub extern fn DrawPixel(posX: i32, posY: i32, color: Color) void;
pub extern fn DrawPixelV(position: Vector2, color: Color) void;
pub extern fn DrawLine(startPosX: i32, startPosY: i32, endPosX: i32, endPosY: i32, color: Color) void;
pub extern fn DrawLineV(startPos: Vector2, endPos: Vector2, color: Color) void;
pub extern fn DrawLineEx(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void;
pub extern fn DrawLineBezier(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void;
pub extern fn DrawLineStrip(points: [*c]Vector2, numPoints: i32, color: Color) void;
pub extern fn DrawCircle(centerX: i32, centerY: i32, radius: f32, color: Color) void;
pub extern fn DrawCircleSector(center: Vector2, radius: f32, startAngle: i32, endAngle: i32, segments: i32, color: Color) void;
pub extern fn DrawCircleSectorLines(center: Vector2, radius: f32, startAngle: i32, endAngle: i32, segments: i32, color: Color) void;
pub extern fn DrawCircleGradient(centerX: i32, centerY: i32, radius: f32, color1: Color, color2: Color) void;
pub extern fn DrawCircleV(center: Vector2, radius: f32, color: Color) void;
pub extern fn DrawCircleLines(centerX: i32, centerY: i32, radius: f32, color: Color) void;
pub extern fn DrawRing(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: i32, endAngle: i32, segments: i32, color: Color) void;
pub extern fn DrawRingLines(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: i32, endAngle: i32, segments: i32, color: Color) void;
pub extern fn DrawRectangle(posX: i32, posY: i32, width: i32, height: i32, color: Color) void;
pub extern fn DrawRectangleV(position: Vector2, size: Vector2, color: Color) void;
pub extern fn DrawRectangleRec(rec: Rectangle, color: Color) void;
pub extern fn DrawRectanglePro(rec: Rectangle, origin: Vector2, rotation: f32, color: Color) void;
pub extern fn DrawRectangleGradientV(posX: i32, posY: i32, width: i32, height: i32, color1: Color, color2: Color) void;
pub extern fn DrawRectangleGradientH(posX: i32, posY: i32, width: i32, height: i32, color1: Color, color2: Color) void;
pub extern fn DrawRectangleGradientEx(rec: Rectangle, col1: Color, col2: Color, col3: Color, col4: Color) void;
pub extern fn DrawRectangleLines(posX: i32, posY: i32, width: i32, height: i32, color: Color) void;
pub extern fn DrawRectangleLinesEx(rec: Rectangle, lineThick: i32, color: Color) void;
pub extern fn DrawRectangleRounded(rec: Rectangle, roundness: f32, segments: i32, color: Color) void;
pub extern fn DrawRectangleRoundedLines(rec: Rectangle, roundness: f32, segments: i32, lineThick: i32, color: Color) void;
pub extern fn DrawTriangle(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void;
pub extern fn DrawTriangleLines(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void;
pub extern fn DrawTriangleFan(points: [*c]Vector2, numPoints: i32, color: Color) void;
pub extern fn DrawPoly(center: Vector2, sides: i32, radius: f32, rotation: f32, color: Color) void;
pub extern fn SetShapesTexture(texture: Texture2D, source: Rectangle) void;
pub extern fn CheckCollisionRecs(rec1: Rectangle, rec2: Rectangle) bool;
pub extern fn CheckCollisionCircles(center1: Vector2, radius1: f32, center2: Vector2, radius2: f32) bool;
pub extern fn CheckCollisionCircleRec(center: Vector2, radius: f32, rec: Rectangle) bool;
pub extern fn GetCollisionRec(rec1: Rectangle, rec2: Rectangle) Rectangle;
pub extern fn CheckCollisionPointRec(point: Vector2, rec: Rectangle) bool;
pub extern fn CheckCollisionPointCircle(point: Vector2, center: Vector2, radius: f32) bool;
pub extern fn CheckCollisionPointTriangle(point: Vector2, p1: Vector2, p2: Vector2, p3: Vector2) bool;
pub extern fn LoadImage(fileName: [*c]const u8) Image;
pub extern fn LoadImageEx(pixels: [*c]Color, width: i32, height: i32) Image;
pub extern fn LoadImagePro(data: ?*c_void, width: i32, height: i32, format: i32) Image;
pub extern fn LoadImageRaw(fileName: [*c]const u8, width: i32, height: i32, format: i32, headerSize: i32) Image;
pub extern fn ExportImage(image: Image, fileName: [*c]const u8) void;
pub extern fn ExportImageAsCode(image: Image, fileName: [*c]const u8) void;
pub extern fn LoadTexture(fileName: [*c]const u8) Texture2D;
pub extern fn LoadTextureFromImage(image: Image) Texture2D;
pub extern fn LoadTextureCubemap(image: Image, layoutType: i32) TextureCubemap;
pub extern fn LoadRenderTexture(width: i32, height: i32) RenderTexture2D;
pub extern fn UnloadImage(image: Image) void;
pub extern fn UnloadTexture(texture: Texture2D) void;
pub extern fn UnloadRenderTexture(target: RenderTexture2D) void;
pub extern fn GetImageData(image: Image) [*c]Color;
pub extern fn GetImageDataNormalized(image: Image) [*c]Vector4;
pub extern fn GetPixelDataSize(width: i32, height: i32, format: i32) i32;
pub extern fn GetTextureData(texture: Texture2D) Image;
pub extern fn GetScreenData() Image;
pub extern fn UpdateTexture(texture: Texture2D, pixels: ?*c_void) void;
pub extern fn ImageCopy(image: Image) Image;
pub extern fn ImageToPOT(image: [*c]Image, fillColor: Color) void;
pub extern fn ImageFormat(image: [*c]Image, newFormat: i32) void;
pub extern fn ImageAlphaMask(image: [*c]Image, alphaMask: Image) void;
pub extern fn ImageAlphaClear(image: [*c]Image, color: Color, threshold: f32) void;
pub extern fn ImageAlphaCrop(image: [*c]Image, threshold: f32) void;
pub extern fn ImageAlphaPremultiply(image: [*c]Image) void;
pub extern fn ImageCrop(image: [*c]Image, crop: Rectangle) void;
pub extern fn ImageResize(image: [*c]Image, newWidth: i32, newHeight: i32) void;
pub extern fn ImageResizeNN(image: [*c]Image, newWidth: i32, newHeight: i32) void;
pub extern fn ImageResizeCanvas(image: [*c]Image, newWidth: i32, newHeight: i32, offsetX: i32, offsetY: i32, color: Color) void;
pub extern fn ImageMipmaps(image: [*c]Image) void;
pub extern fn ImageDither(image: [*c]Image, rBpp: i32, gBpp: i32, bBpp: i32, aBpp: i32) void;
pub extern fn ImageExtractPalette(image: Image, maxPaletteSize: i32, extractCount: [*c]i32) [*c]Color;
pub extern fn ImageText(text: [*c]const u8, fontSize: i32, color: Color) Image;
pub extern fn ImageTextEx(font: Font, text: [*c]const u8, fontSize: f32, spacing: f32, tint: Color) Image;
pub extern fn ImageDraw(dst: [*c]Image, src: Image, srcRec: Rectangle, dstRec: Rectangle) void;
pub extern fn ImageDrawRectangle(dst: [*c]Image, rec: Rectangle, color: Color) void;
pub extern fn ImageDrawRectangleLines(dst: [*c]Image, rec: Rectangle, thick: i32, color: Color) void;
pub extern fn ImageDrawText(dst: [*c]Image, position: Vector2, text: [*c]const u8, fontSize: i32, color: Color) void;
pub extern fn ImageDrawTextEx(dst: [*c]Image, position: Vector2, font: Font, text: [*c]const u8, fontSize: f32, spacing: f32, color: Color) void;
pub extern fn ImageFlipVertical(image: [*c]Image) void;
pub extern fn ImageFlipHorizontal(image: [*c]Image) void;
pub extern fn ImageRotateCW(image: [*c]Image) void;
pub extern fn ImageRotateCCW(image: [*c]Image) void;
pub extern fn ImageColorTint(image: [*c]Image, color: Color) void;
pub extern fn ImageColorInvert(image: [*c]Image) void;
pub extern fn ImageColorGrayscale(image: [*c]Image) void;
pub extern fn ImageColorContrast(image: [*c]Image, contrast: f32) void;
pub extern fn ImageColorBrightness(image: [*c]Image, brightness: i32) void;
pub extern fn ImageColorReplace(image: [*c]Image, color: Color, replace: Color) void;
pub extern fn GenImageColor(width: i32, height: i32, color: Color) Image;
pub extern fn GenImageGradientV(width: i32, height: i32, top: Color, bottom: Color) Image;
pub extern fn GenImageGradientH(width: i32, height: i32, left: Color, right: Color) Image;
pub extern fn GenImageGradientRadial(width: i32, height: i32, density: f32, inner: Color, outer: Color) Image;
pub extern fn GenImageChecked(width: i32, height: i32, checksX: i32, checksY: i32, col1: Color, col2: Color) Image;
pub extern fn GenImageWhiteNoise(width: i32, height: i32, factor: f32) Image;
pub extern fn GenImagePerlinNoise(width: i32, height: i32, offsetX: i32, offsetY: i32, scale: f32) Image;
pub extern fn GenImageCellular(width: i32, height: i32, tileSize: i32) Image;
pub extern fn GenTextureMipmaps(texture: [*c]Texture2D) void;
pub extern fn SetTextureFilter(texture: Texture2D, filterMode: i32) void;
pub extern fn SetTextureWrap(texture: Texture2D, wrapMode: i32) void;
pub extern fn DrawTexture(texture: Texture2D, posX: i32, posY: i32, tint: Color) void;
pub extern fn DrawTextureV(texture: Texture2D, position: Vector2, tint: Color) void;
pub extern fn DrawTextureEx(texture: Texture2D, position: Vector2, rotation: f32, scale: f32, tint: Color) void;
pub extern fn DrawTextureRec(texture: Texture2D, sourceRec: Rectangle, position: Vector2, tint: Color) void;
pub extern fn DrawTextureQuad(texture: Texture2D, tiling: Vector2, offset: Vector2, quad: Rectangle, tint: Color) void;
pub extern fn DrawTexturePro(texture: Texture2D, sourceRec: Rectangle, destRec: Rectangle, origin: Vector2, rotation: f32, tint: Color) void;
pub extern fn DrawTextureNPatch(texture: Texture2D, nPatchInfo: NPatchInfo, destRec: Rectangle, origin: Vector2, rotation: f32, tint: Color) void;
pub extern fn GetFontDefault() Font;
pub extern fn LoadFont(fileName: [*c]const u8) Font;
pub extern fn LoadFontEx(fileName: [*c]const u8, fontSize: i32, fontChars: [*c]i32, charsCount: i32) Font;
pub extern fn LoadFontFromImage(image: Image, key: Color, firstChar: i32) Font;
pub extern fn LoadFontData(fileName: [*c]const u8, fontSize: i32, fontChars: [*c]i32, charsCount: i32, type_0: i32) [*c]CharInfo;
pub extern fn GenImageFontAtlas(chars: [*c]CharInfo, charsCount: i32, fontSize: i32, padding: i32, packMethod: i32) Image;
pub extern fn UnloadFont(font: Font) void;
pub extern fn DrawFPS(posX: i32, posY: i32) void;
pub extern fn DrawText(text: [*c]const u8, posX: i32, posY: i32, fontSize: i32, color: Color) void;
pub extern fn DrawTextEx(font: Font, text: [*c]const u8, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void;
pub extern fn DrawTextRec(font: Font, text: [*c]const u8, rec: Rectangle, fontSize: f32, spacing: f32, wordWrap: bool, tint: Color) void;
pub extern fn DrawTextRecEx(font: Font, text: [*c]const u8, rec: Rectangle, fontSize: f32, spacing: f32, wordWrap: bool, tint: Color, selectStart: i32, selectLength: i32, selectText: Color, selectBack: Color) void;
pub extern fn MeasureText(text: [*c]const u8, fontSize: i32) i32;
pub extern fn MeasureTextEx(font: Font, text: [*c]const u8, fontSize: f32, spacing: f32) Vector2;
pub extern fn GetGlyphIndex(font: Font, character: i32) i32;
pub extern fn GetNextCodepoint(text: [*c]const u8, count: [*c]i32) i32;
pub extern fn TextIsEqual(text1: [*c]const u8, text2: [*c]const u8) bool;
pub extern fn TextLength(text: [*c]const u8) ui32;
pub extern fn TextCountCodepoints(text: [*c]const u8) ui32;
pub extern fn TextFormat(text: [*c]const u8, ...) [*c]const u8;
pub extern fn TextSubtext(text: [*c]const u8, position: i32, length: i32) [*c]const u8;
pub extern fn TextReplace(text: [*c]u8, replace: [*c]const u8, by: [*c]const u8) [*c]const u8;
pub extern fn TextInsert(text: [*c]const u8, insert: [*c]const u8, position: i32) [*c]const u8;
pub extern fn TextJoin(textList: [*c]([*c]const u8), count: i32, delimiter: [*c]const u8) [*c]const u8;
pub extern fn TextSplit(text: [*c]const u8, delimiter: u8, count: [*c]i32) [*c]([*c]const u8);
pub extern fn TextAppend(text: [*c]u8, append: [*c]const u8, position: [*c]i32) void;
pub extern fn TextFindIndex(text: [*c]const u8, find: [*c]const u8) i32;
pub extern fn TextToUpper(text: [*c]const u8) [*c]const u8;
pub extern fn TextToLower(text: [*c]const u8) [*c]const u8;
pub extern fn TextToPascal(text: [*c]const u8) [*c]const u8;
pub extern fn TextToInteger(text: [*c]const u8) i32;
pub extern fn DrawLine3D(startPos: Vector3, endPos: Vector3, color: Color) void;
pub extern fn DrawCircle3D(center: Vector3, radius: f32, rotationAxis: Vector3, rotationAngle: f32, color: Color) void;
pub extern fn DrawCube(position: Vector3, width: f32, height: f32, length: f32, color: Color) void;
pub extern fn DrawCubeV(position: Vector3, size: Vector3, color: Color) void;
pub extern fn DrawCubeWires(position: Vector3, width: f32, height: f32, length: f32, color: Color) void;
pub extern fn DrawCubeWiresV(position: Vector3, size: Vector3, color: Color) void;
pub extern fn DrawCubeTexture(texture: Texture2D, position: Vector3, width: f32, height: f32, length: f32, color: Color) void;
pub extern fn DrawSphere(centerPos: Vector3, radius: f32, color: Color) void;
pub extern fn DrawSphereEx(centerPos: Vector3, radius: f32, rings: i32, slices: i32, color: Color) void;
pub extern fn DrawSphereWires(centerPos: Vector3, radius: f32, rings: i32, slices: i32, color: Color) void;
pub extern fn DrawCylinder(position: Vector3, radiusTop: f32, radiusBottom: f32, height: f32, slices: i32, color: Color) void;
pub extern fn DrawCylinderWires(position: Vector3, radiusTop: f32, radiusBottom: f32, height: f32, slices: i32, color: Color) void;
pub extern fn DrawPlane(centerPos: Vector3, size: Vector2, color: Color) void;
pub extern fn DrawRay(ray: Ray, color: Color) void;
pub extern fn DrawGrid(slices: i32, spacing: f32) void;
pub extern fn DrawGizmo(position: Vector3) void;
pub extern fn LoadModel(fileName: [*c]const u8) Model;
pub extern fn LoadModelFromMesh(mesh: Mesh) Model;
pub extern fn UnloadModel(model: Model) void;
pub extern fn LoadMeshes(fileName: [*c]const u8, meshCount: [*c]i32) [*c]Mesh;
pub extern fn ExportMesh(mesh: Mesh, fileName: [*c]const u8) void;
pub extern fn UnloadMesh(mesh: [*c]Mesh) void;
pub extern fn LoadMaterials(fileName: [*c]const u8, materialCount: [*c]i32) [*c]Material;
pub extern fn LoadMaterialDefault() Material;
pub extern fn UnloadMaterial(material: Material) void;
pub extern fn SetMaterialTexture(material: [*c]Material, mapType: i32, texture: Texture2D) void;
pub extern fn SetModelMeshMaterial(model: [*c]Model, meshId: i32, materialId: i32) void;
pub extern fn LoadModelAnimations(fileName: [*c]const u8, animsCount: [*c]i32) [*c]ModelAnimation;
pub extern fn UpdateModelAnimation(model: Model, anim: ModelAnimation, frame: i32) void;
pub extern fn UnloadModelAnimation(anim: ModelAnimation) void;
pub extern fn IsModelAnimationValid(model: Model, anim: ModelAnimation) bool;
pub extern fn GenMeshPoly(sides: i32, radius: f32) Mesh;
pub extern fn GenMeshPlane(width: f32, length: f32, resX: i32, resZ: i32) Mesh;
pub extern fn GenMeshCube(width: f32, height: f32, length: f32) Mesh;
pub extern fn GenMeshSphere(radius: f32, rings: i32, slices: i32) Mesh;
pub extern fn GenMeshHemiSphere(radius: f32, rings: i32, slices: i32) Mesh;
pub extern fn GenMeshCylinder(radius: f32, height: f32, slices: i32) Mesh;
pub extern fn GenMeshTorus(radius: f32, size: f32, radSeg: i32, sides: i32) Mesh;
pub extern fn GenMeshKnot(radius: f32, size: f32, radSeg: i32, sides: i32) Mesh;
pub extern fn GenMeshHeightmap(heightmap: Image, size: Vector3) Mesh;
pub extern fn GenMeshCubicmap(cubicmap: Image, cubeSize: Vector3) Mesh;
pub extern fn MeshBoundingBox(mesh: Mesh) BoundingBox;
pub extern fn MeshTangents(mesh: [*c]Mesh) void;
pub extern fn MeshBinormals(mesh: [*c]Mesh) void;
pub extern fn DrawModel(model: Model, position: Vector3, scale: f32, tint: Color) void;
pub extern fn DrawModelEx(model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: f32, scale: Vector3, tint: Color) void;
pub extern fn DrawModelWires(model: Model, position: Vector3, scale: f32, tint: Color) void;
pub extern fn DrawModelWiresEx(model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: f32, scale: Vector3, tint: Color) void;
pub extern fn DrawBoundingBox(box: BoundingBox, color: Color) void;
pub extern fn DrawBillboard(camera: Camera, texture: Texture2D, center: Vector3, size: f32, tint: Color) void;
pub extern fn DrawBillboardRec(camera: Camera, texture: Texture2D, sourceRec: Rectangle, center: Vector3, size: f32, tint: Color) void;
pub extern fn CheckCollisionSpheres(centerA: Vector3, radiusA: f32, centerB: Vector3, radiusB: f32) bool;
pub extern fn CheckCollisionBoxes(box1: BoundingBox, box2: BoundingBox) bool;
pub extern fn CheckCollisionBoxSphere(box: BoundingBox, centerSphere: Vector3, radiusSphere: f32) bool;
pub extern fn CheckCollisionRaySphere(ray: Ray, spherePosition: Vector3, sphereRadius: f32) bool;
pub extern fn CheckCollisionRaySphereEx(ray: Ray, spherePosition: Vector3, sphereRadius: f32, collisionPoint: [*c]Vector3) bool;
pub extern fn CheckCollisionRayBox(ray: Ray, box: BoundingBox) bool;
pub extern fn GetCollisionRayModel(ray: Ray, model: [*c]Model) RayHitInfo;
pub extern fn GetCollisionRayTriangle(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3) RayHitInfo;
pub extern fn GetCollisionRayGround(ray: Ray, groundHeight: f32) RayHitInfo;
pub extern fn LoadText(fileName: [*c]const u8) [*c]u8;
pub extern fn LoadShader(vsFileName: [*c]const u8, fsFileName: [*c]const u8) Shader;
pub extern fn LoadShaderCode(vsCode: [*c]u8, fsCode: [*c]u8) Shader;
pub extern fn UnloadShader(shader: Shader) void;
pub extern fn GetShaderDefault() Shader;
pub extern fn GetTextureDefault() Texture2D;
pub extern fn GetShaderLocation(shader: Shader, uniformName: [*c]const u8) i32;
pub extern fn SetShaderValue(shader: Shader, uniformLoc: i32, value: ?*c_void, uniformType: i32) void;
pub extern fn SetShaderValueV(shader: Shader, uniformLoc: i32, value: ?*c_void, uniformType: i32, count: i32) void;
pub extern fn SetShaderValueMatrix(shader: Shader, uniformLoc: i32, mat: Matrix) void;
pub extern fn SetShaderValueTexture(shader: Shader, uniformLoc: i32, texture: Texture2D) void;
pub extern fn SetMatrixProjection(proj: Matrix) void;
pub extern fn SetMatrixModelview(view: Matrix) void;
pub extern fn GetMatrixModelview() Matrix;
pub extern fn GenTextureCubemap(shader: Shader, skyHDR: Texture2D, size: i32) Texture2D;
pub extern fn GenTextureIrradiance(shader: Shader, cubemap: Texture2D, size: i32) Texture2D;
pub extern fn GenTexturePrefilter(shader: Shader, cubemap: Texture2D, size: i32) Texture2D;
pub extern fn GenTextureBRDF(shader: Shader, size: i32) Texture2D;
pub extern fn BeginShaderMode(shader: Shader) void;
pub extern fn EndShaderMode() void;
pub extern fn BeginBlendMode(mode: i32) void;
pub extern fn EndBlendMode() void;
pub extern fn BeginScissorMode(x: i32, y: i32, width: i32, height: i32) void;
pub extern fn EndScissorMode() void;
pub extern fn InitVrSimulator() void;
pub extern fn CloseVrSimulator() void;
pub extern fn UpdateVrTracking(camera: [*c]Camera) void;
pub extern fn SetVrConfiguration(info: VrDeviceInfo, distortion: Shader) void;
pub extern fn IsVrSimulatorReady() bool;
pub extern fn ToggleVrMode() void;
pub extern fn BeginVrDrawing() void;
pub extern fn EndVrDrawing() void;
pub extern fn InitAudioDevice() void;
pub extern fn CloseAudioDevice() void;
pub extern fn IsAudioDeviceReady() bool;
pub extern fn SetMasterVolume(volume: f32) void;
pub extern fn LoadWave(fileName: [*c]const u8) Wave;
pub extern fn LoadWaveEx(data: ?*c_void, sampleCount: i32, sampleRate: i32, sampleSize: i32, channels: i32) Wave;
pub extern fn LoadSound(fileName: [*c]const u8) Sound;
pub extern fn LoadSoundFromWave(wave: Wave) Sound;
pub extern fn UpdateSound(sound: Sound, data: ?*c_void, samplesCount: i32) void;
pub extern fn UnloadWave(wave: Wave) void;
pub extern fn UnloadSound(sound: Sound) void;
pub extern fn ExportWave(wave: Wave, fileName: [*c]const u8) void;
pub extern fn ExportWaveAsCode(wave: Wave, fileName: [*c]const u8) void;
pub extern fn PlaySound(sound: Sound) void;
pub extern fn PauseSound(sound: Sound) void;
pub extern fn ResumeSound(sound: Sound) void;
pub extern fn StopSound(sound: Sound) void;
pub extern fn IsSoundPlaying(sound: Sound) bool;
pub extern fn SetSoundVolume(sound: Sound, volume: f32) void;
pub extern fn SetSoundPitch(sound: Sound, pitch: f32) void;
pub extern fn WaveFormat(wave: [*c]Wave, sampleRate: i32, sampleSize: i32, channels: i32) void;
pub extern fn WaveCopy(wave: Wave) Wave;
pub extern fn WaveCrop(wave: [*c]Wave, initSample: i32, finalSample: i32) void;
pub extern fn GetWaveData(wave: Wave) [*c]f32;
pub extern fn LoadMusicStream(fileName: [*c]const u8) Music;
pub extern fn UnloadMusicStream(music: Music) void;
pub extern fn PlayMusicStream(music: Music) void;
pub extern fn UpdateMusicStream(music: Music) void;
pub extern fn StopMusicStream(music: Music) void;
pub extern fn PauseMusicStream(music: Music) void;
pub extern fn ResumeMusicStream(music: Music) void;
pub extern fn IsMusicPlaying(music: Music) bool;
pub extern fn SetMusicVolume(music: Music, volume: f32) void;
pub extern fn SetMusicPitch(music: Music, pitch: f32) void;
pub extern fn SetMusicLoopCount(music: Music, count: i32) void;
pub extern fn GetMusicTimeLength(music: Music) f32;
pub extern fn GetMusicTimePlayed(music: Music) f32;
pub extern fn InitAudioStream(sampleRate: ui32, sampleSize: ui32, channels: ui32) AudioStream;
pub extern fn UpdateAudioStream(stream: AudioStream, data: ?*c_void, samplesCount: i32) void;
pub extern fn CloseAudioStream(stream: AudioStream) void;
pub extern fn IsAudioBufferProcessed(stream: AudioStream) bool;
pub extern fn PlayAudioStream(stream: AudioStream) void;
pub extern fn PauseAudioStream(stream: AudioStream) void;
pub extern fn ResumeAudioStream(stream: AudioStream) void;
pub extern fn IsAudioStreamPlaying(stream: AudioStream) bool;
pub extern fn StopAudioStream(stream: AudioStream) void;
pub extern fn SetAudioStreamVolume(stream: AudioStream, volume: f32) void;
pub extern fn SetAudioStreamPitch(stream: AudioStream, pitch: f32) void;

pub const LOC_MAP_SPECULAR = LOC_MAP_METALNESS;
pub const MAP_DIFFUSE = MAP_ALBEDO;
pub const LOC_MAP_DIFFUSE = LOC_MAP_ALBEDO;
pub const MAX_TOUCH_POINTS = 10;
pub const ShowWindow = UnhideWindow;
pub const FormatText = TextFormat;
pub const MAP_SPECULAR = MAP_METALNESS;
pub const PI = 3.141593;
pub const CLITERAL = Color;
pub const MAX_SHADER_LOCATIONS = 32;
pub const SpriteFont = Font;
pub const SubText = TextSubtext;
pub const MAX_MATERIAL_MAPS = 12;

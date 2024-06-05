// raylib-zig (c) Nikolas Wipper 2023

const rl = @This();
const std = @import("std");

pub const gl = @import("rlgl.zig");
pub const math = @import("raymath.zig");

test {
    std.testing.refAllDeclsRecursive(@This());
}

pub const RaylibError = error{GenericError};

pub const Vector2 = extern struct {
    x: f32,
    y: f32,

    pub fn init(x: f32, y: f32) Vector2 {
        return Vector2{ .x = x, .y = y };
    }

    pub fn zero() Vector2 {
        return math.vector2Zero();
    }

    pub fn one() Vector2 {
        return math.vector2One();
    }

    pub fn add(self: Vector2, v: Vector2) Vector2 {
        return math.vector2Add(self, v);
    }

    pub fn addValue(self: Vector2, v: f32) Vector2 {
        return math.vector2AddValue(self, v);
    }

    pub fn subtract(self: Vector2, v: Vector2) Vector2 {
        return math.vector2Subtract(self, v);
    }

    pub fn subtractValue(self: Vector2, v: f32) Vector2 {
        return math.vector2SubtractValue(self, v);
    }

    pub fn length(self: Vector2) f32 {
        return math.vector2Length(self);
    }

    pub fn lengthSqr(self: Vector2) f32 {
        return math.vector2LengthSqr(self);
    }

    pub fn dotProduct(self: Vector2, v: Vector2) f32 {
        return math.vector2DotProduct(self, v);
    }

    pub fn distance(self: Vector2, v: Vector2) f32 {
        return math.vector2Distance(self, v);
    }

    pub fn distanceSqr(self: Vector2, v: Vector2) f32 {
        return math.vector2DistanceSqr(self, v);
    }

    pub fn angle(self: Vector2, v: Vector2) f32 {
        return math.vector2Angle(self, v);
    }

    pub fn lineAngle(self: Vector2, end: Vector2) f32 {
        return math.vector2LineAngle(self, end);
    }

    pub fn scale(self: Vector2, scale_: f32) Vector2 {
        return math.vector2Scale(self, scale_);
    }

    pub fn multiply(self: Vector2, v2: Vector2) Vector2 {
        return math.vector2Multiply(self, v2);
    }

    pub fn negate(self: Vector2) Vector2 {
        return math.vector2Negate(self);
    }

    pub fn divide(self: Vector2, v2: Vector2) Vector2 {
        return math.vector2Divide(self, v2);
    }

    pub fn normalize(self: Vector2) Vector2 {
        return math.vector2Normalize(self);
    }

    pub fn transform(self: Vector2, mat: Matrix) Vector2 {
        return math.vector2Transform(self, mat);
    }

    pub fn lerp(self: Vector2, v2: Vector2, amount: f32) Vector2 {
        return math.vector2Lerp(self, v2, amount);
    }

    pub fn reflect(self: Vector2, normal: Vector2) Vector2 {
        return math.vector2Reflect(self, normal);
    }

    pub fn min(self: Vector2, v2: Vector2) Vector2 {
        return math.vector2Min(self, v2);
    }

    pub fn max(self: Vector2, v2: Vector2) Vector2 {
        return math.vector2Max(self, v2);
    }

    pub fn rotate(self: Vector2, angle_: f32) Vector2 {
        return math.vector2Rotate(self, angle_);
    }

    pub fn moveTowards(self: Vector2, target: Vector2, maxDistance: f32) Vector2 {
        return math.vector2MoveTowards(self, target, maxDistance);
    }

    pub fn invert(self: Vector2) Vector2 {
        return math.vector2Invert(self);
    }

    pub fn clamp(self: Vector2, min_: Vector2, max_: Vector2) Vector2 {
        return math.vector2Clamp(self, min_, max_);
    }

    pub fn clampValue(self: Vector2, min_: f32, max_: f32) Vector2 {
        return math.vector2ClampValue(self, min_, max_);
    }

    pub fn equals(self: Vector2, q: Vector2) i32 {
        return math.vector2Equals(self, q);
    }

    pub fn refract(self: Vector2, n: Vector2, r: f32) Vector2 {
        return math.vector2Refract(self, n, r);
    }
};

pub const Vector3 = extern struct {
    x: f32,
    y: f32,
    z: f32,

    pub fn init(x: f32, y: f32, z: f32) Vector3 {
        return Vector3{ .x = x, .y = y, .z = z };
    }

    pub fn zero() Vector3 {
        return math.vector3Zero();
    }

    pub fn one() Vector3 {
        return math.vector3One();
    }

    pub fn add(self: Vector3, v: Vector3) Vector3 {
        return math.vector3Add(self, v);
    }

    pub fn addValue(self: Vector3, add_: f32) Vector3 {
        return math.vector3AddValue(self, add_);
    }

    pub fn subtract(self: Vector3, v: Vector3) Vector3 {
        return math.vector3Subtract(self, v);
    }

    pub fn subtractValue(self: Vector3, sub: f32) Vector3 {
        return math.vector3SubtractValue(self, sub);
    }

    pub fn scale(self: Vector3, scalar: f32) Vector3 {
        return math.vector3Scale(self, scalar);
    }

    pub fn multiply(self: Vector3, v: Vector3) Vector3 {
        return math.vector3Multiply(self, v);
    }

    pub fn crossProduct(self: Vector3, v: Vector3) Vector3 {
        return math.vector3CrossProduct(self, v);
    }

    pub fn perpendicular(self: Vector3) Vector3 {
        return math.vector3Perpendicular(self);
    }

    pub fn length(self: Vector3) f32 {
        return math.vector3Length(self);
    }

    pub fn lengthSqr(self: Vector3) f32 {
        return math.vector3LengthSqr(self);
    }

    pub fn dotProduct(self: Vector3, v: Vector3) f32 {
        return math.vector3DotProduct(self, v);
    }

    pub fn distance(self: Vector3, v: Vector3) f32 {
        return math.vector3Distance(self, v);
    }

    pub fn distanceSqr(self: Vector3, v: Vector3) f32 {
        return math.vector3DistanceSqr(self, v);
    }

    pub fn angle(self: Vector3, v: Vector3) f32 {
        return math.vector3Angle(self, v);
    }

    pub fn negate(self: Vector3) Vector3 {
        return math.vector3Negate(self);
    }

    pub fn divide(self: Vector3, v: Vector3) Vector3 {
        return math.vector3Divide(self, v);
    }

    pub fn normalize(self: Vector3) Vector3 {
        return math.vector3Normalize(self);
    }

    pub fn project(self: Vector3, v: Vector3) Vector3 {
        return math.vector3Project(self, v);
    }

    pub fn reject(self: Vector3, v: Vector3) Vector3 {
        return math.vector3Reject(self, v);
    }

    pub fn orthoNormalize(self: *Vector3, v: *Vector3) void {
        math.vector3OrthoNormalize(self, v);
    }

    pub fn transform(self: Vector3, mat: Matrix) Vector3 {
        return math.vector3Transform(self, mat);
    }

    pub fn rotateByQuaternion(self: Vector3, q: Quaternion) Vector3 {
        return math.vector3RotateByQuaternion(self, q);
    }

    pub fn rotateByAxisAngle(self: Vector3, axis: Vector3, angle_: f32) Vector3 {
        return math.vector3RotateByAxisAngle(self, axis, angle_);
    }

    pub fn moveTowards(self: Vector3, target: Vector3, maxDistance: f32) Vector3 {
        return math.vector3MoveTowards(self, target, maxDistance);
    }

    pub fn lerp(self: Vector3, v2: Vector3, amount: f32) Vector3 {
        return math.vector3Lerp(self, v2, amount);
    }

    pub fn cubicHermite(self: Vector3, tangent1: Vector3, v: Vector3, tangent2: Vector3, amount: f32) Vector3 {
        return math.vector3CubicHermite(self, tangent1, v, tangent2, amount);
    }

    pub fn reflect(self: Vector3, normal: Vector3) Vector3 {
        return math.vector3Reflect(self, normal);
    }

    pub fn min(self: Vector3, v: Vector3) Vector3 {
        return math.vector3Min(self, v);
    }

    pub fn max(self: Vector3, v: Vector3) Vector3 {
        return math.vector3Max(self, v);
    }

    pub fn barycenter(p: Vector3, a: Vector3, b: Vector3, c: Vector3) Vector3 {
        return math.vector3Barycenter(p, a, b, c);
    }

    pub fn unproject(source: Vector3, projection: Matrix, view: Matrix) Vector3 {
        return math.vector3Unproject(source, projection, view);
    }

    pub fn toFloatV(self: Vector3) math.float3 {
        return math.vector3ToFloatV(self);
    }

    pub fn invert(self: Vector3) Vector3 {
        return math.vector3Invert(self);
    }

    pub fn clamp(self: Vector3, min_: Vector3, max_: Vector3) Vector3 {
        return math.vector3Clamp(self, min_, max_);
    }

    pub fn clampValue(self: Vector3, min_: f32, max_: f32) Vector3 {
        return math.vector3ClampValue(self, min_, max_);
    }

    pub fn equals(p: Vector3, q: Vector3) i32 {
        return math.vector3Equals(p, q);
    }

    pub fn refract(self: Vector3, n: Vector3, r: f32) Vector3 {
        return math.vector3Refract(self, n, r);
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

    pub fn zero() Vector4 {
        return math.vector4Zero();
    }

    pub fn one() Vector4 {
        return math.vector4One();
    }

    pub fn add(self: Vector4, v: Vector4) Vector4 {
        return math.vector4Add(self, v);
    }

    pub fn addValue(self: Vector4, add_: f32) Vector4 {
        return math.vector4AddValue(self, add_);
    }

    pub fn subtract(self: Vector4, v: Vector4) Vector4 {
        return math.vector4Subtract(self, v);
    }

    pub fn subtractValue(self: Vector4, add_: f32) Vector4 {
        return math.vector4SubtractValue(self, add_);
    }

    pub fn length(self: Vector4) f32 {
        return math.vector4Length(self);
    }

    pub fn lengthSqr(self: Vector4) f32 {
        return math.vector4LengthSqr(self);
    }

    pub fn dotProduct(self: Vector4, v: Vector4) f32 {
        return math.vector4DotProduct(self, v);
    }

    pub fn distance(self: Vector4, v: Vector4) f32 {
        return math.vector4Distance(self, v);
    }

    pub fn distanceSqr(self: Vector4, v: Vector4) f32 {
        return math.vector4DistanceSqr(self, v);
    }

    pub fn scale(self: Vector4, scale_: f32) Vector4 {
        return math.vector4Scale(self, scale_);
    }

    pub fn multiply(self: Vector4, v: Vector4) Vector4 {
        return math.vector4Multiply(self, v);
    }

    pub fn negate(self: Vector4) Vector4 {
        return math.vector4Negate(self);
    }

    pub fn divide(self: Vector4, v: Vector4) Vector4 {
        return math.vector4Divide(self, v);
    }

    pub fn normalize(self: Vector4) Vector4 {
        return math.vector4Normalize(self);
    }

    pub fn min(self: Vector4, v: Vector4) Vector4 {
        return math.vector4Min(self, v);
    }

    pub fn max(self: Vector4, v: Vector4) Vector4 {
        return math.vector4Max(self, v);
    }

    pub fn lerp(self: Vector4, v: Vector4, amount: f32) Vector4 {
        return math.vector4Lerp(self, v, amount);
    }

    pub fn moveTowards(self: Vector4, target: Vector4, maxDistance: f32) Vector4 {
        return math.vector4MoveTowards(self, target, maxDistance);
    }

    pub fn invert(self: Vector4) Vector4 {
        return math.vector4Invert(self);
    }

    pub fn equals(p: Vector4, q: Vector4) i32 {
        return math.vector4Equals(p, q);
    }

    pub fn identity() Quaternion {
        return math.quaternionIdentity();
    }

    pub fn nlerp(self: Quaternion, q: Quaternion, amount: f32) Quaternion {
        return math.quaternionNlerp(self, q, amount);
    }

    pub fn slerp(self: Quaternion, q: Quaternion, amount: f32) Quaternion {
        return math.quaternionSlerp(self, q, amount);
    }

    pub fn cubicHermiteSpline(self: Quaternion, outTangent1: Quaternion, q: Quaternion, inTangent2: Quaternion, t: f32) Quaternion {
        return math.quaternionCubicHermiteSpline(self, outTangent1, q, inTangent2, t);
    }

    pub fn fromVector3ToVector3(from: Vector3, to: Vector3) Quaternion {
        return math.quaternionFromVector3ToVector3(from, to);
    }

    pub fn fromMatrix(mat: Matrix) Quaternion {
        return math.quaternionFromMatrix(mat);
    }

    pub fn toMatrix(self: Quaternion) Matrix {
        return math.quaternionToMatrix(self);
    }

    pub fn fromAxisAngle(axis: Vector3, angle: f32) Quaternion {
        return math.quaternionFromAxisAngle(axis, angle);
    }

    pub fn toAxisAngle(self: Quaternion, outAxis: *Vector3, outAngle: *f32) void {
        math.quaternionToAxisAngle(self, outAxis, outAngle);
    }

    pub fn fromEuler(pitch: f32, yaw: f32, roll: f32) Quaternion {
        return math.quaternionFromEuler(pitch, yaw, roll);
    }

    pub fn toEuler(self: Quaternion) Vector3 {
        return math.quaternionToEuler(self);
    }

    pub fn transform(self: Quaternion, mat: Matrix) Quaternion {
        return math.quaternionTransform(self, mat);
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

    pub fn determinant(self: Matrix) f32 {
        return math.matrixDeterminant(self);
    }

    pub fn trace(self: Matrix) f32 {
        return math.matrixTrace(self);
    }

    pub fn transpose(self: Matrix) Matrix {
        return math.matrixTranspose(self);
    }

    pub fn invert(self: Matrix) Matrix {
        return math.matrixInvert(self);
    }

    pub fn identity() Matrix {
        return math.matrixIdentity();
    }

    pub fn add(self: Matrix, right: Matrix) Matrix {
        return math.matrixAdd(self, right);
    }

    pub fn subtract(self: Matrix, right: Matrix) Matrix {
        return math.matrixSubtract(self, right);
    }

    pub fn multiply(self: Matrix, right: Matrix) Matrix {
        return math.matrixMultiply(self, right);
    }

    pub fn translate(x: f32, y: f32, z: f32) Matrix {
        return math.matrixTranslate(x, y, z);
    }

    pub fn rotate(axis: Vector3, angle: f32) Matrix {
        return math.matrixRotate(axis, angle);
    }

    pub fn rotateX(angle: f32) Matrix {
        return math.matrixRotateX(angle);
    }

    pub fn rotateY(angle: f32) Matrix {
        return math.matrixRotateY(angle);
    }

    pub fn rotateZ(angle: f32) Matrix {
        return math.matrixRotateZ(angle);
    }

    pub fn rotateXYZ(angle: Vector3) Matrix {
        return math.matrixRotateXYZ(angle);
    }

    pub fn rotateZYX(angle: Vector3) Matrix {
        return math.matrixRotateZYX(angle);
    }

    pub fn scale(x: f32, y: f32, z: f32) Matrix {
        return math.matrixScale(x, y, z);
    }

    pub fn frustum(left: f64, right: f64, bottom: f64, top: f64, near: f64, far: f64) Matrix {
        return math.matrixFrustum(left, right, bottom, top, near, far);
    }

    pub fn perspective(fovY: f64, aspect: f64, nearPlane: f64, farPlane: f64) Matrix {
        return math.matrixPerspective(fovY, aspect, nearPlane, farPlane);
    }

    pub fn ortho(left: f64, right: f64, bottom: f64, top: f64, nearPlane: f64, farPlane: f64) Matrix {
        return math.matrixOrtho(left, right, bottom, top, nearPlane, farPlane);
    }

    pub fn lookAt(eye: Vector3, target: Vector3, up: Vector3) Matrix {
        return math.matrixLookAt(eye, target, up);
    }

    pub fn toFloatV(self: Matrix) math.float16 {
        return math.matrixToFloatV(self);
    }
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
        return rl.loadImageRaw(fileName, width, height, format, headerSize);
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

    pub fn setFormat(self: *Image, newFormat: PixelFormat) void {
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
        rl.imageColorBrightness(self, b);
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

    pub fn asCubemap(self: Image, layout: CubemapLayout) Texture {
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

    pub fn fromCubemap(image: Image, layout: CubemapLayout) Texture {
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

pub const AutomationEvent = extern struct {
    frame: c_uint,
    type: c_uint,
    params: [4]c_int,
};

pub const AutomationEventList = extern struct {
    capacity: c_uint,
    count: c_uint,
    events: [*c]AutomationEvent
};

pub const ConfigFlags = packed struct {
    __reserved: bool = false,
    fullscreen_mode: bool = false,
    window_resizable: bool = false,
    window_undecorated: bool = false,
    window_transparent: bool = false,
    msaa_4x_hint: bool = false,
    vsync_hint: bool = false,
    window_hidden: bool = false,
    window_always_run: bool = false,
    window_minimized: bool = false,
    window_maximized: bool = false,
    window_unfocused: bool = false,
    window_topmost: bool = false,
    window_highdpi: bool = false,
    window_mouse_passthrough: bool = false,
    borderless_windowed_mode: bool = false,
    interlaced_hint: bool = false,
    __reserved2: bool = false,
    __reserved3: bool = false,
    __reserved4: bool = false,
    __reserved5: bool = false,
    __reserved6: bool = false,
    __reserved7: bool = false,
    __reserved8: bool = false,
    __reserved9: bool = false,
    __reserved10: bool = false,
    __reserved11: bool = false,
    __reserved12: bool = false,
    __reserved13: bool = false,
    __reserved14: bool = false,
    __reserved15: bool = false,
    __reserved16: bool = false,
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
    pixelformat_uncompressed_r16 = 11,
    pixelformat_uncompressed_r16g16b16 = 12,
    pixelformat_uncompressed_r16g16b16a16 = 13,
    pixelformat_compressed_dxt1_rgb = 14,
    pixelformat_compressed_dxt1_rgba = 15,
    pixelformat_compressed_dxt3_rgba = 16,
    pixelformat_compressed_dxt5_rgba = 17,
    pixelformat_compressed_etc1_rgb = 18,
    pixelformat_compressed_etc2_rgb = 19,
    pixelformat_compressed_etc2_eac_rgba = 20,
    pixelformat_compressed_pvrt_rgb = 21,
    pixelformat_compressed_pvrt_rgba = 22,
    pixelformat_compressed_astc_4x4_rgba = 23,
    pixelformat_compressed_astc_8x8_rgba = 24,
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

pub const RAYLIB_VERSION_MAJOR = @as(i32, 5);
pub const RAYLIB_VERSION_MINOR = @as(i32, 1);
pub const RAYLIB_VERSION_PATCH = @as(i32, 0);
pub const RAYLIB_VERSION = "5.1-dev";

pub const MAX_TOUCH_POINTS = 10;
pub const MAX_MATERIAL_MAPS = 12;
pub const MAX_SHADER_LOCATIONS = 32;

pub const MATERIAL_MAP_DIFFUSE = MaterialMapIndex.material_map_albedo;
pub const MATERIAL_MAP_SPECULAR = MaterialMapIndex.material_map_metalness;
pub const SHADER_LOC_MAP_DIFFUSE = ShaderLocationIndex.shader_loc_map_albedo;
pub const SHADER_LOC_MAP_SPECULAR = ShaderLocationIndex.shader_loc_map_metalness;

const cdef = @import("raylib-ext.zig");

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

pub fn loadFileData(fileName: [:0]const u8) RaylibError![]u8 {
    var bytesRead: i32 = 0;
    var res: []u8 = undefined;

    const ptr = cdef.LoadFileData(@as([*c]const u8, @ptrCast(fileName)), @as([*c]c_int, @ptrCast(&bytesRead)));
    if (ptr == 0) return RaylibError.GenericError;

    res.ptr = @as([*]u8, @ptrCast(ptr));
    res.len = @as(usize, @intCast(bytesRead));
    return res;
}

pub fn saveFileData(fileName: [:0]const u8, data: []u8) bool {
    return cdef.SaveFileData(@as([*c]const u8, @ptrCast(fileName)), @as(*anyopaque, @ptrCast(data.ptr)), @as(c_int, @intCast(data.len)));
}

pub fn exportDataAsCode(data: []const u8, fileName: [:0]const u8) bool {
    return cdef.ExportDataAsCode(@as([*c]const u8, @ptrCast(data)), @as(c_int, @intCast(data.len)), @as([*c]const u8, @ptrCast(fileName)));
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

pub fn loadImageAnimFromMemory(fileType: [:0]const u8, fileData: []const u8, frames: *i32) Image {
    return cdef.LoadImageAnimFromMemory(@as([*c]const u8, @ptrCast(fileType)), @as([*c]const u8, @ptrCast(fileData)), @as(c_int, @intCast(fileData.len)), @as([*c]c_int, @ptrCast(frames)));
}

pub fn loadImageFromMemory(fileType: [:0]const u8, fileData: []const u8) Image {
    return cdef.LoadImageFromMemory(@as([*c]const u8, @ptrCast(fileType)), @as([*c]const u8, @ptrCast(fileData)), @as(c_int, @intCast(fileData.len)));
}

pub fn loadImageColors(image: Image) RaylibError![]Color {
    var res: []Color = undefined;

    const ptr = cdef.LoadImageColors(image);
    if (ptr == 0) return RaylibError.GenericError;

    res.ptr = @as([*]Color, @ptrCast(ptr));
    res.len = @as(usize, @intCast(image.width * image.height));
    return res;
}

pub fn loadImagePalette(image: Image, maxPaletteSize: i32) RaylibError![]Color {
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

pub fn loadFontData(fileData: []const u8, fontSize: i32, fontChars: []i32, ty: FontType) RaylibError![]GlyphInfo {
    var res: []GlyphInfo = undefined;

    const ptr = cdef.LoadFontData(@as([*c]const u8, @ptrCast(fileData)), @as(c_int, @intCast(fileData.len)), @as(c_int, fontSize), @as([*c]c_int, @ptrCast(fontChars)), @as(c_int, @intCast(fontChars.len)), ty);
    if (ptr == 0) return RaylibError.GenericError;

    res.ptr = @as([*]GlyphInfo, @ptrCast(ptr));
    res.len = @as(usize, @intCast(fontChars.len));
    return res;
}

pub fn loadCodepoints(text: [:0]const u8) RaylibError![]i32 {
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

pub fn loadMaterials(fileName: [:0]const u8) RaylibError![]Material {
    var materialCount: i32 = 0;
    var res: []Material = undefined;

    const ptr = cdef.LoadMaterials(@as([*c]const u8, @ptrCast(fileName)), @as([*c]c_int, @ptrCast(&materialCount)));
    if (ptr == 0) return RaylibError.GenericError;

    res.ptr = @as([*]Material, @ptrCast(ptr));
    res.len = @as(usize, @intCast(materialCount));
    return res;
}

pub fn loadModelAnimations(fileName: [:0]const u8) RaylibError![]ModelAnimation {
    var animCount: i32 = 0;
    var res: []ModelAnimation = undefined;

    const ptr = cdef.LoadModelAnimations(@as([*c]const u8, @ptrCast(fileName)), @as([*c]c_int, @ptrCast(&animCount)));
    if (ptr == 0) return RaylibError.GenericError;

    res.ptr = @as([*]ModelAnimation, @ptrCast(ptr));
    res.len = @as(usize, @intCast(animCount));
    return res;
}

pub fn unloadModelAnimations(animations: []ModelAnimation) void {
    cdef.UnloadModelAnimations(@as([*c]ModelAnimation, @ptrCast(animations)), @as(c_int, @intCast(animations.len)));
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

pub fn drawTriangleStrip3D(points: []Vector3, color: Color) void {
    cdef.DrawTriangleStrip3D(@as([*c]Vector3, @ptrCast(points)), @as(c_int, @intCast(points.len)), color);
}

fn alloc(_: *anyopaque, len: usize, _: u8, _: usize) ?[*]u8 {
    std.debug.assert(len > 0);
    return @ptrCast(cdef.MemAlloc(@intCast(len)));
}

fn resize(_: *anyopaque, buf: []u8, _: u8, new_len: usize, _: usize) bool {
    return (new_len <= buf.len);
}

fn free(_: *anyopaque, buf: []u8, _: u8, _: usize) void {
    cdef.MemFree(buf.ptr);
}

const mem_vtable = std.mem.Allocator.VTable{
    .alloc = alloc,
    .resize = resize,
    .free = free,
};

pub const mem = std.mem.Allocator{
    .ptr = undefined,
    .vtable = &mem_vtable,
};

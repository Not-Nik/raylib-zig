usingnamespace @import("raylib-zig.zig");

pub extern fn Clamp(value: f32, min: f32, max: f32) f32;
pub extern fn Lerp(start: f32, end: f32, amount: f32) f32;
pub extern fn WVector2Length(v: [*c]const Vector2) float;
pub extern fn WVector2DotProduct(v1: [*c]const Vector2, v2: [*c]const Vector2) float;
pub extern fn WVector2Distance(v1: [*c]const Vector2, v2: [*c]const Vector2) float;
pub extern fn WVector2Angle(v1: [*c]const Vector2, v2: [*c]const Vector2) float;
pub extern fn WVector3Length(v: [*c]const Vector3) float;
pub extern fn WVector3DotProduct(v1: [*c]const Vector3, v2: [*c]const Vector3) float;
pub extern fn WVector3Distance(v1: [*c]const Vector3, v2: [*c]const Vector3) float;
pub extern fn WVector3OrthoNormalize(v1: [*c]const Vector3, v2: [*c]const Vector3) void;
pub extern fn MatrixDeterminant(mat: Matrix) f32;
pub extern fn MatrixTrace(mat: Matrix) f32;
pub extern fn MatrixTranspose(mat: Matrix) Matrix;
pub extern fn MatrixInvert(mat: Matrix) Matrix;
pub extern fn MatrixNormalize(mat: Matrix) Matrix;
pub extern fn MatrixIdentity() Matrix;
pub extern fn MatrixAdd(left: Matrix, right: Matrix) Matrix;
pub extern fn MatrixSubtract(left: Matrix, right: Matrix) Matrix;
pub extern fn MatrixTranslate(x: f32, y: f32, z: f32) Matrix;
pub extern fn WMatrixRotate(axis: [*c]const Vector3, angle: f32) Matrix;
pub extern fn WMatrixRotateXYZ(ang: [*c]const Vector3) Matrix;
pub extern fn MatrixRotateX(angle: f32) Matrix;
pub extern fn MatrixRotateY(angle: f32) Matrix;
pub extern fn MatrixRotateZ(angle: f32) Matrix;
pub extern fn MatrixScale(x: f32, y: f32, z: f32) Matrix;
pub extern fn MatrixMultiply(left: Matrix, right: Matrix) Matrix;
pub extern fn MatrixFrustum(left: double, right: double, bottom: double, top: double, near: double, far: double) Matrix;
pub extern fn MatrixPerspective(fovy: double, aspect: double, near: double, far: double) Matrix;
pub extern fn MatrixOrtho(left: double, right: double, bottom: double, top: double, near: double, far: double) Matrix;
pub extern fn WMatrixLookAt(eye: [*c]const Vector3, target: [*c]const Vector3, up: [*c]const Vector3) Matrix;
pub extern fn WQuaternionLength(q: [*c]const Quaternion) float;
pub extern fn WQuaternionToMatrix(q: [*c]const Quaternion) Matrix;
pub extern fn WQuaternionToAxisAngle(q: [*c]const Quaternion, outAxis: [*c]const Vector3, outAngle: [*c]const f32) void;

pub fn Vector2Length(v: Vector2) float
{
    return WVector2Length(&v);
}

pub fn Vector2DotProduct(v1: Vector2, v2: Vector2) float
{
    return WVector2DotProduct(&v1, &v2);
}

pub fn Vector2Distance(v1: Vector2, v2: Vector2) float
{
    return WVector2Distance(&v1, &v2);
}

pub fn Vector2Angle(v1: Vector2, v2: Vector2) float
{
    return WVector2Angle(&v1, &v2);
}

pub fn Vector3Length(v: Vector3) float
{
    return WVector3Length(&v);
}

pub fn Vector3DotProduct(v1: Vector3, v2: Vector3) float
{
    return WVector3DotProduct(&v1, &v2);
}

pub fn Vector3Distance(v1: Vector3, v2: Vector3) float
{
    return WVector3Distance(&v1, &v2);
}

pub fn Vector3OrthoNormalize(v1: [*c]const Vector3, v2: [*c]const Vector3) void
{
    WVector3OrthoNormalize(&v1[0], &v2[0]);
}

pub fn MatrixRotate(axis: Vector3, angle: f32) Matrix
{
    return WMatrixRotate(&axis, angle);
}

pub fn MatrixRotateXYZ(ang: Vector3) Matrix
{
    return WMatrixRotateXYZ(&ang);
}

pub fn MatrixLookAt(eye: Vector3, target: Vector3, up: Vector3) Matrix
{
    return WMatrixLookAt(&eye, &target, &up);
}

pub fn QuaternionLength(q: Quaternion) float
{
    return WQuaternionLength(&q);
}

pub fn QuaternionToMatrix(q: Quaternion) Matrix
{
    return WQuaternionToMatrix(&q);
}

pub fn QuaternionToAxisAngle(q: Quaternion, outAxis: [*c]const Vector3, outAngle: [*c]const f32) void
{
    WQuaternionToAxisAngle(&q, &outAxis[0], &outAngle[0]);
}


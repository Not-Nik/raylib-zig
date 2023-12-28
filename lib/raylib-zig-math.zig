// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib-zig");
const cdef = @import("raylib-zig-math-ext.zig");
const std = @import("std");

const Matrix = rl.Matrix;
const Quaternion = rl.Quaternion;
const Vector2 = rl.Vector2;
const Vector3 = rl.Vector3;
const Vector4 = rl.Vector4;

pub const float3 = extern struct {
    v: [3]f32,
};

pub const float16 = extern struct {
    v: [16]f32,
};

pub fn clamp(value: f32, min: f32, max: f32) f32 {
    return cdef.Clamp(value, min, max);
}

pub fn lerp(start: f32, end: f32, amount: f32) f32 {
    return cdef.Lerp(start, end, amount);
}

pub fn normalize(value: f32, start: f32, end: f32) f32 {
    return cdef.Normalize(value, start, end);
}

pub fn remap(value: f32, inputStart: f32, inputEnd: f32, outputStart: f32, outputEnd: f32) f32 {
    return cdef.Remap(value, inputStart, inputEnd, outputStart, outputEnd);
}

pub fn wrap(value: f32, min: f32, max: f32) f32 {
    return cdef.Wrap(value, min, max);
}

pub fn floatEquals(x: f32, y: f32) i32 {
    return @as(i32, cdef.FloatEquals(x, y));
}

pub fn vector2Zero() Vector2 {
    return cdef.Vector2Zero();
}

pub fn vector2One() Vector2 {
    return cdef.Vector2One();
}

pub fn vector2Add(v1: Vector2, v2: Vector2) Vector2 {
    return cdef.Vector2Add(v1, v2);
}

pub fn vector2AddValue(v: Vector2, add: f32) Vector2 {
    return cdef.Vector2AddValue(v, add);
}

pub fn vector2Subtract(v1: Vector2, v2: Vector2) Vector2 {
    return cdef.Vector2Subtract(v1, v2);
}

pub fn vector2SubtractValue(v: Vector2, sub: f32) Vector2 {
    return cdef.Vector2SubtractValue(v, sub);
}

pub fn vector2Length(v: Vector2) f32 {
    return cdef.Vector2Length(v);
}

pub fn vector2LengthSqr(v: Vector2) f32 {
    return cdef.Vector2LengthSqr(v);
}

pub fn vector2DotProduct(v1: Vector2, v2: Vector2) f32 {
    return cdef.Vector2DotProduct(v1, v2);
}

pub fn vector2Distance(v1: Vector2, v2: Vector2) f32 {
    return cdef.Vector2Distance(v1, v2);
}

pub fn vector2DistanceSqr(v1: Vector2, v2: Vector2) f32 {
    return cdef.Vector2DistanceSqr(v1, v2);
}

pub fn vector2Angle(v1: Vector2, v2: Vector2) f32 {
    return cdef.Vector2Angle(v1, v2);
}

pub fn vector2LineAngle(start: Vector2, end: Vector2) f32 {
    return cdef.Vector2LineAngle(start, end);
}

pub fn vector2Scale(v: Vector2, scale: f32) Vector2 {
    return cdef.Vector2Scale(v, scale);
}

pub fn vector2Multiply(v1: Vector2, v2: Vector2) Vector2 {
    return cdef.Vector2Multiply(v1, v2);
}

pub fn vector2Negate(v: Vector2) Vector2 {
    return cdef.Vector2Negate(v);
}

pub fn vector2Divide(v1: Vector2, v2: Vector2) Vector2 {
    return cdef.Vector2Divide(v1, v2);
}

pub fn vector2Normalize(v: Vector2) Vector2 {
    return cdef.Vector2Normalize(v);
}

pub fn vector2Transform(v: Vector2, mat: Matrix) Vector2 {
    return cdef.Vector2Transform(v, mat);
}

pub fn vector2Lerp(v1: Vector2, v2: Vector2, amount: f32) Vector2 {
    return cdef.Vector2Lerp(v1, v2, amount);
}

pub fn vector2Reflect(v: Vector2, normal: Vector2) Vector2 {
    return cdef.Vector2Reflect(v, normal);
}

pub fn vector2Rotate(v: Vector2, angle: f32) Vector2 {
    return cdef.Vector2Rotate(v, angle);
}

pub fn vector2MoveTowards(v: Vector2, target: Vector2, maxDistance: f32) Vector2 {
    return cdef.Vector2MoveTowards(v, target, maxDistance);
}

pub fn vector2Invert(v: Vector2) Vector2 {
    return cdef.Vector2Invert(v);
}

pub fn vector2Clamp(v: Vector2, min: Vector2, max: Vector2) Vector2 {
    return cdef.Vector2Clamp(v, min, max);
}

pub fn vector2ClampValue(v: Vector2, min: f32, max: f32) Vector2 {
    return cdef.Vector2ClampValue(v, min, max);
}

pub fn vector2Equals(p: Vector2, q: Vector2) i32 {
    return @as(i32, cdef.Vector2Equals(p, q));
}

pub fn vector3Zero() Vector3 {
    return cdef.Vector3Zero();
}

pub fn vector3One() Vector3 {
    return cdef.Vector3One();
}

pub fn vector3Add(v1: Vector3, v2: Vector3) Vector3 {
    return cdef.Vector3Add(v1, v2);
}

pub fn vector3AddValue(v: Vector3, add: f32) Vector3 {
    return cdef.Vector3AddValue(v, add);
}

pub fn vector3Subtract(v1: Vector3, v2: Vector3) Vector3 {
    return cdef.Vector3Subtract(v1, v2);
}

pub fn vector3SubtractValue(v: Vector3, sub: f32) Vector3 {
    return cdef.Vector3SubtractValue(v, sub);
}

pub fn vector3Scale(v: Vector3, scalar: f32) Vector3 {
    return cdef.Vector3Scale(v, scalar);
}

pub fn vector3Multiply(v1: Vector3, v2: Vector3) Vector3 {
    return cdef.Vector3Multiply(v1, v2);
}

pub fn vector3CrossProduct(v1: Vector3, v2: Vector3) Vector3 {
    return cdef.Vector3CrossProduct(v1, v2);
}

pub fn vector3Perpendicular(v: Vector3) Vector3 {
    return cdef.Vector3Perpendicular(v);
}

pub fn vector3Length(v: Vector3) f32 {
    return cdef.Vector3Length(v);
}

pub fn vector3LengthSqr(v: Vector3) f32 {
    return cdef.Vector3LengthSqr(v);
}

pub fn vector3DotProduct(v1: Vector3, v2: Vector3) f32 {
    return cdef.Vector3DotProduct(v1, v2);
}

pub fn vector3Distance(v1: Vector3, v2: Vector3) f32 {
    return cdef.Vector3Distance(v1, v2);
}

pub fn vector3DistanceSqr(v1: Vector3, v2: Vector3) f32 {
    return cdef.Vector3DistanceSqr(v1, v2);
}

pub fn vector3Angle(v1: Vector3, v2: Vector3) f32 {
    return cdef.Vector3Angle(v1, v2);
}

pub fn vector3Negate(v: Vector3) Vector3 {
    return cdef.Vector3Negate(v);
}

pub fn vector3Divide(v1: Vector3, v2: Vector3) Vector3 {
    return cdef.Vector3Divide(v1, v2);
}

pub fn vector3Normalize(v: Vector3) Vector3 {
    return cdef.Vector3Normalize(v);
}

pub fn vector3Project(v1: Vector3, v2: Vector3) Vector3 {
    return cdef.Vector3Project(v1, v2);
}

pub fn vector3Reject(v1: Vector3, v2: Vector3) Vector3 {
    return cdef.Vector3Reject(v1, v2);
}

pub fn vector3OrthoNormalize(v1: *Vector3, v2: *Vector3) void {
    cdef.Vector3OrthoNormalize(@as([*c]Vector3, @ptrCast(v1)), @as([*c]Vector3, @ptrCast(v2)));
}

pub fn vector3Transform(v: Vector3, mat: Matrix) Vector3 {
    return cdef.Vector3Transform(v, mat);
}

pub fn vector3RotateByQuaternion(v: Vector3, q: Quaternion) Vector3 {
    return cdef.Vector3RotateByQuaternion(v, q);
}

pub fn vector3RotateByAxisAngle(v: Vector3, axis: Vector3, angle: f32) Vector3 {
    return cdef.Vector3RotateByAxisAngle(v, axis, angle);
}

pub fn vector3Lerp(v1: Vector3, v2: Vector3, amount: f32) Vector3 {
    return cdef.Vector3Lerp(v1, v2, amount);
}

pub fn vector3Reflect(v: Vector3, normal: Vector3) Vector3 {
    return cdef.Vector3Reflect(v, normal);
}

pub fn vector3Min(v1: Vector3, v2: Vector3) Vector3 {
    return cdef.Vector3Min(v1, v2);
}

pub fn vector3Max(v1: Vector3, v2: Vector3) Vector3 {
    return cdef.Vector3Max(v1, v2);
}

pub fn vector3Barycenter(p: Vector3, a: Vector3, b: Vector3, c: Vector3) Vector3 {
    return cdef.Vector3Barycenter(p, a, b, c);
}

pub fn vector3Unproject(source: Vector3, projection: Matrix, view: Matrix) Vector3 {
    return cdef.Vector3Unproject(source, projection, view);
}

pub fn vector3ToFloatV(v: Vector3) float3 {
    return cdef.Vector3ToFloatV(v);
}

pub fn vector3Invert(v: Vector3) Vector3 {
    return cdef.Vector3Invert(v);
}

pub fn vector3Clamp(v: Vector3, min: Vector3, max: Vector3) Vector3 {
    return cdef.Vector3Clamp(v, min, max);
}

pub fn vector3ClampValue(v: Vector3, min: f32, max: f32) Vector3 {
    return cdef.Vector3ClampValue(v, min, max);
}

pub fn vector3Equals(p: Vector3, q: Vector3) i32 {
    return @as(i32, cdef.Vector3Equals(p, q));
}

pub fn vector3Refract(v: Vector3, n: Vector3, r: f32) Vector3 {
    return cdef.Vector3Refract(v, n, r);
}

pub fn matrixDeterminant(mat: Matrix) f32 {
    return cdef.MatrixDeterminant(mat);
}

pub fn matrixTrace(mat: Matrix) f32 {
    return cdef.MatrixTrace(mat);
}

pub fn matrixTranspose(mat: Matrix) Matrix {
    return cdef.MatrixTranspose(mat);
}

pub fn matrixInvert(mat: Matrix) Matrix {
    return cdef.MatrixInvert(mat);
}

pub fn matrixIdentity() Matrix {
    return cdef.MatrixIdentity();
}

pub fn matrixAdd(left: Matrix, right: Matrix) Matrix {
    return cdef.MatrixAdd(left, right);
}

pub fn matrixSubtract(left: Matrix, right: Matrix) Matrix {
    return cdef.MatrixSubtract(left, right);
}

pub fn matrixMultiply(left: Matrix, right: Matrix) Matrix {
    return cdef.MatrixMultiply(left, right);
}

pub fn matrixTranslate(x: f32, y: f32, z: f32) Matrix {
    return cdef.MatrixTranslate(x, y, z);
}

pub fn matrixRotate(axis: Vector3, angle: f32) Matrix {
    return cdef.MatrixRotate(axis, angle);
}

pub fn matrixRotateX(angle: f32) Matrix {
    return cdef.MatrixRotateX(angle);
}

pub fn matrixRotateY(angle: f32) Matrix {
    return cdef.MatrixRotateY(angle);
}

pub fn matrixRotateZ(angle: f32) Matrix {
    return cdef.MatrixRotateZ(angle);
}

pub fn matrixRotateXYZ(angle: Vector3) Matrix {
    return cdef.MatrixRotateXYZ(angle);
}

pub fn matrixRotateZYX(angle: Vector3) Matrix {
    return cdef.MatrixRotateZYX(angle);
}

pub fn matrixScale(x: f32, y: f32, z: f32) Matrix {
    return cdef.MatrixScale(x, y, z);
}

pub fn matrixFrustum(left: f64, right: f64, bottom: f64, top: f64, near: f64, far: f64) Matrix {
    return cdef.MatrixFrustum(left, right, bottom, top, near, far);
}

pub fn matrixPerspective(fovY: f64, aspect: f64, nearPlane: f64, farPlane: f64) Matrix {
    return cdef.MatrixPerspective(fovY, aspect, nearPlane, farPlane);
}

pub fn matrixOrtho(left: f64, right: f64, bottom: f64, top: f64, nearPlane: f64, farPlane: f64) Matrix {
    return cdef.MatrixOrtho(left, right, bottom, top, nearPlane, farPlane);
}

pub fn matrixLookAt(eye: Vector3, target: Vector3, up: Vector3) Matrix {
    return cdef.MatrixLookAt(eye, target, up);
}

pub fn matrixToFloatV(mat: Matrix) float16 {
    return cdef.MatrixToFloatV(mat);
}

pub fn quaternionAdd(q1: Quaternion, q2: Quaternion) Quaternion {
    return cdef.QuaternionAdd(q1, q2);
}

pub fn quaternionAddValue(q: Quaternion, add: f32) Quaternion {
    return cdef.QuaternionAddValue(q, add);
}

pub fn quaternionSubtract(q1: Quaternion, q2: Quaternion) Quaternion {
    return cdef.QuaternionSubtract(q1, q2);
}

pub fn quaternionSubtractValue(q: Quaternion, sub: f32) Quaternion {
    return cdef.QuaternionSubtractValue(q, sub);
}

pub fn quaternionIdentity() Quaternion {
    return cdef.QuaternionIdentity();
}

pub fn quaternionLength(q: Quaternion) f32 {
    return cdef.QuaternionLength(q);
}

pub fn quaternionNormalize(q: Quaternion) Quaternion {
    return cdef.QuaternionNormalize(q);
}

pub fn quaternionInvert(q: Quaternion) Quaternion {
    return cdef.QuaternionInvert(q);
}

pub fn quaternionMultiply(q1: Quaternion, q2: Quaternion) Quaternion {
    return cdef.QuaternionMultiply(q1, q2);
}

pub fn quaternionScale(q: Quaternion, mul: f32) Quaternion {
    return cdef.QuaternionScale(q, mul);
}

pub fn quaternionDivide(q1: Quaternion, q2: Quaternion) Quaternion {
    return cdef.QuaternionDivide(q1, q2);
}

pub fn quaternionLerp(q1: Quaternion, q2: Quaternion, amount: f32) Quaternion {
    return cdef.QuaternionLerp(q1, q2, amount);
}

pub fn quaternionNlerp(q1: Quaternion, q2: Quaternion, amount: f32) Quaternion {
    return cdef.QuaternionNlerp(q1, q2, amount);
}

pub fn quaternionSlerp(q1: Quaternion, q2: Quaternion, amount: f32) Quaternion {
    return cdef.QuaternionSlerp(q1, q2, amount);
}

pub fn quaternionFromVector3ToVector3(from: Vector3, to: Vector3) Quaternion {
    return cdef.QuaternionFromVector3ToVector3(from, to);
}

pub fn quaternionFromMatrix(mat: Matrix) Quaternion {
    return cdef.QuaternionFromMatrix(mat);
}

pub fn quaternionToMatrix(q: Quaternion) Matrix {
    return cdef.QuaternionToMatrix(q);
}

pub fn quaternionFromAxisAngle(axis: Vector3, angle: f32) Quaternion {
    return cdef.QuaternionFromAxisAngle(axis, angle);
}

pub fn quaternionToAxisAngle(q: Quaternion, outAxis: *Vector3, outAngle: *f32) void {
    cdef.QuaternionToAxisAngle(q, @as([*c]Vector3, @ptrCast(outAxis)), @as([*c]f32, @ptrCast(outAngle)));
}

pub fn quaternionFromEuler(pitch: f32, yaw: f32, roll: f32) Quaternion {
    return cdef.QuaternionFromEuler(pitch, yaw, roll);
}

pub fn quaternionToEuler(q: Quaternion) Vector3 {
    return cdef.QuaternionToEuler(q);
}

pub fn quaternionTransform(q: Quaternion, mat: Matrix) Quaternion {
    return cdef.QuaternionTransform(q, mat);
}

pub fn quaternionEquals(p: Quaternion, q: Quaternion) i32 {
    return @as(i32, cdef.QuaternionEquals(p, q));
}

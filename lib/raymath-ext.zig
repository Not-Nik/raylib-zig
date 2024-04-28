// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib-zig");
const rlm = @import("raymath.zig");

pub extern "c" fn Clamp(value: f32, min: f32, max: f32) f32;
pub extern "c" fn Lerp(start: f32, end: f32, amount: f32) f32;
pub extern "c" fn Normalize(value: f32, start: f32, end: f32) f32;
pub extern "c" fn Remap(value: f32, inputStart: f32, inputEnd: f32, outputStart: f32, outputEnd: f32) f32;
pub extern "c" fn Wrap(value: f32, min: f32, max: f32) f32;
pub extern "c" fn FloatEquals(x: f32, y: f32) c_int;
pub extern "c" fn Vector2Zero() rl.Vector2;
pub extern "c" fn Vector2One() rl.Vector2;
pub extern "c" fn Vector2Add(v1: rl.Vector2, v2: rl.Vector2) rl.Vector2;
pub extern "c" fn Vector2AddValue(v: rl.Vector2, add: f32) rl.Vector2;
pub extern "c" fn Vector2Subtract(v1: rl.Vector2, v2: rl.Vector2) rl.Vector2;
pub extern "c" fn Vector2SubtractValue(v: rl.Vector2, sub: f32) rl.Vector2;
pub extern "c" fn Vector2Length(v: rl.Vector2) f32;
pub extern "c" fn Vector2LengthSqr(v: rl.Vector2) f32;
pub extern "c" fn Vector2DotProduct(v1: rl.Vector2, v2: rl.Vector2) f32;
pub extern "c" fn Vector2Distance(v1: rl.Vector2, v2: rl.Vector2) f32;
pub extern "c" fn Vector2DistanceSqr(v1: rl.Vector2, v2: rl.Vector2) f32;
pub extern "c" fn Vector2Angle(v1: rl.Vector2, v2: rl.Vector2) f32;
pub extern "c" fn Vector2LineAngle(start: rl.Vector2, end: rl.Vector2) f32;
pub extern "c" fn Vector2Scale(v: rl.Vector2, scale: f32) rl.Vector2;
pub extern "c" fn Vector2Multiply(v1: rl.Vector2, v2: rl.Vector2) rl.Vector2;
pub extern "c" fn Vector2Negate(v: rl.Vector2) rl.Vector2;
pub extern "c" fn Vector2Divide(v1: rl.Vector2, v2: rl.Vector2) rl.Vector2;
pub extern "c" fn Vector2Normalize(v: rl.Vector2) rl.Vector2;
pub extern "c" fn Vector2Transform(v: rl.Vector2, mat: rl.Matrix) rl.Vector2;
pub extern "c" fn Vector2Lerp(v1: rl.Vector2, v2: rl.Vector2, amount: f32) rl.Vector2;
pub extern "c" fn Vector2Reflect(v: rl.Vector2, normal: rl.Vector2) rl.Vector2;
pub extern "c" fn Vector2Min(v1: rl.Vector2, v2: rl.Vector2) rl.Vector2;
pub extern "c" fn Vector2Max(v1: rl.Vector2, v2: rl.Vector2) rl.Vector2;
pub extern "c" fn Vector2Rotate(v: rl.Vector2, angle: f32) rl.Vector2;
pub extern "c" fn Vector2MoveTowards(v: rl.Vector2, target: rl.Vector2, maxDistance: f32) rl.Vector2;
pub extern "c" fn Vector2Invert(v: rl.Vector2) rl.Vector2;
pub extern "c" fn Vector2Clamp(v: rl.Vector2, min: rl.Vector2, max: rl.Vector2) rl.Vector2;
pub extern "c" fn Vector2ClampValue(v: rl.Vector2, min: f32, max: f32) rl.Vector2;
pub extern "c" fn Vector2Equals(p: rl.Vector2, q: rl.Vector2) c_int;
pub extern "c" fn Vector2Refract(v: rl.Vector2, n: rl.Vector2, r: f32) rl.Vector2;
pub extern "c" fn Vector3Zero() rl.Vector3;
pub extern "c" fn Vector3One() rl.Vector3;
pub extern "c" fn Vector3Add(v1: rl.Vector3, v2: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3AddValue(v: rl.Vector3, add: f32) rl.Vector3;
pub extern "c" fn Vector3Subtract(v1: rl.Vector3, v2: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3SubtractValue(v: rl.Vector3, sub: f32) rl.Vector3;
pub extern "c" fn Vector3Scale(v: rl.Vector3, scalar: f32) rl.Vector3;
pub extern "c" fn Vector3Multiply(v1: rl.Vector3, v2: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3CrossProduct(v1: rl.Vector3, v2: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3Perpendicular(v: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3Length(v: rl.Vector3) f32;
pub extern "c" fn Vector3LengthSqr(v: rl.Vector3) f32;
pub extern "c" fn Vector3DotProduct(v1: rl.Vector3, v2: rl.Vector3) f32;
pub extern "c" fn Vector3Distance(v1: rl.Vector3, v2: rl.Vector3) f32;
pub extern "c" fn Vector3DistanceSqr(v1: rl.Vector3, v2: rl.Vector3) f32;
pub extern "c" fn Vector3Angle(v1: rl.Vector3, v2: rl.Vector3) f32;
pub extern "c" fn Vector3Negate(v: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3Divide(v1: rl.Vector3, v2: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3Normalize(v: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3Project(v1: rl.Vector3, v2: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3Reject(v1: rl.Vector3, v2: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3OrthoNormalize(v1: [*c]rl.Vector3, v2: [*c]rl.Vector3) void;
pub extern "c" fn Vector3Transform(v: rl.Vector3, mat: rl.Matrix) rl.Vector3;
pub extern "c" fn Vector3RotateByQuaternion(v: rl.Vector3, q: rl.Quaternion) rl.Vector3;
pub extern "c" fn Vector3RotateByAxisAngle(v: rl.Vector3, axis: rl.Vector3, angle: f32) rl.Vector3;
pub extern "c" fn Vector3MoveTowards(v: rl.Vector3, target: rl.Vector3, maxDistance: f32) rl.Vector3;
pub extern "c" fn Vector3Lerp(v1: rl.Vector3, v2: rl.Vector3, amount: f32) rl.Vector3;
pub extern "c" fn Vector3CubicHermite(v1: rl.Vector3, tangent1: rl.Vector3, v2: rl.Vector3, tangent2: rl.Vector3, amount: f32) rl.Vector3;
pub extern "c" fn Vector3Reflect(v: rl.Vector3, normal: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3Min(v1: rl.Vector3, v2: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3Max(v1: rl.Vector3, v2: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3Barycenter(p: rl.Vector3, a: rl.Vector3, b: rl.Vector3, c: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3Unproject(source: rl.Vector3, projection: rl.Matrix, view: rl.Matrix) rl.Vector3;
pub extern "c" fn Vector3ToFloatV(v: rl.Vector3) rlm.float3;
pub extern "c" fn Vector3Invert(v: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3Clamp(v: rl.Vector3, min: rl.Vector3, max: rl.Vector3) rl.Vector3;
pub extern "c" fn Vector3ClampValue(v: rl.Vector3, min: f32, max: f32) rl.Vector3;
pub extern "c" fn Vector3Equals(p: rl.Vector3, q: rl.Vector3) c_int;
pub extern "c" fn Vector3Refract(v: rl.Vector3, n: rl.Vector3, r: f32) rl.Vector3;
pub extern "c" fn Vector4Zero() rl.Vector4;
pub extern "c" fn Vector4One() rl.Vector4;
pub extern "c" fn Vector4Add(v1: rl.Vector4, v2: rl.Vector4) rl.Vector4;
pub extern "c" fn Vector4AddValue(v: rl.Vector4, add: f32) rl.Vector4;
pub extern "c" fn Vector4Subtract(v1: rl.Vector4, v2: rl.Vector4) rl.Vector4;
pub extern "c" fn Vector4SubtractValue(v: rl.Vector4, add: f32) rl.Vector4;
pub extern "c" fn Vector4Length(v: rl.Vector4) f32;
pub extern "c" fn Vector4LengthSqr(v: rl.Vector4) f32;
pub extern "c" fn Vector4DotProduct(v1: rl.Vector4, v2: rl.Vector4) f32;
pub extern "c" fn Vector4Distance(v1: rl.Vector4, v2: rl.Vector4) f32;
pub extern "c" fn Vector4DistanceSqr(v1: rl.Vector4, v2: rl.Vector4) f32;
pub extern "c" fn Vector4Scale(v: rl.Vector4, scale: f32) rl.Vector4;
pub extern "c" fn Vector4Multiply(v1: rl.Vector4, v2: rl.Vector4) rl.Vector4;
pub extern "c" fn Vector4Negate(v: rl.Vector4) rl.Vector4;
pub extern "c" fn Vector4Divide(v1: rl.Vector4, v2: rl.Vector4) rl.Vector4;
pub extern "c" fn Vector4Normalize(v: rl.Vector4) rl.Vector4;
pub extern "c" fn Vector4Min(v1: rl.Vector4, v2: rl.Vector4) rl.Vector4;
pub extern "c" fn Vector4Max(v1: rl.Vector4, v2: rl.Vector4) rl.Vector4;
pub extern "c" fn Vector4Lerp(v1: rl.Vector4, v2: rl.Vector4, amount: f32) rl.Vector4;
pub extern "c" fn Vector4MoveTowards(v: rl.Vector4, target: rl.Vector4, maxDistance: f32) rl.Vector4;
pub extern "c" fn Vector4Invert(v: rl.Vector4) rl.Vector4;
pub extern "c" fn Vector4Equals(p: rl.Vector4, q: rl.Vector4) c_int;
pub extern "c" fn MatrixDeterminant(mat: rl.Matrix) f32;
pub extern "c" fn MatrixTrace(mat: rl.Matrix) f32;
pub extern "c" fn MatrixTranspose(mat: rl.Matrix) rl.Matrix;
pub extern "c" fn MatrixInvert(mat: rl.Matrix) rl.Matrix;
pub extern "c" fn MatrixIdentity() rl.Matrix;
pub extern "c" fn MatrixAdd(left: rl.Matrix, right: rl.Matrix) rl.Matrix;
pub extern "c" fn MatrixSubtract(left: rl.Matrix, right: rl.Matrix) rl.Matrix;
pub extern "c" fn MatrixMultiply(left: rl.Matrix, right: rl.Matrix) rl.Matrix;
pub extern "c" fn MatrixTranslate(x: f32, y: f32, z: f32) rl.Matrix;
pub extern "c" fn MatrixRotate(axis: rl.Vector3, angle: f32) rl.Matrix;
pub extern "c" fn MatrixRotateX(angle: f32) rl.Matrix;
pub extern "c" fn MatrixRotateY(angle: f32) rl.Matrix;
pub extern "c" fn MatrixRotateZ(angle: f32) rl.Matrix;
pub extern "c" fn MatrixRotateXYZ(angle: rl.Vector3) rl.Matrix;
pub extern "c" fn MatrixRotateZYX(angle: rl.Vector3) rl.Matrix;
pub extern "c" fn MatrixScale(x: f32, y: f32, z: f32) rl.Matrix;
pub extern "c" fn MatrixFrustum(left: f64, right: f64, bottom: f64, top: f64, near: f64, far: f64) rl.Matrix;
pub extern "c" fn MatrixPerspective(fovY: f64, aspect: f64, nearPlane: f64, farPlane: f64) rl.Matrix;
pub extern "c" fn MatrixOrtho(left: f64, right: f64, bottom: f64, top: f64, nearPlane: f64, farPlane: f64) rl.Matrix;
pub extern "c" fn MatrixLookAt(eye: rl.Vector3, target: rl.Vector3, up: rl.Vector3) rl.Matrix;
pub extern "c" fn MatrixToFloatV(mat: rl.Matrix) rlm.float16;
pub extern "c" fn QuaternionAdd(q1: rl.Quaternion, q2: rl.Quaternion) rl.Quaternion;
pub extern "c" fn QuaternionAddValue(q: rl.Quaternion, add: f32) rl.Quaternion;
pub extern "c" fn QuaternionSubtract(q1: rl.Quaternion, q2: rl.Quaternion) rl.Quaternion;
pub extern "c" fn QuaternionSubtractValue(q: rl.Quaternion, sub: f32) rl.Quaternion;
pub extern "c" fn QuaternionIdentity() rl.Quaternion;
pub extern "c" fn QuaternionLength(q: rl.Quaternion) f32;
pub extern "c" fn QuaternionNormalize(q: rl.Quaternion) rl.Quaternion;
pub extern "c" fn QuaternionInvert(q: rl.Quaternion) rl.Quaternion;
pub extern "c" fn QuaternionMultiply(q1: rl.Quaternion, q2: rl.Quaternion) rl.Quaternion;
pub extern "c" fn QuaternionScale(q: rl.Quaternion, mul: f32) rl.Quaternion;
pub extern "c" fn QuaternionDivide(q1: rl.Quaternion, q2: rl.Quaternion) rl.Quaternion;
pub extern "c" fn QuaternionLerp(q1: rl.Quaternion, q2: rl.Quaternion, amount: f32) rl.Quaternion;
pub extern "c" fn QuaternionNlerp(q1: rl.Quaternion, q2: rl.Quaternion, amount: f32) rl.Quaternion;
pub extern "c" fn QuaternionSlerp(q1: rl.Quaternion, q2: rl.Quaternion, amount: f32) rl.Quaternion;
pub extern "c" fn QuaternionCubicHermiteSpline(q1: rl.Quaternion, outTangent1: rl.Quaternion, q2: rl.Quaternion, inTangent2: rl.Quaternion, t: f32) rl.Quaternion;
pub extern "c" fn QuaternionFromVector3ToVector3(from: rl.Vector3, to: rl.Vector3) rl.Quaternion;
pub extern "c" fn QuaternionFromMatrix(mat: rl.Matrix) rl.Quaternion;
pub extern "c" fn QuaternionToMatrix(q: rl.Quaternion) rl.Matrix;
pub extern "c" fn QuaternionFromAxisAngle(axis: rl.Vector3, angle: f32) rl.Quaternion;
pub extern "c" fn QuaternionToAxisAngle(q: rl.Quaternion, outAxis: [*c]rl.Vector3, outAngle: [*c]f32) void;
pub extern "c" fn QuaternionFromEuler(pitch: f32, yaw: f32, roll: f32) rl.Quaternion;
pub extern "c" fn QuaternionToEuler(q: rl.Quaternion) rl.Vector3;
pub extern "c" fn QuaternionTransform(q: rl.Quaternion, mat: rl.Matrix) rl.Quaternion;
pub extern "c" fn QuaternionEquals(p: rl.Quaternion, q: rl.Quaternion) c_int;

//
// rayzig_math
// Zig version: 0.5.0
// Author: Nikolas Wipper
// Date: 2020-02-15
//

usingnamespace @import("rayzig.zig");

pub const float3 = extern struct {
    v: [3]f32,
};

pub const float16 = extern struct {
    v: [16]f32,
};

pub extern fn acosf(arg0: f32) f32;
pub extern fn acos(arg0: f64) f64;
pub extern fn acosl(arg0: c_longdouble) c_longdouble;
pub extern fn asinf(arg0: f32) f32;
pub extern fn asin(arg0: f64) f64;
pub extern fn asinl(arg0: c_longdouble) c_longdouble;
pub extern fn atanf(arg0: f32) f32;
pub extern fn atan(arg0: f64) f64;
pub extern fn atanl(arg0: c_longdouble) c_longdouble;
pub extern fn atan2f(arg0: f32, arg1: f32) f32;
pub extern fn atan2(arg0: f64, arg1: f64) f64;
pub extern fn atan2l(arg0: c_longdouble, arg1: c_longdouble) c_longdouble;
pub extern fn cosf(arg0: f32) f32;
pub extern fn cos(arg0: f64) f64;
pub extern fn cosl(arg0: c_longdouble) c_longdouble;
pub extern fn sinf(arg0: f32) f32;
pub extern fn sin(arg0: f64) f64;
pub extern fn sinl(arg0: c_longdouble) c_longdouble;
pub extern fn tanf(arg0: f32) f32;
pub extern fn tan(arg0: f64) f64;
pub extern fn tanl(arg0: c_longdouble) c_longdouble;
pub extern fn acoshf(arg0: f32) f32;
pub extern fn acosh(arg0: f64) f64;
pub extern fn acoshl(arg0: c_longdouble) c_longdouble;
pub extern fn asinhf(arg0: f32) f32;
pub extern fn asinh(arg0: f64) f64;
pub extern fn asinhl(arg0: c_longdouble) c_longdouble;
pub extern fn atanhf(arg0: f32) f32;
pub extern fn atanh(arg0: f64) f64;
pub extern fn atanhl(arg0: c_longdouble) c_longdouble;
pub extern fn coshf(arg0: f32) f32;
pub extern fn cosh(arg0: f64) f64;
pub extern fn coshl(arg0: c_longdouble) c_longdouble;
pub extern fn sinhf(arg0: f32) f32;
pub extern fn sinh(arg0: f64) f64;
pub extern fn sinhl(arg0: c_longdouble) c_longdouble;
pub extern fn tanhf(arg0: f32) f32;
pub extern fn tanh(arg0: f64) f64;
pub extern fn tanhl(arg0: c_longdouble) c_longdouble;
pub extern fn expf(arg0: f32) f32;
pub extern fn exp(arg0: f64) f64;
pub extern fn expl(arg0: c_longdouble) c_longdouble;
pub extern fn exp2f(arg0: f32) f32;
pub extern fn exp2(arg0: f64) f64;
pub extern fn exp2l(arg0: c_longdouble) c_longdouble;
pub extern fn expm1f(arg0: f32) f32;
pub extern fn expm1(arg0: f64) f64;
pub extern fn expm1l(arg0: c_longdouble) c_longdouble;
pub extern fn logf(arg0: f32) f32;
pub extern fn log(arg0: f64) f64;
pub extern fn logl(arg0: c_longdouble) c_longdouble;
pub extern fn log10f(arg0: f32) f32;
pub extern fn log10(arg0: f64) f64;
pub extern fn log10l(arg0: c_longdouble) c_longdouble;
pub extern fn log2f(arg0: f32) f32;
pub extern fn log2(arg0: f64) f64;
pub extern fn log2l(arg0: c_longdouble) c_longdouble;
pub extern fn log1pf(arg0: f32) f32;
pub extern fn log1p(arg0: f64) f64;
pub extern fn log1pl(arg0: c_longdouble) c_longdouble;
pub extern fn logbf(arg0: f32) f32;
pub extern fn logb(arg0: f64) f64;
pub extern fn logbl(arg0: c_longdouble) c_longdouble;
pub extern fn modff(arg0: f32, arg1: [*c]f32) f32;
pub extern fn modf(arg0: f64, arg1: [*c]f64) f64;
pub extern fn modfl(arg0: c_longdouble, arg1: [*c]c_longdouble) c_longdouble;
pub extern fn ldexpf(arg0: f32, arg1: c_int) f32;
pub extern fn ldexp(arg0: f64, arg1: c_int) f64;
pub extern fn ldexpl(arg0: c_longdouble, arg1: c_int) c_longdouble;
pub extern fn frexpf(arg0: f32, arg1: [*c]c_int) f32;
pub extern fn frexp(arg0: f64, arg1: [*c]c_int) f64;
pub extern fn frexpl(arg0: c_longdouble, arg1: [*c]c_int) c_longdouble;
pub extern fn ilogbf(arg0: f32) c_int;
pub extern fn ilogb(arg0: f64) c_int;
pub extern fn ilogbl(arg0: c_longdouble) c_int;
pub extern fn scalbnf(arg0: f32, arg1: c_int) f32;
pub extern fn scalbn(arg0: f64, arg1: c_int) f64;
pub extern fn scalbnl(arg0: c_longdouble, arg1: c_int) c_longdouble;
pub extern fn scalblnf(arg0: f32, arg1: c_long) f32;
pub extern fn scalbln(arg0: f64, arg1: c_long) f64;
pub extern fn scalblnl(arg0: c_longdouble, arg1: c_long) c_longdouble;
pub extern fn fabsf(arg0: f32) f32;
pub extern fn fabs(arg0: f64) f64;
pub extern fn fabsl(arg0: c_longdouble) c_longdouble;
pub extern fn cbrtf(arg0: f32) f32;
pub extern fn cbrt(arg0: f64) f64;
pub extern fn cbrtl(arg0: c_longdouble) c_longdouble;
pub extern fn hypotf(arg0: f32, arg1: f32) f32;
pub extern fn hypot(arg0: f64, arg1: f64) f64;
pub extern fn hypotl(arg0: c_longdouble, arg1: c_longdouble) c_longdouble;
pub extern fn powf(arg0: f32, arg1: f32) f32;
pub extern fn pow(arg0: f64, arg1: f64) f64;
pub extern fn powl(arg0: c_longdouble, arg1: c_longdouble) c_longdouble;
pub extern fn sqrtf(arg0: f32) f32;
pub extern fn sqrt(arg0: f64) f64;
pub extern fn sqrtl(arg0: c_longdouble) c_longdouble;
pub extern fn erff(arg0: f32) f32;
pub extern fn erf(arg0: f64) f64;
pub extern fn erfl(arg0: c_longdouble) c_longdouble;
pub extern fn erfcf(arg0: f32) f32;
pub extern fn erfc(arg0: f64) f64;
pub extern fn erfcl(arg0: c_longdouble) c_longdouble;
pub extern fn lgammaf(arg0: f32) f32;
pub extern fn lgamma(arg0: f64) f64;
pub extern fn lgammal(arg0: c_longdouble) c_longdouble;
pub extern fn tgammaf(arg0: f32) f32;
pub extern fn tgamma(arg0: f64) f64;
pub extern fn tgammal(arg0: c_longdouble) c_longdouble;
pub extern fn ceilf(arg0: f32) f32;
pub extern fn ceil(arg0: f64) f64;
pub extern fn ceill(arg0: c_longdouble) c_longdouble;
pub extern fn floorf(arg0: f32) f32;
pub extern fn floor(arg0: f64) f64;
pub extern fn floorl(arg0: c_longdouble) c_longdouble;
pub extern fn nearbyintf(arg0: f32) f32;
pub extern fn nearbyint(arg0: f64) f64;
pub extern fn nearbyintl(arg0: c_longdouble) c_longdouble;
pub extern fn rintf(arg0: f32) f32;
pub extern fn rint(arg0: f64) f64;
pub extern fn rintl(arg0: c_longdouble) c_longdouble;
pub extern fn lrintf(arg0: f32) c_long;
pub extern fn lrint(arg0: f64) c_long;
pub extern fn lrintl(arg0: c_longdouble) c_long;
pub extern fn roundf(arg0: f32) f32;
pub extern fn round(arg0: f64) f64;
pub extern fn roundl(arg0: c_longdouble) c_longdouble;
pub extern fn lroundf(arg0: f32) c_long;
pub extern fn lround(arg0: f64) c_long;
pub extern fn lroundl(arg0: c_longdouble) c_long;
pub extern fn llrintf(arg0: f32) c_longlong;
pub extern fn llrint(arg0: f64) c_longlong;
pub extern fn llrintl(arg0: c_longdouble) c_longlong;
pub extern fn llroundf(arg0: f32) c_longlong;
pub extern fn llround(arg0: f64) c_longlong;
pub extern fn llroundl(arg0: c_longdouble) c_longlong;
pub extern fn truncf(arg0: f32) f32;
pub extern fn trunc(arg0: f64) f64;
pub extern fn truncl(arg0: c_longdouble) c_longdouble;
pub extern fn fmodf(arg0: f32, arg1: f32) f32;
pub extern fn fmod(arg0: f64, arg1: f64) f64;
pub extern fn fmodl(arg0: c_longdouble, arg1: c_longdouble) c_longdouble;
pub extern fn remainderf(arg0: f32, arg1: f32) f32;
pub extern fn remainder(arg0: f64, arg1: f64) f64;
pub extern fn remainderl(arg0: c_longdouble, arg1: c_longdouble) c_longdouble;
pub extern fn remquof(arg0: f32, arg1: f32, arg2: [*c]c_int) f32;
pub extern fn remquo(arg0: f64, arg1: f64, arg2: [*c]c_int) f64;
pub extern fn remquol(arg0: c_longdouble, arg1: c_longdouble, arg2: [*c]c_int) c_longdouble;
pub extern fn copysignf(arg0: f32, arg1: f32) f32;
pub extern fn copysign(arg0: f64, arg1: f64) f64;
pub extern fn copysignl(arg0: c_longdouble, arg1: c_longdouble) c_longdouble;
pub extern fn nanf(arg0: [*c]const u8) f32;
pub extern fn nan(arg0: [*c]const u8) f64;
pub extern fn nanl(arg0: [*c]const u8) c_longdouble;
pub extern fn nextafterf(arg0: f32, arg1: f32) f32;
pub extern fn nextafter(arg0: f64, arg1: f64) f64;
pub extern fn nextafterl(arg0: c_longdouble, arg1: c_longdouble) c_longdouble;
pub extern fn nexttoward(arg0: f64, arg1: c_longdouble) f64;
pub extern fn nexttowardf(arg0: f32, arg1: c_longdouble) f32;
pub extern fn nexttowardl(arg0: c_longdouble, arg1: c_longdouble) c_longdouble;
pub extern fn fdimf(arg0: f32, arg1: f32) f32;
pub extern fn fdim(arg0: f64, arg1: f64) f64;
pub extern fn fdiml(arg0: c_longdouble, arg1: c_longdouble) c_longdouble;
pub extern fn fmaxf(arg0: f32, arg1: f32) f32;
pub extern fn fmax(arg0: f64, arg1: f64) f64;
pub extern fn fmaxl(arg0: c_longdouble, arg1: c_longdouble) c_longdouble;
pub extern fn fminf(arg0: f32, arg1: f32) f32;
pub extern fn fmin(arg0: f64, arg1: f64) f64;
pub extern fn fminl(arg0: c_longdouble, arg1: c_longdouble) c_longdouble;
pub extern fn fmaf(arg0: f32, arg1: f32, arg2: f32) f32;
pub extern fn fma(arg0: f64, arg1: f64, arg2: f64) f64;
pub extern fn fmal(arg0: c_longdouble, arg1: c_longdouble, arg2: c_longdouble) c_longdouble;

pub extern fn j0(arg0: f64) f64;
pub extern fn j1(arg0: f64) f64;
pub extern fn jn(arg0: c_int, arg1: f64) f64;
pub extern fn y0(arg0: f64) f64;
pub extern fn y1(arg0: f64) f64;
pub extern fn yn(arg0: c_int, arg1: f64) f64;
pub extern fn scalb(arg0: f64, arg1: f64) f64;
pub extern var signgam: c_int;
pub extern fn rinttol(arg0: f64) c_long;
pub extern fn roundtol(arg0: f64) c_long;
pub extern fn drem(arg0: f64, arg1: f64) f64;
pub extern fn finite(arg0: f64) c_int;
pub extern fn gamma(arg0: f64) f64;
pub extern fn significand(arg0: f64) f64;

pub const exception = extern struct {
    type: c_int,
    name: [*c]u8,
    arg1: f64,
    arg2: f64,
    retval: f64,
};
pub fn Clamp(value: f32, min: f32, max: f32) f32 {
    const res: f32 = if (value < min) min else value;
    return if (res > max) max else res;
}
pub fn Lerp(start: f32, end: f32, amount: f32) f32 {
    return start + (amount * (end - start));
}
pub fn Vector2Length(v: Vector2) f32 {
    var result: f32 = sqrtf((v.x * v.x) + (v.y * v.y));
    return result;
}
pub fn Vector2DotProduct(v1: Vector2, v2: Vector2) f32 {
    var result: f32 = (v1.x * v2.x) + (v1.y * v2.y);
    return result;
}
pub fn Vector2Distance(v1: Vector2, v2: Vector2) f32 {
    var result: f32 = sqrtf(((v1.x - v2.x) * (v1.x - v2.x)) + ((v1.y - v2.y) * (v1.y - v2.y)));
    return result;
}
pub fn Vector2Normalize(v: Vector2) Vector2 {
    var result: Vector2 = Vector2Divide(v, Vector2Length(v));
    return result;
}
pub fn Vector3Length(v: Vector3) f32 {
    var result: f32 = sqrtf(((v.x * v.x) + (v.y * v.y)) + (v.z * v.z));
    return result;
}
pub fn Vector3DotProduct(v1: Vector3, v2: Vector3) f32 {
    var result: f32 = ((v1.x * v2.x) + (v1.y * v2.y)) + (v1.z * v2.z);
    return result;
}
pub fn Vector3Distance(v1: Vector3, v2: Vector3) f32 {
    var dx: f32 = v2.x - v1.x;
    var dy: f32 = v2.y - v1.y;
    var dz: f32 = v2.z - v1.z;
    var result: f32 = sqrtf(((dx * dx) + (dy * dy)) + (dz * dz));
    return result;
}
pub fn Vector3Normalize(v: Vector3) Vector3 {
    var result: Vector3 = v;
    var length: f32 = undefined;
    var ilength: f32 = undefined;
    length = Vector3Length(v);
    if (length == 0.000000) length = 1.000000;
    ilength = @divTrunc(1.000000, length);
    result.x *= ilength;
    result.y *= ilength;
    result.z *= ilength;
    return result;
}
pub fn Vector3OrthoNormalize(v1: [*c]Vector3, v2: [*c]Vector3) void {
    v1.?.* = Vector3Normalize(v1.?.*);
    var vn: Vector3 = Vector3CrossProduct(v1.?.*, v2.?.*);
    vn = Vector3Normalize(vn);
    v2.?.* = Vector3CrossProduct(vn, v1.?.*);
}
pub fn MatrixTrace(mat: Matrix) f32 {
    var result: f32 = ((mat.m0 + mat.m5) + mat.m10) + mat.m15;
    return result;
}
pub fn MatrixAdd(left: Matrix, right: Matrix) Matrix {
    var result: Matrix = MatrixIdentity();
    result.m0 = (left.m0 + right.m0);
    result.m1 = (left.m1 + right.m1);
    result.m2 = (left.m2 + right.m2);
    result.m3 = (left.m3 + right.m3);
    result.m4 = (left.m4 + right.m4);
    result.m5 = (left.m5 + right.m5);
    result.m6 = (left.m6 + right.m6);
    result.m7 = (left.m7 + right.m7);
    result.m8 = (left.m8 + right.m8);
    result.m9 = (left.m9 + right.m9);
    result.m10 = (left.m10 + right.m10);
    result.m11 = (left.m11 + right.m11);
    result.m12 = (left.m12 + right.m12);
    result.m13 = (left.m13 + right.m13);
    result.m14 = (left.m14 + right.m14);
    result.m15 = (left.m15 + right.m15);
    return result;
}
pub fn MatrixSubtract(left: Matrix, right: Matrix) Matrix {
    var result: Matrix = MatrixIdentity();
    result.m0 = (left.m0 - right.m0);
    result.m1 = (left.m1 - right.m1);
    result.m2 = (left.m2 - right.m2);
    result.m3 = (left.m3 - right.m3);
    result.m4 = (left.m4 - right.m4);
    result.m5 = (left.m5 - right.m5);
    result.m6 = (left.m6 - right.m6);
    result.m7 = (left.m7 - right.m7);
    result.m8 = (left.m8 - right.m8);
    result.m9 = (left.m9 - right.m9);
    result.m10 = (left.m10 - right.m10);
    result.m11 = (left.m11 - right.m11);
    result.m12 = (left.m12 - right.m12);
    result.m13 = (left.m13 - right.m13);
    result.m14 = (left.m14 - right.m14);
    result.m15 = (left.m15 - right.m15);
    return result;
}
pub fn MatrixRotateXYZ(ang: Vector3) Matrix {
    var result: Matrix = MatrixIdentity();
    var cosz: f32 = cosf(-ang.z);
    var sinz: f32 = sinf(-ang.z);
    var cosy: f32 = cosf(-ang.y);
    var siny: f32 = sinf(-ang.y);
    var cosx: f32 = cosf(-ang.x);
    var sinx: f32 = sinf(-ang.x);
    result.m0 = (cosz * cosy);
    result.m4 = (((cosz * siny) * sinx) - (sinz * cosx));
    result.m8 = (((cosz * siny) * cosx) + (sinz * sinx));
    result.m1 = (sinz * cosy);
    result.m5 = (((sinz * siny) * sinx) + (cosz * cosx));
    result.m9 = (((sinz * siny) * cosx) - (cosz * sinx));
    result.m2 = (-siny);
    result.m6 = (cosy * sinx);
    result.m10 = (cosy * cosx);
    return result;
}
pub fn MatrixRotateX(angle: f32) Matrix {
    var result: Matrix = MatrixIdentity();
    var cosres: f32 = cosf(angle);
    var sinres: f32 = sinf(angle);
    result.m5 = cosres;
    result.m6 = (-sinres);
    result.m9 = sinres;
    result.m10 = cosres;
    return result;
}
pub fn MatrixRotateY(angle: f32) Matrix {
    var result: Matrix = MatrixIdentity();
    var cosres: f32 = cosf(angle);
    var sinres: f32 = sinf(angle);
    result.m0 = cosres;
    result.m2 = sinres;
    result.m8 = (-sinres);
    result.m10 = cosres;
    return result;
}
pub fn MatrixRotateZ(angle: f32) Matrix {
    var result: Matrix = MatrixIdentity();
    var cosres: f32 = cosf(angle);
    var sinres: f32 = sinf(angle);
    result.m0 = cosres;
    result.m1 = (-sinres);
    result.m4 = sinres;
    result.m5 = cosres;
    return result;
}
pub fn MatrixPerspective(fovy: f64, aspect: f64, near: f64, far: f64) Matrix {
    var top: f64 = near * tan(fovy * 0.500000);
    var right: f64 = top * aspect;
    var result: Matrix = MatrixFrustum(-right, right, -top, top, near, far);
    return result;
}
pub fn QuaternionNlerp(q1: Quaternion, q2: Quaternion, amount: f32) Quaternion {
    var result: Quaternion = QuaternionLerp(q1, q2, amount);
    result = QuaternionNormalize(result);
    return result;
}

pub const M_PI_2 = 1.570796;
pub const M_1_PI = 0.318310;
pub const M_2_SQRTPI = 1.128379;
pub const M_2_PI = 0.636620;
pub const M_PI_4 = 0.785398;
pub const M_PI = 3.141593;

pub const FP_FAST_FMA = 1;

pub const M_LOG10E = 0.434294;
pub const FP_SUPERNORMAL = 6;
pub const FP_SNAN = FP_NAN;
pub const M_LOG2E = 1.442695;
pub const INFINITY = HUGE_VALF;
pub const M_SQRT1_2 = 0.707107;
pub const SING = 2;
pub const FP_INFINITE = 2;
pub const FP_QNAN = FP_NAN;
pub const PLOSS = 6;
pub const FP_ILOGBNAN = if (@typeId(@typeOf(-1)) == @import("builtin").TypeId.Pointer) @ptrCast(-2147483647, -1) else if (@typeId(@typeOf(-1)) == @import("builtin").TypeId.Int) @intToPtr(-2147483647, -1) else (-2147483647)(-1);
pub const M_LN2 = 0.693147;
pub const MATH_ERRNO = 1;
pub const FP_ZERO = 3;
pub const M_LN10 = 2.302585;
pub const UNDERFLOW = 4;
pub const DOMAIN = 1;
pub const FP_SUBNORMAL = 5;
pub const X_TLOSS = 14148475504056880.000000;
pub const FP_ILOGB0 = if (@typeId(@typeOf(-1)) == @import("builtin").TypeId.Pointer) @ptrCast(-2147483647, -1) else if (@typeId(@typeOf(-1)) == @import("builtin").TypeId.Int) @intToPtr(-2147483647, -1) else (-2147483647)(-1);
pub const MATH_ERREXCEPT = 2;
pub const FP_NAN = 1;
pub const M_SQRT2 = 1.414214;
pub const OVERFLOW = 3;
pub const M_E = 2.718282;
pub const FP_NORMAL = 4;
pub const HUGE = MAXFLOAT;
pub const FP_FAST_FMAF = 1;


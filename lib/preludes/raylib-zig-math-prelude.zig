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

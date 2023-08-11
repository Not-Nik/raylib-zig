#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  PROJECT_NAME='Project'
else
  PROJECT_NAME=$1
fi

mkdir "$PROJECT_NAME" && cd "$PROJECT_NAME" || exit
touch build.zig
echo "generating project files..."
echo 'const std = @import("std");
const rl = @import("raylib-zig/build.zig");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const web_export = target.getOsTag() == .emscripten;
    const optimize = b.standardOptimizeOption(.{});
    if (!web_export) {
        var raylib = rl.getModule(b, "raylib-zig");
        var raylib_math = rl.math.getModule(b, "raylib-zig");

        const exe = b.addExecutable(.{ .name = "'$PROJECT_NAME'", .root_source_file = .{ .path = "src/main.zig" }, .optimize = optimize, .target = target });

        rl.link(b, exe, target, optimize);
        exe.addModule("raylib", raylib);
        exe.addModule("raylib-math", raylib_math);

        const run_cmd = b.addRunArtifact(exe);
        const run_step = b.step("run", "Run '$PROJECT_NAME'");
        run_step.dependOn(&run_cmd.step);

        b.installArtifact(exe);
    }

    //web exports are completely separate, due to the amount of hackery required.
    if (web_export) {
        b.getInstallStep().dependOn(try rl.webExport(b, "src/main.zig", "raylib-zig", optimize));
    }
}
' >> build.zig

mkdir src
cp ../examples/core/basic_window.zig src/main.zig
cp ../build.zig.zon .
echo "cloning raylib-zig inside of project..."
git clone ../ raylib-zig --recursive

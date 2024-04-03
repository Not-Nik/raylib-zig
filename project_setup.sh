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
const emcc = @import("emcc.zig");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    
    const raylib_dep = b.dependency("raylib-zig", .{
        .target = target,
        .optimize = optimize,
    });

    const raylib = raylib_dep.module("raylib");
    const raylib_math = raylib_dep.module("raylib-math");
    const raylib_artifact = raylib_dep.artifact("raylib");

    //web exports are completely separate
    if (target.getOsTag() == .emscripten) {
        const exe_lib = emcc.compileForEmscripten(b, "'$PROJECT_NAME'", "src/main.zig", target, optimize);

        exe_lib.linkLibrary(raylib_artifact);
        exe_lib.addModule("raylib", raylib);
        exe_lib.addModule("raylib-math", raylib_math);

        // Note that raylib itself is not actually added to the exe_lib output file, so it also needs to be linked with emscripten.
        const link_step = try emcc.linkWithEmscripten(b, &[_]*std.Build.Step.Compile{ exe_lib, raylib_artifact });

        b.getInstallStep().dependOn(&link_step.step);
        const run_step = try emcc.emscriptenRunStep(b);
        run_step.step.dependOn(&link_step.step);
        const run_option = b.step("run", "Run '$PROJECT_NAME'");
        run_option.dependOn(&run_step.step);
        return;
    }

    const exe = b.addExecutable(.{ .name = "'$PROJECT_NAME'", .root_source_file = .{ .path = "src/main.zig" }, .optimize = optimize, .target = target });

    exe.linkLibrary(raylib_artifact);
    exe.addModule("raylib", raylib);
    exe.addModule("raylib-math", raylib_math);

    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run '$PROJECT_NAME'");
    run_step.dependOn(&run_cmd.step);

    b.installArtifact(exe);
}
' >> build.zig

echo '.{
    .name = "'$PROJECT_NAME'",
    .version = "0.0.1",
    .dependencies = .{
        .@"raylib-zig" = .{
            .url = "https://github.com/Not-Nik/raylib-zig/archive/d002b702c8fb2c1c7fd4508addae50ffe27620cd.tar.gz",
            .hash = "1220d18ffceb49556360746f7f269ebb280f2d9b0f36f6d22e282426477f27056889",
        },
    },
    .paths = .{""},
}

' >> build.zig.zon

cp ../emcc.zig .

mkdir src
cp ../examples/core/basic_window.zig src/main.zig

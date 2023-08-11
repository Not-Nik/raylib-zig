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
    const web_export = argsContainsWebexport(b.allocator);
    if (!web_export) {
        const target = b.standardTargetOptions(.{});
        const optimize = b.standardOptimizeOption(.{});

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
    const export_step = b.step("webexport", "Export '$PROJECT_NAME' for the web");
    if (web_export) {
        export_step.dependOn(try rl.webExport(b, "src/main.zig", "raylib-zig"));
    }

    // Building for web requires a --sysroot [emscripten and stuff]
    // But asking for that for all builds is not a good user experience
    // So it will only actually set up the build scripts if the web export is actually going to happen.
}

fn argsContainsWebexport(allocator: std.mem.Allocator) bool {
    const args = std.process.argsAlloc(allocator) catch {
        return false;
    };
    defer allocator.free(args);
    for (args) |arg| {
        if (std.mem.eql(u8, "webexport", arg)) {
            return true;
        }
    }
    return false;
}
' >> build.zig

mkdir src
cp ../examples/core/basic_window.zig src/main.zig
cp ../build.zig.zon .
echo "cloning raylib-zig inside of project..."
git clone ../ raylib-zig --recursive

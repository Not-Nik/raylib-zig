if [ "$#" -ne 1 ]; then
  PROJECT_NAME='Project'
else
  PROJECT_NAME=$1
fi

mkdir "$PROJECT_NAME" && cd "$PROJECT_NAME" || exit
touch build.zig

echo 'const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("'"$PROJECT_NAME"'", "src/main.zig");
    exe.setBuildMode(mode);
    exe.linkSystemLibrary("raylib");
    exe.addCSourceFile("raylib-zig/workaround.c", &[_][]const u8{});
    exe.addPackagePath("raylib", "raylib-zig/raylib-zig.zig");
    exe.addPackagePath("raylib-math", "lib/raylib-zig-math.zig");

    const runExe = exe.run();
    const exeStep = b.step("run", "Runs the app");
    exeStep.dependOn(&runExe.step);
}
' >> build.zig

mkdir src
mkdir raylib-zig
cp ../lib/** raylib-zig
cp ../examples/core/basic_window.zig src
mv src/basic_window.zig src/main.zig
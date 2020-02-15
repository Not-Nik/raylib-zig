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
    exe.addPackagePath("raylib", "raylib-zig/raylib-zig.zig");
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
' >> build.zig

mkdir src
mkdir raylib-zig
cp ../lib/* raylib-zig
cp ../examples/core/basic_window.zig src
mv src/basic_window.zig src/main.zig
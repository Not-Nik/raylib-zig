const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;

pub fn Pkg(pkgdir: comptime []const u8) type {
    return struct {
        pub fn link(exe: *LibExeObjStep) void {
            const raylibFlags = &[_][]const u8{
                "-std=c99",
                "-DPLATFORM_DESKTOP",
                "-D_POSIX_C_SOURCE",
            };
            if (exe.target.toTarget().os.tag == .windows) {
                exe.linkSystemLibrary("winmm");
                exe.linkSystemLibrary("gdi32");
            } else {
                exe.linkSystemLibrary("m");
                exe.linkSystemLibrary("X11");
            }
            exe.linkLibC();

            exe.addSystemIncludeDir(pkgdir ++ "/raylib/src");
            exe.addSystemIncludeDir(pkgdir ++ "/raylib/src/external/glfw/include");
            exe.addCSourceFile(pkgdir ++ "/raylib/src/core.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/models.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/raudio.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/rglfw.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/shapes.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/text.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/textures.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/utils.c", raylibFlags);
        }
        pub fn addAsPackage(name: comptime []const u8, to: *LibExeObjStep) void {
            to.addPackagePath(name, pkgdir ++ "/lib/raylib-zig.zig");
        }
        pub const math = struct {
            pub fn addAsPackage(name: comptime []const u8, to: *LibExeObjStep) void {
                to.addPackagePath(name, pkgdir ++ "/lib/raylib-zig-math.zig");
            }
        };
    };
}

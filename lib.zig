const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;

pub fn Pkg(pkgdir: comptime []const u8) type {
    return struct {
        pub fn link(exe: *LibExeObjStep, system_lib: bool) void {
            const raylibFlags = &[_][]const u8{
                "-std=c99",
                "-DPLATFORM_DESKTOP",
                "-D_POSIX_C_SOURCE",
            };

            switch (exe.target.toTarget().os.tag) {
                .windows => {
                    exe.linkSystemLibrary("winmm");
                    exe.linkSystemLibrary("gdi32");
                    exe.linkSystemLibrary("opengl32");
                },
                .macosx => {
                    exe.linkFramework("OpenGL");
                    exe.linkFramework("Cocoa");
                    exe.linkFramework("IOKit");
                    exe.linkFramework("CoreAudio");
                    exe.linkFramework("CoreVideo");
                },
                .freebsd, .netbsd, .dragonfly => {
                    exe.linkSystemLibrary("GL");
                    exe.linkSystemLibrary("rt");
                    exe.linkSystemLibrary("dl");
                    exe.linkSystemLibrary("m");
                    exe.linkSystemLibrary("X11");
                    exe.linkSystemLibrary("Xrandr");
                    exe.linkSystemLibrary("Xinerama");
                    exe.linkSystemLibrary("Xi");
                    exe.linkSystemLibrary("Xxf86vm");
                    exe.linkSystemLibrary("Xcursor");
                },
                else => { // linux and possibly others
                    exe.linkSystemLibrary("GL");
                    exe.linkSystemLibrary("rt");
                    exe.linkSystemLibrary("dl");
                    exe.linkSystemLibrary("m");
                    exe.linkSystemLibrary("X11");
                },
            }
            exe.linkLibC();

            if (system_lib) {
                exe.linkSystemLibrary("raylib");
                return;
            }

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

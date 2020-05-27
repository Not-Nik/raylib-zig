const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;

pub fn Pkg(pkgdir: comptime []const u8) type {
    return struct {
        var ran_git = false;
        pub fn link(exe: *LibExeObjStep, system_lib: bool) void {
            const raylibFlags = &[_][]const u8{
                "-std=c99",
                "-DPLATFORM_DESKTOP",
                "-D_POSIX_C_SOURCE",
                "-DGL_SILENCE_DEPRECATION"
            };
            const target_os = exe.target.toTarget().os.tag;
            switch (target_os) {
                .windows => {
                    exe.linkSystemLibrary("winmm");
                    exe.linkSystemLibrary("gdi32");
                    exe.linkSystemLibrary("opengl32");
                },
                .macosx => {
                    var buffer: [100]u8 = undefined;

                    const frameworkDir = std.fmt.bufPrint(buffer[0..], "/Library/Developer/CommandLineTools/SDKs/MACOSX{}.{}.sdk/System/Library/Frameworks", .{
                        exe.target.toTarget().os.version_range.semver.max.major,
                        exe.target.toTarget().os.version_range.semver.max.minor,
                    }) catch unreachable;

                    exe.addFrameworkDir(frameworkDir);
                    exe.linkSystemLibrary("glfw");
                    exe.linkFramework("OpenGL");
                    exe.linkFramework("Cocoa");
                    exe.linkFramework("IOKit");
                    exe.linkFramework("CoreAudio");
                    exe.linkFramework("CoreVideo");
                },
                .freebsd, .openbsd, .netbsd, .dragonfly => {
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

            fetchSubmodules(exe.builder) catch
                std.debug.warn(
                \\Warning:
                \\Unable to fetch git submodule(s) Assuming package folder is not under
                \\version control. If build fails, this is probably why.
            , .{});

            exe.addIncludeDir(pkgdir ++ "/raylib/src");
            exe.addIncludeDir(pkgdir ++ "/raylib/src/external/glfw/include");
            exe.addIncludeDir(pkgdir ++ "/raylib/src/external/glfw/deps/mingw");
            exe.addCSourceFile(pkgdir ++ "/raylib/src/core.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/models.c", raylibFlags);
            if (target_os != .macosx)
                exe.addCSourceFile(pkgdir ++ "/raylib/src/rglfw.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/raudio.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/shapes.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/text.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/textures.c", raylibFlags);
            exe.addCSourceFile(pkgdir ++ "/raylib/src/utils.c", raylibFlags);
        }

        fn fetchSubmodules(b: *Builder) !void {
            if (ran_git) return;
            ran_git = true;

            std.debug.warn("attempting to fetch submodule(s)...\n", .{});

            const git_proc = std.ChildProcess.init(
                &[_][]const u8{ "git", "submodule", "update", "--init" },
                b.allocator,
            ) catch {
                std.debug.warn("unable to create child process for git. build interrupted\n", .{});
                std.os.exit(1);
            };
            git_proc.cwd = pkgdir;
            const term = git_proc.spawnAndWait() catch {
                std.debug.warn("unable to spawn child process for git. build interrupted\n", .{});
                std.os.exit(1);
            };

            switch (term) {
                .Exited => |code| if (code != 0) return error.GitFail,
                else => {
                    std.debug.warn("git terminated unexpectedly. build interrupted\n", .{});
                    std.os.exit(1);
                },
            }
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

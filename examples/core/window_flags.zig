//! # raylib-zig [core] example - window flags
//!
//! Example originally created with raylib-zig 5.0, last time updated with
//! raylib-zig 5.0
//!
//! Example licensed under an unmodified zlib/libpng license, which is an
//! OSI-certified, BSD-like license that allows static linking with closed
//! source software
//!
//! Copyright (c) Nikolas Wipper 2024

const rl = @import("raylib");
const rlm = @import("raylib-math");

const screen_width = 800;
const screen_height = 450;

pub fn main() anyerror!void {
    // Initialization
    // -------------------------------------------------------------------------

    // Possible window flags
    // flag_vsync_hint
    // flag_fullscreen_mode    -> not working properly -> wrong scaling!
    // flag_window_resizable
    // flag_window_undecorated
    // flag_window_transparent
    // flag_window_hidden
    // flag_window_minimized   -> Not supported on window creation
    // flag_window_maximized   -> Not supported on window creation
    // flag_window_unfocused
    // flag_window_topmost
    // flag_window_highdpi     -> errors after minimize-resize, fb size is recalculated
    // flag_window_always_run
    // flag_msaa_4x_hint

    // Set configuration flags for window creation
    // rl.setConfigFlags(
    //     @enumFromInt(@intFromEnum(rl.ConfigFlags.flag_vsync_hint) | @intFromEnum(rl.ConfigFlags.flag_msaa_4x_hint) | @intFromEnum(rl.ConfigFlags.flag_window_highdpi)),
    // );
    rl.initWindow(
        screen_width,
        screen_height,
        "raylib-zig [core] example - window flags",
    );
    defer rl.closeWindow(); // Close window and OpenGL context

    var ball_position = rl.Vector2.init(
        @floatFromInt(@divFloor(rl.getScreenWidth(), 2)),
        @floatFromInt(@divFloor(rl.getScreenHeight(), 2)),
    );
    var ball_speed = rl.Vector2.init(5, 4);
    const ball_radius: f32 = 20;

    var frames_counter: i32 = 0;

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second

    while (!rl.windowShouldClose()) {
        // Update
        // ---------------------------------------------------------------------
        if (rl.isKeyPressed(.key_f)) rl.toggleFullscreen(); // Modifies window size when scaling!

        if (rl.isKeyPressed(.key_r)) {
            if (rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_resizable))) {
                rl.clearWindowState(.flag_window_resizable);
            } else {
                rl.setWindowState(.flag_window_resizable);
            }
        }

        if (rl.isKeyPressed(.key_d)) {
            if (rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_undecorated))) {
                rl.clearWindowState(.flag_window_undecorated);
            } else {
                rl.setWindowState(.flag_window_undecorated);
            }
        }

        if (rl.isKeyPressed(.key_h)) {
            if (!rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_hidden))) {
                rl.setWindowState(.flag_window_hidden);
            }
            frames_counter = 0;
        }

        if (rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_hidden))) {
            frames_counter += 1;
            if (frames_counter >= 240) rl.clearWindowState(.flag_window_hidden); // Show window after 3 seconds
        }

        if (rl.isKeyPressed(.key_n)) {
            if (!rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_minimized))) {
                rl.minimizeWindow();
            }
            frames_counter = 0;
        }

        if (rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_minimized))) {
            frames_counter += 1;
            if (frames_counter >= 240) rl.restoreWindow(); // Restore window after 3 seconds
        }

        if (rl.isKeyPressed(.key_m)) {
            // NOTE: Requires `flag_window_resizable` enabled!
            if (rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_maximized))) {
                rl.restoreWindow();
            } else rl.maximizeWindow();
        }

        if (rl.isKeyPressed(.key_u)) {
            if (rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_unfocused))) {
                rl.clearWindowState(.flag_window_unfocused);
            } else rl.setWindowState(.flag_window_unfocused);
        }

        if (rl.isKeyPressed(.key_t)) {
            if (rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_topmost))) {
                rl.clearWindowState(.flag_window_topmost);
            } else rl.setWindowState(.flag_window_topmost);
        }

        if (rl.isKeyPressed(.key_a)) {
            if (rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_always_run))) {
                rl.clearWindowState(.flag_window_always_run);
            } else rl.setWindowState(.flag_window_always_run);
        }

        if (rl.isKeyPressed(.key_v)) {
            if (rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_vsync_hint))) {
                rl.clearWindowState(.flag_vsync_hint);
            } else rl.setWindowState(.flag_vsync_hint);
        }

        // Bouncing ball logic
        ball_position = rlm.vector2Add(ball_position, ball_speed);

        if (ball_position.x >= (@as(f32, @floatFromInt(rl.getScreenWidth())) - ball_radius) or ball_position.x <= ball_radius) {
            ball_speed.x *= -1;
        }
        if (ball_position.y >= (@as(f32, @floatFromInt(rl.getScreenHeight())) - ball_radius) or ball_position.y <= ball_radius) {
            ball_speed.y *= -1;
        }
        // ---------------------------------------------------------------------

        // Draw
        // ---------------------------------------------------------------------
        {
            rl.beginDrawing();
            defer rl.endDrawing();

            if (rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_transparent))) {
                rl.clearBackground(rl.Color.blank);
            } else rl.clearBackground(rl.Color.ray_white);

            rl.drawCircleV(ball_position, ball_radius, rl.Color.maroon);
            rl.drawRectangleLinesEx(
                rl.Rectangle.init(0, 0, @floatFromInt(rl.getScreenWidth()), @floatFromInt(rl.getScreenHeight())),
                4,
                rl.Color.ray_white,
            );

            rl.drawCircleV(rl.getMousePosition(), 10, rl.Color.dark_blue);

            rl.drawFPS(10, 10);

            rl.drawText(
                rl.textFormat("Screen Size: [%i, %i]", .{ rl.getScreenWidth(), rl.getScreenHeight() }),
                10,
                40,
                10,
                rl.Color.green,
            );

            // Draw window state info
            rl.drawText(
                "Following flags can be set after window creation:",
                10,
                60,
                10,
                rl.Color.gray,
            );
            rl.drawText(
                rl.textFormat("[F] flag_fullscreen_mode: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_fullscreen_mode)))),
                }),
                10,
                80,
                10,
                rl.Color.lime,
            );
            rl.drawText(
                rl.textFormat("[R] flag_window_resizable: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_resizable)))),
                }),
                10,
                100,
                10,
                rl.Color.lime,
            );
            rl.drawText(
                rl.textFormat("[D] flag_window_undecorated: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_undecorated)))),
                }),
                10,
                120,
                10,
                rl.Color.lime,
            );
            rl.drawText(
                rl.textFormat("[H] flag_window_hidden: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_hidden)))),
                }),
                10,
                140,
                10,
                rl.Color.lime,
            );
            rl.drawText(
                rl.textFormat("[N] flag_window_minimized: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_minimized)))),
                }),
                10,
                160,
                10,
                rl.Color.lime,
            );
            rl.drawText(
                rl.textFormat("[M] flag_window_maximized: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_maximized)))),
                }),
                10,
                180,
                10,
                rl.Color.lime,
            );
            rl.drawText(
                rl.textFormat("[U] flag_window_unfocused: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_unfocused)))),
                }),
                10,
                200,
                10,
                rl.Color.lime,
            );
            rl.drawText(
                rl.textFormat("[T] flag_window_topmost: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_topmost)))),
                }),
                10,
                220,
                10,
                rl.Color.lime,
            );
            rl.drawText(
                rl.textFormat("[A] flag_window_always_run: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_always_run)))),
                }),
                10,
                240,
                10,
                rl.Color.lime,
            );
            rl.drawText(
                rl.textFormat("[V] flag_vsync_hint: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_vsync_hint)))),
                }),
                10,
                260,
                10,
                rl.Color.lime,
            );

            rl.drawText(
                "Following flags can only be set before window creation:",
                10,
                300,
                10,
                rl.Color.gray,
            );
            rl.drawText(
                rl.textFormat("flag_window_highdpi: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_highdpi)))),
                }),
                10,
                320,
                10,
                rl.Color.lime,
            );
            rl.drawText(
                rl.textFormat("flag_window_transparent: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_window_transparent)))),
                }),
                10,
                340,
                10,
                rl.Color.lime,
            );
            rl.drawText(
                rl.textFormat("flag_msaa_4x_hint: %d", .{
                    @as(i32, @intFromBool(rl.isWindowState(@intFromEnum(rl.ConfigFlags.flag_msaa_4x_hint)))),
                }),
                10,
                360,
                10,
                rl.Color.lime,
            );
        }
        // ---------------------------------------------------------------------
    }
}

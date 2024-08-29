const std = @import("std");
const emscripten = std.os.emscripten;
const builtin = @import("builtin");

const rl = @import("raylib");

const Settings = struct {
    screen_width: i32 = 800,
    screen_height: i32 = 450,
    fps: i32 = 120,
    title: [:0]const u8 = "Hello World!",
};

const Assets = struct {
    sound: *rl.Sound,
    texture: *rl.Texture,
};

const Game = struct {
    settings: *Settings,
    assets: *Assets,
};

pub fn updateDrawFrameNative(game_ptr: *Game) void {
    rl.beginDrawing();
    defer rl.endDrawing();

    rl.clearBackground(rl.Color.white);

    // UPDATE
    if (rl.isKeyPressed(rl.KeyboardKey.key_p)) {
        rl.playSound(game_ptr.assets.sound.*);
    }

    const screen_width = rl.getScreenWidth();
    const screen_height = rl.getScreenHeight();

    // DRAW
    const texture_half_width = @divFloor(game_ptr.assets.texture.width, 2);
    const texture_half_height = @divFloor(game_ptr.assets.texture.height, 2);
    rl.drawTexture(
        game_ptr.assets.texture.*,
        @divFloor(screen_width, 2) - texture_half_width,
        @divFloor(screen_height, 2) - texture_half_height,
        rl.Color.violet,
    );

    {
        const hello_text: [:0]const u8 = game_ptr.settings.title;
        const text_measure: i32 = rl.measureText(hello_text, 20);
        const text_half_width: i32 = @divFloor(text_measure, 2);
        rl.drawText(
            hello_text,
            @divFloor(screen_width, 2) - text_half_width,
            @divFloor(screen_height, 2),
            20,
            rl.Color.light_gray,
        );
    }

    {
        var buffer: [32]u8 = undefined;
        const buf = buffer[0..];
        const fps_text = std.fmt.bufPrintZ(
            buf,
            "FPS: {d}/{d}",
            .{ rl.getFPS(), game_ptr.settings.fps },
        ) catch {
            std.log.debug("can't show fps because of error!", .{});
            return;
        };
        const text_measure: i32 = rl.measureText(fps_text, 20);
        const text_half_width: i32 = @divFloor(text_measure, 2);
        rl.drawText(
            fps_text,
            @divFloor(screen_width, 2) - text_half_width,
            @divFloor(screen_height, 2) + 50,
            20,
            rl.Color.red,
        );
    }
}

pub fn updateDrawFrameWeb(arg: ?*anyopaque) callconv(.C) void {
    const game_ptr: *Game = @ptrCast(@alignCast(arg));
    updateDrawFrameNative(game_ptr);
}

pub fn main() !void {
    var settings: Settings = .{};

    rl.initWindow(
        settings.screen_width,
        settings.screen_height,
        settings.title,
    );
    defer rl.closeWindow();

    rl.initAudioDevice();
    defer rl.closeAudioDevice();

    // load settings and assets
    var sound = rl.loadSound("resources/sounds/jump/powerUp.wav");
    defer rl.unloadSound(sound);
    var texture = rl.loadTexture("resources/textures/scarfy.png");
    defer rl.unloadTexture(texture);

    var assets: Assets = .{
        .texture = &texture,
        .sound = &sound,
    };

    var game: Game = .{
        .settings = &settings,
        .assets = &assets,
    };

    switch (builtin.os.tag) {
        .emscripten => {
            emscripten.emscripten_set_main_loop_arg(
                &updateDrawFrameWeb,
                &game,
                settings.fps,
                1,
            );
        },
        else => {
            rl.setTargetFPS(settings.fps);
            while (!rl.windowShouldClose()) updateDrawFrameNative(&game);
        },
    }
}

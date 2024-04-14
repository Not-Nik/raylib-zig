//! # raylib-zig [core] examples - basic screen manager
//!
//! NOTE: This example illustrates a very simple screen manager based on a
//! states machines
//!
//! Example originally created with raylib-zig 5.0, last time updated with
//! raylib-zig 5.0
//!
//! Copyright (c) Nikolas Wipper 2024

const rl = @import("raylib");

const screen_width = 800;
const screen_height = 450;

/// Valid game states used in the state machine
const GameScreen = enum {
    logo,
    title,
    gameplay,
    ending,
};

pub fn main() anyerror!void {
    // Initialization
    // -------------------------------------------------------------------------
    rl.initWindow(
        screen_width,
        screen_height,
        "raylib-zig [core] example - basic screen height",
    );
    defer rl.closeWindow(); // Close window and OpenGL context

    // TODO: Initialize all required variables and load all required data here!

    var current_screen: GameScreen = .logo;

    var frames_counter: i32 = 0; // Useful to count frames

    rl.setTargetFPS(60); // Set desired framerate

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        // ---------------------------------------------------------------------
        switch (current_screen) {
            .logo => {
                // TODO: Update `logo` state variables here!

                frames_counter += 1; // Count frames

                // Wait for 2 seconds (120 frames) before jumping to `title` screen
                if (frames_counter > 120) current_screen = .title;
            },
            .title => {
                // TODO: Update `title` state variables here!

                // Press ENTER to change to `gameplay` state
                if (rl.isKeyPressed(.key_enter) or rl.isGestureDetected(.gesture_tap)) {
                    current_screen = .gameplay;
                }
            },
            .gameplay => {
                // TODO: Update `gameplay` state variables here!

                // Press ENTER to change to `ending` state
                if (rl.isKeyPressed(.key_enter) or rl.isGestureDetected(.gesture_tap)) {
                    current_screen = .ending;
                }
            },
            .ending => {
                // TODO: Update `ending` state variables here!

                // Press ENTER to return to `title` state
                if (rl.isKeyPressed(.key_enter) or rl.isGestureDetected(.gesture_tap)) {
                    current_screen = .title;
                }
            },
        }
        // ---------------------------------------------------------------------

        // Draw
        // ---------------------------------------------------------------------
        {
            rl.beginDrawing();
            defer rl.endDrawing();

            rl.clearBackground(rl.Color.ray_white);

            switch (current_screen) {
                .logo => {
                    // TODO: Draw `logo` state here!
                    rl.drawText("LOGO SCREEN", 20, 20, 40, rl.Color.light_gray);
                    rl.drawText(
                        "WAIT for 2 SECONDS...",
                        290,
                        220,
                        20,
                        rl.Color.gray,
                    );
                },
                .title => {
                    // TODO: Draw `title` state here!
                    rl.drawRectangle(
                        0,
                        0,
                        screen_width,
                        screen_height,
                        rl.Color.green,
                    );
                    rl.drawText(
                        "TITLE SCREEN",
                        20,
                        20,
                        40,
                        rl.Color.dark_green,
                    );
                    rl.drawText(
                        "PRESS ENTER or TAP to JUMP to GAMEPLAY SCREEN",
                        120,
                        220,
                        20,
                        rl.Color.dark_green,
                    );
                },
                .gameplay => {
                    // TODO: Draw `gameplay` state here!
                    rl.drawRectangle(
                        0,
                        0,
                        screen_width,
                        screen_height,
                        rl.Color.purple,
                    );
                    rl.drawText("GAMEPLAY SCREEN", 20, 20, 40, rl.Color.maroon);
                    rl.drawText(
                        "PRESS ENTER or TAP to JUMP to ENDING SCREEN",
                        130,
                        220,
                        20,
                        rl.Color.maroon,
                    );
                },
                .ending => {
                    // TODO: Draw `ending` state here!
                    rl.drawRectangle(
                        0,
                        0,
                        screen_width,
                        screen_height,
                        rl.Color.blue,
                    );
                    rl.drawText(
                        "ENDING SCREEN",
                        20,
                        20,
                        40,
                        rl.Color.dark_blue,
                    );
                    rl.drawText(
                        "PRESS ENTER or TAP to RETURN to TITLE SCREEN",
                        120,
                        220,
                        20,
                        rl.Color.dark_blue,
                    );
                },
            }
        }
        // ---------------------------------------------------------------------
    }
}

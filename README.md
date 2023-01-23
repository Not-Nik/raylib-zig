![logo](https://github.com/Not-Nik/raylib-zig/raw/devel/logo/logo.png)

# raylib-zig

Manually tweaked, auto generated [raylib](https://github.com/raysan5/raylib) bindings for zig.

Bindings tested on raylib version 4.5.0-dev and Zig 0.10.1

Thanks to @jessrud, @mbcrocci, @franciscod, @AlxHnr, @Gertkeno, @Ivan-Velickovic, @alanoliveira, @rcorre and @sacredbirdman for their contributions to this binding.

The binding currently only supports a subset of raylib. For more information read [here](#technical-restrictions).

## Example

We can copy the default example with some minor changes:

```zig
const rl = @import("raylib");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.InitWindow(screenWidth, screenHeight, "MyWindow");

    rl.SetTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.WindowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();

        rl.ClearBackground(rl.WHITE);

        rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.LIGHTGRAY);

        rl.EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.CloseWindow(); // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}
```

## Technical restrictions

Due to zig being a relatively new language it does [not have full C ABI support](https://github.com/ziglang/zig/issues/1481) at the moment. For use that mainly means we can't use any functions that return structs that are less than 16 bytes large.

## Building the examples

To build all available examples simply `zig build examples`. To list available examples run `zig build --help`. If you want to run an example, say `basic_window` run `zig build basic_window`

## Building and using

+ (Optional) Install raylib
+ Execute `project_setup.sh project_name`, this will create a folder with the name specified
+ You can copy that folder anywhere you want and edit the source
+ Run `zig build run` at any time to test your project

### When is the binding updated?

I plan on updating it every mayor release (2.5, 3.0, etc.). Keep in mind these are technically header files, so any implementation stuff should be updatable with some hacks on your side.

### What's to be done?

+ _(Done)_ Set up a proper package build and a build script for the examples
+ Port all the examples
+ Object orientation

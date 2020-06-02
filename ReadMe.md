<img align="left" src="https://github.com/Not-Nik/raylib-zig/blob/master/logo.png" width=256>

# raylib-zig
Manually tweaked, auto generated [raylib](https://github.com/raysan5/raylib) bindings for zig.<br>
Bindings tested on raylib version 3.0

## Example
We can copy the default example with some minor changes:
```zig
usingnamespace @import("raylib");

pub fn main() anyerror!void
{
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "MyWindow");

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(WHITE);

            DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}
```

## Technical restrictions
Due to zig being a relatively new language it does [not have full C ABI support](https://github.com/ziglang/zig/issues/1481) at the moment. For use that mainly means we can't use any functions that return structs that are less than 16 bytes large.
Here is an incomplete list of some functions affected by this:
+ DrawCircleV
+ DrawRectangleRec
+ DrawModel and all its variations

Parts of these issue are resolved on the [workaround branch](https://github.com/Not-Nik/raylib-zig/tree/workaround)

## Building the examples
To build all available examples simply `zig build examples`. To list available examples run `zig build --help`. If you want to run and examples, say `basic_window` run `zig build basic_window`

## Building and using
 + Install raylib
 + Execute `projectSetup.sh project_name`, this will create a folder with the name specified
 + You can copy that folder anywhere you want and edit the source
 + Run `zig build run` at any time to test your project

### When is the binding updated?
I plan on updating it every mayor release (2.5, 3.0, etc.). Keep in mind these are technically header files, so any implementation stuff should be updatable with some hacks on your side.

### What's to be done?
 + _(Done)_ Set up a proper package build and a build script for the examples
 + Port all the examples
 + Object orientation

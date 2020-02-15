# raylib-zig
Manually tweaked, auto generated [raylib](https://github.com/raysan5/raylib) bindings for zig.

## Example
Basically we can copy the default example with some minor changes:
```zig
usingnamespace @import("rayzig.zig"); // Import WIP

pub fn main() anyerror!void
{
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    InitWindow(screenWidth, screenHeight, c"Rayzig test");

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(WHITE);

            DrawText(c"Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}
```

## Building the examples
Don't. At the moment im still trying to figure out how to turn the binding into a proper zig package and until then I can't build the examples without destroying the project setup.
The `basic_window` example is the default source file for project setup though

## Building and using
 + Install raylib
 + Execute `projectSetup.sh project_name`, this will create a folder with the name specified
 + You can copy that folder anywhere you want and edit the source
 + Run `zig build run` at any time to test your project

### When is the binding updated?
I plan on updating it every mayor release (2.5, 3.0, etc.). Keep in mind these are basically header files, so any implementation stuff should be updatable with some hacks on your side.

### What's to be done?
 + Set up a proper package build and a build script for the examples
 + Port all the examples

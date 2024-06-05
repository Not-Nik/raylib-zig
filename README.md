![logo](https://github.com/Not-Nik/raylib-zig/raw/devel/logo/logo.png)

# raylib-zig

Manually tweaked, auto-generated [raylib](https://github.com/raysan5/raylib) bindings for zig.

Bindings tested on raylib version 5.1-dev and Zig 0.12.0

Thanks to all the [contributors](https://github.com/Not-Nik/raylib-zig/graphs/contributors) for their help with this binding.

## Example

```zig
const rl = @import("raylib");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);

        rl.drawText("Congrats! You created your first window!", 190, 200, 20, rl.Color.light_gray);
        //----------------------------------------------------------------------------------
    }
}
```

## Building the examples

To build all available examples simply `zig build examples`. To list available examples run `zig build --help`. If you want to run an example, say `basic_window` run `zig build basic_window`

## Building and using

### Using raylib-zig's template

* Execute `project_setup.sh project_name`, this will create a folder with the name specified
* You can copy that folder anywhere you want and edit the source
* Run `zig build run` at any time to test your project

### In an existing project (e.g. created with `zig init-exe`)

Create a `build.zig.zon` and add raylib-zig as a dependency like so:

```
.{
    // ...
    .dependencies = .{
        .@"raylib-zig" = .{
            .url = "https://github.com/Not-Nik/raylib-zig/archive/devel.tar.gz",
            .hash = "12000000000000000000000000000000000000000000000000000000000000000000", // put the actual hash here
        },
    },
    // ...
}
```

Then add raylib-zig as a dependency and import it's modules and artifact in your `build.zig`:

```zig
const raylib_dep = b.dependency("raylib-zig", .{
    .target = target,
    .optimize = optimize,
});

const raylib = raylib_dep.module("raylib"); // main raylib module
const raygui = raylib_dep.module("raygui"); // raygui module
const raylib_artifact = raylib_dep.artifact("raylib"); // raylib C library
```

Now add the modules and artifact to your target as you would normally:

```zig
exe.linkLibrary(raylib_artifact);
exe.root_module.addImport("raylib", raylib);
exe.root_module.addImport("raygui", raygui);
```

If you additionally want to support Web as a platform with emscripten, you will need to use `emcc.zig` by importing raylib-zig's build script with `const rlz = @import("raylib-zig");` and then accessing its functions with `rlz.emcc`. Refer to raylib-zig's project template on how to use them.

## Exporting for web
To export your project for the web, first install emsdk.
Once emsdk is installed, set it up by running

`emsdk install latest`

Find the folder where it's installed and run

`zig build -Dtarget=wasm32-emscripten --sysroot [path to emsdk]/upstream/emscripten`

once that is finished, the exported project should be located at `zig-out/htmlout`

### When is the binding updated?

I plan on updating it every mayor release (2.5, 3.0, etc.). Keep in mind these are technically header files, so any implementation stuff should be updatable with some hacks on your side.

### What needs to be done?

+ _(Done)_ Set up a proper package build and a build script for the examples
+ Port all the examples
+ Member functions/initialisers

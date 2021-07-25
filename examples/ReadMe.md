# Examples

Making raylib bindings in zig is pretty straight forward since zig has a built-in c parser, so I am now on a quest to port all the examples.

### category: core

Examples using raylib core platform functionality like window creation, inputs, drawing modes and system functionality.

| ## | example  | developer  |
|----|----------|:----------:|
| 01 | [core_basic_window](core/basic_window.zig) | ray
| 02 | [core_input_keys](core/input_keys.zig) | ray
| 04 | [core_input_mouse_wheel](core/input_mouse_wheel.zig) | ray
| 06 | [core_input_multitouch](core/input_multitouch.zig) | [Berni](https://github.com/Berni8k)
| 08 | [core_2d_camera](core/2d_camera.zig) | ray

### category: models

Examples using raylib models functionality, including models loading/generation and drawing, provided by raylib models module.

| ## | example  | developer  |
|----|----------|:----------:|
| 74 | [models_loading](models/models_loading.zig) | ray

### category: shaders

Examples using raylib shaders functionality, including shaders loading, parameters configuration and drawing using them (model shaders and postprocessing shaders). This
functionality is directly provided by raylib rlgl module.

| ## | example  | developer  |
|----|----------|:----------:|
| 74 | [shaders_basic_lighting](shaders/shaders_basic_lighting.zig) | [Chris Camacho](https://github.com/codifies)

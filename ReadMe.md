# raylib-zig
Manually tweaked, auto generated [raylib](https://github.com/raysan5/raylib) bindings for zig.<br>
Bindings tested on raylib version 3.0

## Workaround
On this branch I will try to wokraround the [technical restrictions](https://github.com/Not-Nik/raylib-zig#technical-restrictions) the normal binding has. May cause severe bugs, terms of the [license](https://github.com/Not-Nik/raylib-zig/blob/master/LICENSE) apply.

### Scope
What is possible at the moment is passing arguments despite zigs C ABI issues. We do that by passing a pointer to a wrapper function which is implemented in C and then calls the original function. Back in zig we wrap the pointer function so they can be used without addresses.
Wrapping return values is not possible at the moment as far as I'm concerned. If you do come up with a solution, feel free to submit a pull request.
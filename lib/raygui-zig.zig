
const rl = @import("raylib-zig.zig");

const Rectangle = rl.Rectangle;
pub extern fn GuiButton(bounds: Rectangle, text: [*c]const u8) bool;
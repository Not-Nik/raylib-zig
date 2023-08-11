// Emscripten is completely unable to find Zig's entry point.
// Solution: create a C compatible entry point in zig,
// and then a C file that calls that entry point in the main method
// This is that C file.

//The entry point found in the zig project
extern int web_emscripten_entry_point();
//this is the method that emscripten calls automatically when the page loads
int main(int argc, char** argv)
{
    //TODO: possibly pass arguments into zig?
    return web_emscripten_entry_point();
}

// For some reason zig adds '__stack_chk_guard', '__stack_chk_fail', and 'errno',
// which emscripten doesn't actually support.
// Seems that zig ignores disabling stack checking,
// and I honestly don't know why emscripten doesn't have errno.
// there's a solution, although it's not a good one...
#include <stdint.h>

uintptr_t __stack_chk_guard;

//Yes, this means that if there is a buffer overflow, nobody is going to know about it.
// However, zig is pretty safe from those, so don't worry about it too much.
void __stack_chk_fail(void){}

int errno;

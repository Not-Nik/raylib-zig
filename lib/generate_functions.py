import re

"""
Automatic utility for generating raylib function headers. Simply put
raylib.h in the working directory of this script and execute.
Tested with raylib version 3.0.0
"""


# Some c types have a different size on different systems
# and zig knows that so we tell it to get the system specific size for us
def c_to_zig_type(t: str) -> str:
    t = t.replace("const ", "")
    if t == "float":
        t = "f32"
    if t == "int":
        t = "c_int"
    if t == "unsigned int":
        t = "c_uint"
    if t == "long":
        t = "c_long"
    if t == "char":
        t = "u8"
    if t == "unsigned char":
        t = "u8"
    return t


def fix_pointer(name: str, t: str):
    t = t.replace("const ", "")
    pre = ""
    while name.startswith("*"):
        name = name[1:]
        pre += "[*c]"
    if len(pre) != 0:
        t = pre + "const " + t
    return name, t


def fix_enums(arg_name, arg_type, func_name):
    # Hacking specifc enums in here
    # Raylib doesn't use the enums but rather the resulting ints
    if arg_type == "int":
        if arg_name == "key":
            arg_type = "KeyboardKey"
        elif arg_name == "button":
            arg_type = "MouseButton"
        elif arg_name == "mode" and func_name == "SetCameraMode":
            arg_type = "CameraMode"
    return arg_type


small_structs = ["Vector2", "Vector3", "Vector4", "Quaternion", "Color", "Rectangle", "Shader"]


def parse_header(header_name: str, output_file: str, prefix: str):
    header = open(header_name, mode="r")
    zig_functions = []
    zig_heads = []

    for line in header.readlines():
        if not line.startswith(prefix):
            continue

        line = line.split(";", 1)[0]
        # each (.*) is some variable value
        result = re.search(prefix + "(.*) (.*)start_arg(.*)end_arg(.*)", line.replace("(", "start_arg").replace(")", "end_arg"))

        # get whats in the (.*)'s
        return_type = result.group(1)
        func_name = result.group(2)
        arguments = result.group(3)

        return_type = c_to_zig_type(return_type)
        func_name, return_type = fix_pointer(func_name, return_type)

        zig_arguments = []
        for arg in arguments.split(", "):
            if arg == "void":
                break
            if arg == "...":
                zig_arguments.append("...")
                continue
            arg_type = " ".join(arg.split(" ")[0:-1])  # everything but the last element (for stuff like "const Vector3")
            arg_type = arg_type.replace("const ", "")  # we'll add that later if needed
            arg_name = arg.split(" ")[-1]  # last element should be the name
            arg_type = fix_enums(arg_name, arg_type, func_name)

            arg_type = c_to_zig_type(arg_type)
            arg_name, arg_type = fix_pointer(arg_name, arg_type)
            zig_arguments.append(arg_name + ": " + arg_type)  # put everything together
        zig_arguments = ", ".join(zig_arguments)
        zig_heads.append("pub extern fn " + func_name + "(" + zig_arguments + ") " + return_type + ";")

    zigheader = open(output_file, mode="w")
    print("usingnamespace @import(\"raylib-zig.zig\");\n", file=zigheader)

    print("\n".join(zig_heads), file=zigheader)
    print("", file=zigheader)
    print("\n".join(zig_functions), file=zigheader)


parse_header("raylib.h", "raylib-wa.zig", "RLAPI ")
parse_header("raymath.h", "raylib-zig-math.zig", "RMDEF ")

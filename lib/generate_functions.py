import re

"""
Automatic utility for generating raylib function headers. Simply put
raylib.h in the working directory of this script and execute.
Tested with raylib version 3.7.0
"""

C_TO_ZIG = {
    "bool": "bool",
    "char": "u8",
    "double": "f64",
    "float": "f32",
    "int": "c_int",
    "long": "c_long",
    "unsigned char": "u8",
    "unsigned int": "c_uint",
}


# Some c types have a different sizes on different systems
# and zig knows that so we tell it to get the system specific size for us
def c_to_zig_type(c: str) -> str:
    const = "const " if "const " in c else ""
    c = c.replace("const ", "")
    z = C_TO_ZIG.get(c)

    if z is not None:
        return const + z

    return const + c


def fix_pointer(name: str, t: str):
    pre = ""
    while name.startswith("*"):
        name = name[1:]
        pre += "[*c]"
    t = pre + t

    if t == "[*c]const void":
        t = "*const anyopaque"
    elif t == "[*c]void":
        t = "*anyopaque"
    elif len(pre) == 0:
        t = t.replace("const ", "")
    return name, t


def fix_enums(arg_name, arg_type, func_name):
    # Hacking specifc enums in here
    # Raylib doesn't use the enums but rather the resulting ints
    if arg_type == "int" or arg_type == "unsigned int":
        if arg_name == "key":
            arg_type = "KeyboardKey"
        elif arg_name == "button":
            if "Gamepad" in func_name:
                arg_type = "GamepadButton"
            else:
                arg_type = "MouseButton"
        elif arg_name == "mode" and func_name == "SetCameraMode":
            arg_type = "CameraMode"
        elif arg_name == "gesture":
            arg_type = "Gestures"
        elif arg_name == "flags" and func_name in ["SetWindowState", "ClearWindowState", "SetConfigFlags"]:
            arg_type = "ConfigFlags"
    return arg_type


def parse_header(header_name: str, output_file: str, prefix: str):
    header = open(header_name, mode="r")
    zig_functions = []
    zig_heads = []
    zig_types = set()

    leftover = ""

    for line in header.readlines():

        if line.startswith("typedef struct"):
            zig_types.add(line.split(' ')[2])
        elif line.startswith("typedef enum"):
            # don't trip the general typedef case
            pass
        elif line.startswith("typedef "):
            zig_types.add(line.split(' ')[2].replace(';', '').strip())

        if not line.startswith(prefix):
            continue

        line = line.split(";", 1)[0]

        if leftover:
            line = leftover + line
            leftover = ""

        line = line.replace("* ", " *")

        line = line.replace(",", ", ")
        line = line.replace("  ", " ")

        # each (.*) is some variable value
        result = re.search(prefix + "(.*) (.*)start_arg(.*)end_arg(.*)", line.replace("(", "start_arg").replace(")", "end_arg"))

        if result is None:
            leftover += line
            continue

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
            arg_name = arg.split(" ")[-1]  # last element should be the name
            arg_type = fix_enums(arg_name, arg_type, func_name)

            arg_type = c_to_zig_type(arg_type)
            arg_name, arg_type = fix_pointer(arg_name, arg_type)

            zig_types.add(arg_type.replace("const ", ""))
            zig_arguments.append(arg_name + ": " + arg_type)  # put everything together
        zig_arguments = ", ".join(zig_arguments)
        zig_heads.append("pub extern fn " + func_name + "(" + zig_arguments + ") " + return_type + ";")

    zigheader = open(output_file, mode="w")
    print("""const rl = @import("raylib-zig.zig");\n""", file=zigheader)

    print("\n".join(sorted(f"const {t} = rl.{t};" for t in zig_types if ('*' not in t) and (t not in C_TO_ZIG.values()))), file=zigheader)
    print("", file=zigheader)
    print("\n".join(zig_heads), file=zigheader)
    print("", file=zigheader)
    print("\n".join(zig_functions), file=zigheader)


if __name__ == "__main__":
    parse_header("raylib.h", "raylib-wa.zig", "RLAPI ")
    parse_header("raymath.h", "raylib-zig-math.zig", "RMAPI ")

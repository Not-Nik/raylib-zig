import re
import sys

"""
Automatic utility for generating functions, including workaround functions
to fix Zig's issue with C ABI struct parameters. Simply put raylib.h in the
working directory of this script and execute. You'll get a workaround.c and
workaround.zig. The first has to be added as a C source and the latter has
to be included in raylib-zig.zig. Tested with raylib version 3.0.0
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
c_functions = []


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

        # Igoring function here because:
        # a) C va_args are supported in Zig but I
        if return_type in small_structs or return_type == "float3" or return_type == "float16":
            continue

        for struct in small_structs:
            if struct in arguments:
                break
        else:  # we found a completely normal function
            return_type = c_to_zig_type(return_type)
            func_name, return_type = fix_pointer(func_name, return_type)

            zig_arguments = []
            for arg in arguments.split(", "):
                if arg == "void":
                    break
                if arg == "...":
                    zig_arguments.append("...")
                    break
                arg_type = " ".join(arg.split(" ")[0:-1])  # everything but the last element (for stuff like "const Vector3")
                arg_type = arg_type.replace("const ", "")  # zig doesn't like const in function arguments that aren't pointer and really we don't need const
                arg_name = arg.split(" ")[-1]  # last element should be the name
                arg_type = fix_enums(arg_name, arg_type, func_name)

                arg_type = c_to_zig_type(arg_type)
                arg_name, arg_type = fix_pointer(arg_name, arg_type)
                zig_arguments.append(arg_name + ": " + arg_type)  # put everything together
            zig_arguments = ", ".join(zig_arguments)
            zig_heads.append("pub extern fn " + func_name + "(" + zig_arguments + ") " + return_type + ";")
            continue

        # If we find variable arguments in a workaround function
        #
        if "..." in arguments: continue

        zig_arguments_w = []  # arguments for the workaround function head on the zig side
        zig_arguments = []  # arguments that are passed to the copied raylib function
        zig_pass = []  # arguments that are passed to the workaround function on the zig side
        c_arguments = []  # arguments for the workaround function head on the c side
        c_pass = []  # arguments that are passed to the actual raylib function

        for arg in arguments.split(", "):
            if arg == "void" : break
            arg_type = " ".join(arg.split(" ")[0:-1]).replace("const ", "")  # everything but the last element (for stuff like "const Vector3"), but discarding const
            arg_name = arg.split(" ")[-1]  # last element should be the name
            arg_type = fix_enums(arg_name, arg_type, func_name)
            depoint = False  # set to true if we need to dereference a pointer to a small struct in the c workaround
            if arg_type in small_structs:
                if not arg_name.startswith("*"):
                    depoint = True

            if depoint:
                arg_name = "*" + arg_name  # dereference the arguments

            c_arguments.append(arg_type + " " + arg_name)
            if arg_name.startswith("*") and not depoint:  # That's in case of an actual array
                c_name = arg_name
                while c_name.startswith("*"):
                    c_name = c_name[1:]
                c_pass.append(c_name)  # We don't want to dereference the array
            else:
                c_pass.append(arg_name)

            # zig conversions
            zig_type = c_to_zig_type(arg_type)
            zig_name = arg_name

            if depoint and zig_name.startswith("*"):  # These are the arguments without pointers
                zig_name = zig_name[1:]
                zig_pass_name = "&" + zig_name
            elif zig_name.startswith("*") and not depoint:  # That's in case of an actual array
                zig_name = zig_name[1:]
                if zig_name.startswith("*"):
                    zig_name = zig_name[1:]
                    zig_type = "[*c][]const " + zig_type
                else:
                    zig_type = "[*c]const " + zig_type
                zig_pass_name = "&" + zig_name + "[0]"
            else:  # Normal argument i.e. float, int, etc.
                zig_pass_name = zig_name
            zig_arguments.append(zig_name + ": " + zig_type)  # put everything together
            zig_pass.append(zig_pass_name)

            # These are the arguments for the extern workaround functions with pointers
            arg_type = c_to_zig_type(arg_type)
            arg_name, arg_type = fix_pointer(arg_name, arg_type)
            zig_arguments_w.append(arg_name + ": " + arg_type)  # put everything together

        # Workaround function head in zig
        zig_arguments_w = ", ".join(zig_arguments_w)
        zig_ret_type = c_to_zig_type(return_type)
        zig_func_name, zig_ret_type = fix_pointer(func_name, zig_ret_type)
        zig_heads.append("pub extern fn W" + func_name + "(" + zig_arguments_w + ") " + return_type + ";")

        # Create the function to call the workaround
        zig_arguments = ", ".join(zig_arguments)
        zig_pass = ", ".join(zig_pass)
        function = "pub fn " + func_name + "(" + zig_arguments + ") " + return_type + "\n"
        function += "{\n"
        if return_type != "void":
            function += "    return W" + func_name + "(" + zig_pass + ");\n"
        else:
            function += "    W" + func_name + "(" + zig_pass + ");\n"
        function += "}\n"
        zig_functions.append(function)

        # Create workaround function
        c_arguments = ", ".join(c_arguments)
        c_pass = ", ".join(c_pass)
        function = return_type + " W" + func_name + "(" + c_arguments + ")\n"
        function += "{\n"
        if return_type != "void":
            function += "    return " + func_name + "(" + c_pass + ");\n"
        else:
            function += "    " + func_name + "(" + c_pass + ");\n"
        function += "}\n"
        c_functions.append(function)

    zigheader = open(output_file, mode="w")
    print("usingnamespace @import(\"raylib-zig.zig\");\n", file=zigheader)

    print("\n".join(zig_heads), file=zigheader)
    print("", file=zigheader)
    print("\n".join(zig_functions), file=zigheader)


parse_header("raylib.h", "raylib-wa.zig", "RLAPI ")
parse_header("raymath.h", "raylib-zig-math.zig", "RMDEF ")

workaround = open("workaround.c", mode="w")
print("// raylib-zig (c) Nikolas Wipper 2020\n", file=workaround)
print("#include <raylib.h>", file=workaround)
print("#include <raymath.h>\n", file=workaround)

print("\n".join(c_functions), file=workaround)

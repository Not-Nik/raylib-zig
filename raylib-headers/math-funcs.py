import re

"""
Automatic utility for extracting function definitions from raymath.h
and translating them to zig. This can technically be used for raylib.h
as well when setting prefix = "RLAPI " and possibly also for all other
raylib headers
"""

raymath = open("raymath.h")

prefix = "RMDEF "


# Some c types have a different size on different systems
# and zig knows that so we tell it to get the system specific size for us
def c_to_zig_type(t: str) -> str:
    if t == "float":
        t = "f32"
    if t == "int":
        t = "c_int"
    if t == "unsigned int":
        t = "c_uint"
    if t == "long":
        t = "c_long"
    if t == "void":
        t = "c_void"
    return t


def fix_pointer(name: str, type: str):
    if name.startswith("*"):
        name = name[1:]
        type = "[*c]" + type
    return name, type


for line in raymath.readlines():
    if line.startswith(prefix):
        # each (.*) is some variable value
        result = re.search(prefix + "(.*) (.*)start_arg(.*)end_arg", line.replace("(", "start_arg").replace(")", "end_arg"))

        # get whats in the (.*)'s
        return_type = result.group(1)
        func_name = result.group(2)
        arguments = result.group(3)

        func_name, return_type = fix_pointer(func_name, return_type)

        return_type = c_to_zig_type(return_type)
        zig_arguments = []
        for arg in arguments.split(", "):
            if arg == "void": break
            arg_type = " ".join(arg.split(" ")[0:-1])  # everything but the last element (for stuff like "const Vector3")
            arg_type = arg_type.replace("const ", "")  # zig doesn't like const in function arguments that aren't pointer and really we don't need const
            arg_type = c_to_zig_type(arg_type)
            arg_name = arg.split(" ")[-1]  # last element should be the name
            arg_name, arg_type = fix_pointer(arg_name, arg_type)
            zig_arguments.append(arg_name + ": " + arg_type)  # put everything together
        zig_arguments = ", ".join(zig_arguments)
        print("pub extern fn " + func_name + "(" + zig_arguments + ") " + return_type + ";")

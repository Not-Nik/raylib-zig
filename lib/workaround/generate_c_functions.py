import re

"""
Automatic utility for generating workaround functions for both C and Zig
to fix zig's issue with C ABI struct parameter. Put all functions that have
a parameter with one of the types listed in small_structs into cfunctions.
If one of those functions has a returns type listed in small_structs it
will be automatically ignored. Make sure raylib-zig.zig doesn't already
contain a function with the given names before copying the workaround in
"""

raymath = open("cfunctions")


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
        type = "[*c]const " + type
    return name, type


small_structs = ["Vector2", "Vector3", "Vector4", "Quaternion", "Color", "Rectangle", "Shader"]
zig_functions = []
c_functions = []
zig_heads = []

for line in raymath.readlines():
    # each (.*) is some variable value
    result = re.search("(.*) (.*)start_arg(.*)end_arg", line.replace("(", "start_arg").replace(")", "end_arg"))

    # get whats in the (.*)'s
    return_type = result.group(1)
    func_name = result.group(2)
    arguments = result.group(3)

    if return_type in small_structs:
        continue

    zig_arguments_w = []  # arguments for the workaround function head on the zig side
    zig_arguments = []  # arguments that are passed to the copied raylib function
    zig_pass = []  # arguments that are passed to the workaround function on the zig side
    c_arguments = []  # arguments for the workaround function head on the c side
    c_pass = []  # arguments that are passed to the actual raylib function

    for arg in arguments.split(", "):
        if arg == "void": break
        arg_type = " ".join(arg.split(" ")[0:-1]).replace("const ", "")  # everything but the last element (for stuff like "const Vector3"), but discarding const
        arg_name = arg.split(" ")[-1]  # last element should be the name
        depoint = False  # set to true if we need to dereference a pointer to a small struct in the c workaround
        if arg_type in small_structs:
            if not arg_name.startswith("*"):
                depoint = True

        if depoint:
            arg_name = "*" + arg_name  # dereference the arguments

        c_arguments.append(arg_type + " " + arg_name)
        if arg_name.startswith("*") and not depoint:  # That's in case of an actual array
            c_pass.append(arg_name[1:])  # We don't want to dereference the array
        else:
            c_pass.append(arg_name)

        # zig conversions
        zig_type = c_to_zig_type(arg_type)
        if depoint and arg_name.startswith("*"):  # These are the arguments without pointers
            zig_name = arg_name[1:]
            zig_pass_name = "&" + zig_name
        elif arg_name.startswith("*") and not depoint:  # That's in case of an actual array
            zig_name = arg_name[1:]
            zig_type = "[]const " + arg_type
            zig_pass_name = "&" + arg_name[1:] + "[0]"
        else:  # Normal argument i.e. float, int, etc.
            zig_name = arg_name
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

workaround = open("workaround.c", mode="w")
print("// raylib-zig (c) Nikolas Wipper 2020\n", file=workaround)
print("#include <raylib.h>\n", file=workaround)

zigworkaround = open("workaround.zig", mode="w")

print("\n".join(c_functions), file=workaround)
print("\n".join(zig_heads), file=zigworkaround)
print("", file=zigworkaround)
print("\n".join(zig_functions), file=zigworkaround)

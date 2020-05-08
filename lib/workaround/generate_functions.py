import re

"""
Automatic utility for generating function calls to workaround functions
"""

if __name__ == "__main__":
    pass

raymath = open("functions")


for line in raymath.readlines():
    # each (.*) is some variable value
    result = re.search("pub extern fn (.*)start_arg(.*)end_arg (.*);", line.replace("(", "start_arg").replace(")", "end_arg"))

    # get whats in the (.*)'s
    func_name = result.group(1)
    arguments = result.group(2)
    return_type = result.group(3)

    args = []
    names = []
    for arg in arguments.split(", "):
        result = re.search("(.*): (.*)", arg)
        arg_name = result.group(1)
        arg_type = result.group(2)
        args.append(arg_name + ": " + arg_type.replace("[*c]", "").replace("const ", ""))  # put everything together
        if "[*c]" in arg_type:
            arg_name = "&" + arg_name
        names.append(arg_name)
    args = ", ".join(args)
    print("pub fn " + func_name[1:] + "(" + args + ") " + return_type)
    print("{")
    print("    " + func_name + "(" + (", ".join(names)) + ");")
    print("}\n")

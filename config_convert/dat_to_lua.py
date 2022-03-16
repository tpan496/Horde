import argparse

def convert_dat_to_lua(input_file_path, output_file_path):
    with open(input_file_path, "r") as items:
        items_data = items.readlines()

    items_new_data = ""
    i = 0
    indent = 0
    variable_name = True
    while i < len(items_data[0]):
        # : to =
        if items_data[0][i] == ":":
            items_new_data += " = "
            variable_name = False
            i += 1

        # remove unnecessary line break
        elif items_data[0][i:i+2] == "\\n":
            items_new_data += " "
            i += 2

        # indentation
        elif items_data[0][i] == "{":
            indent += 2
            items_new_data += "{\n"
            items_new_data += " " * indent
            variable_name = True
            i += 1

        elif items_data[0][i] == "}":
            indent -= 2
            items_new_data += "\n"
            items_new_data += " " * indent
            items_new_data += "}"
            variable_name = True
            i += 1

        elif items_data[0][i:i+2] == ",\"":
            items_new_data += ",\n"
            items_new_data += " " * indent
            variable_name = True
            i += 1

        # remove quotations from variables
        elif items_data[0][i] == "\"" and variable_name == True:
            items_new_data += ""
            i += 1

        # direct copy
        else:
            items_new_data += items_data[0][i]
            i += 1
        
    with open(output_file_path, "w") as output_file:
        output_file.write(items_new_data)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-in', '--input_file_path', type=str,
                        help='path to the config data')
    parser.add_argument('-out', '--output_file_path', type=str,
                        help='output lua file name')
    args = parser.parse_args()
    
    convert_dat_to_lua(args.input_file_path, args.output_file_path)
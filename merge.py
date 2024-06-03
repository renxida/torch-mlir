import os
import re

def extract_function_name(code):
    match = re.search(r"func\.func @(\w+)\(", code)
    if match:
        return match.group(1)
    else:
        return None

def merge_files():
    base_dir = "test/Conversion/TorchOnnxToTorch/"
    file_names = ["simple_ops_a_to_f.mlir", "simple_ops_g_to_p.mlir", "simple_ops_q_to_z.mlir"]
    input_dir = "./issue450/"
    separator = "// -----"

    for file_name in file_names:
        file_path = os.path.join(base_dir, file_name)
        with open(file_path, 'r') as file:
            content = file.read()
        parts = content.split(separator)
        merged_content = []

        for part in parts:
            func_name = extract_function_name(part)
            if func_name:
                part_file_name = None
                for file in os.listdir(input_dir):
                    match = re.match(rf"{func_name}_(\d+)\.mlir$", file)
                    if match:
                        part_file_name = file
                        break
                if part_file_name:
                    part_file_path = os.path.join(input_dir, part_file_name)
                    with open(part_file_path, 'r') as part_file:
                        part_content = part_file.read()
                    merged_content.append(part_content)

        with open(file_path, 'w') as merged_file:
            merged_file.write(separator.join(merged_content))

if __name__ == "__main__":
    merge_files()

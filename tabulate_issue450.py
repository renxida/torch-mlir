import os
import subprocess
from collections import defaultdict
import re

def extract_function_name(code):
    match = re.search(r"func\.func @(\w+)\(", code)
    if match:
        return match.group(1)
    else:
        return None

def split_files():
    base_dir = "test/Conversion/TorchOnnxToTorch/"
    file_names = ["simple_ops_a_to_f.mlir", "simple_ops_g_to_p.mlir", "simple_ops_q_to_z.mlir"]
    output_dir = "./issue450/"
    os.makedirs(output_dir, exist_ok=True)
    separator = "// -----"
    func_name_counts = defaultdict(int)
    for file_name in file_names:
        file_path = os.path.join(base_dir, file_name)
        with open(file_path, 'r') as file:
            content = file.read()
        parts = content.split(separator)
        for idx, part in enumerate(parts):
            func_name = extract_function_name(part)
            if func_name:
                func_name_counts[func_name] += 1
                part_file_name = f"{func_name}_{func_name_counts[func_name]}.mlir"
            else:
                continue
                # part_file_name = f"{os.path.splitext(file_name)[0]}_part{idx}.mlir"
            part_file_path = os.path.join(output_dir, part_file_name)
            with open(part_file_path, 'w') as part_file:
                part_file.write(part)
def process_files():
    output_dir = "./issue450/"
    results = {"success": 0, "failure": 0, "errors": defaultdict(int), "testcases_with_error": defaultdict(list)}
    
    stages = {
        ".torch.mlir": "--convert-torch-onnx-to-torch",
        ".decomposed.mlir": "--torch-decompose-complex-ops",
        ".linalg.mlir": "--torch-backend-to-linalg-on-tensors-backend-pipeline"
    }
    
    for file_name in os.listdir(output_dir):
        if file_name.endswith(".mlir"):
            part_file_path = os.path.join(output_dir, file_name)
            log_file_path = f"{part_file_path}.log"
            
            # Print the first three nonempty lines
            with open(part_file_path, 'r') as read_part:
                lines = [line for line in read_part if line.strip() != '']
            
            funcname = extract_function_name('\n'.join(lines))
            
            input_file_path = part_file_path
            for stage, opt in stages.items():
                output_file_path = f"{part_file_path}{stage}"
                
                cmd = [
                    "torch-mlir-opt", "--split-input-file", opt,
                    "--canonicalize", "-o", output_file_path, input_file_path
                ]
                
                with open(log_file_path, 'a') as log_file:
                    proc = subprocess.run(cmd, stdout=log_file, stderr=subprocess.STDOUT, text=True)
                
                if proc.returncode != 0:
                    results["failure"] += 1
                    error_message = check_error(log_file_path, proc.returncode)
                    results["errors"][error_message] += 1
                    results["testcases_with_error"][error_message].append(funcname)
                    break
                
                input_file_path = output_file_path
            
            else:
                results["success"] += 1
    # summarize results
    print("\n\nSummary:")
    print(f"Success: {results['success']}")
    print(f"Failure: {results['failure']}")
    print("Errors:")
    for error, count in results["errors"].items():
        print(f"{count} times: {error.strip()}")

        testcases_with_error = results["testcases_with_error"][error]
        testcases_with_error = "\n\t".join(testcases_with_error)
        print(f"Testcases: \n\t{testcases_with_error}")
        print("\n")
    print("\n\nSummary:")
    print(f"Success: {results['success']}")
    print(f"Failure: {results['failure']}")
    print(f"Total: {results['success'] + results['failure']}")
    print(f"Percentage: {results['success'] / (results['success'] + results['failure']) * 100:.2f}%")
    print("Done.")


def check_error(log_file_path, returncode):
    error_message = None
    with open(log_file_path, 'r') as log_file:
        for line in log_file:
            error_pos = line.find("error:")
            if error_pos != -1:
                error_message = line[error_pos:]
                break
    
    if not error_message:
        error_message = f"No error; exit code: {returncode}"
    
    return error_message


if __name__ == "__main__":
    split_files()
    # print number of files
    print(f"Number of files: {len(os.listdir('./issue450/'))}")
    process_files()

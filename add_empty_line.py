import os

def add_empty_line_to_sv_files(directory):
    """
    遍历指定目录中的所有 .sv 文件，并在每个文件末尾添加一个空行（如果没有的话）。
    """
    if not os.path.isdir(directory):
        print(f"错误: 目录 {directory} 不存在。")
        return
    
    # 遍历文件夹中的所有文件
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".sv"):  # 只处理 .sv 文件
                file_path = os.path.join(root, file)

                # 读取文件内容
                with open(file_path, 'r') as f:
                    lines = f.readlines()

                # 检查文件末尾是否已经有空行
                if not lines or lines[-1].strip() != '':
                    # 在末尾添加一个空行
                    with open(file_path, 'a') as f:
                        f.write('\n')
                    print(f"文件 {file_path} 末尾已添加空行。")
                else:
                    print(f"文件 {file_path} 已经有空行，无需修改。")

if __name__ == "__main__":
    import argparse

    # 使用 argparse 解析命令行参数
    parser = argparse.ArgumentParser(description="在指定目录下的所有 .sv 文件末尾添加空行。")
    parser.add_argument("directory", help="要处理的文件夹路径")

    args = parser.parse_args()
    directory = args.directory

    # 执行函数
    add_empty_line_to_sv_files(directory)
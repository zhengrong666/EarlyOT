import os
import sys
import filecmp
from collections import defaultdict

def get_files_by_name(directory, extensions=None):
    """
    遍历指定目录，按文件名收集所有文件的完整路径。
    可选：只收集特定扩展名的文件。
    """
    files_dict = defaultdict(list)
    for root, _, files in os.walk(directory):
        for file in files:
            if extensions and not file.endswith(extensions):
                continue
            full_path = os.path.join(root, file)
            files_dict[file].append(full_path)
    return files_dict

def compare_files(file_a, file_b):
    """
    比较两个文件的内容是否完全相同。
    返回 True 如果相同，False 如果不同。
    """
    try:
        return filecmp.cmp(file_a, file_b, shallow=False)
    except Exception as e:
        print(f"无法比较文件 {file_a} 和 {file_b}：{e}")
        return False

def differences_are_only_first_line_and_trailing_spaces_diff(file_a, file_b):
    """
    检查两个文件是否只有第一行不同，且其他行只在行末尾有空格差异。
    返回 True 如果满足上述条件，False 否则。
    """
    try:
        with open(file_a, 'r', encoding='utf-8') as fa, open(file_b, 'r', encoding='utf-8') as fb:
            lines_a = fa.readlines()
            lines_b = fb.readlines()

            # 如果行数不同，肯定有更多的差异
            if len(lines_a) != len(lines_b):
                return False

            for idx, (line_a, line_b) in enumerate(zip(lines_a, lines_b)):
                if line_a == line_b:
                    continue  # 行完全相同，继续

                if idx == 0:
                    # 第一行的不同是允许的
                    continue

                # 对于非第一行，检查是否只在行末尾有空格差异
                if line_a.rstrip() != line_b.rstrip():
                    return False  # 有更显著的差异

            # 所有差异都是在第一行或行末尾的空格
            return True

    except Exception as e:
        print(f"无法读取文件 {file_a} 或 {file_b}：{e}")
        return False

def main(dir_a, dir_b, extensions=None, output_path=None):
    # 获取两个目录中所有文件按文件名分类的字典
    files_a = get_files_by_name(dir_a, extensions)
    files_b = get_files_by_name(dir_b, extensions)

    # 找到两个目录中共有的文件名
    common_filenames = set(files_a.keys()).intersection(set(files_b.keys()))

    differing_files = []

    for filename in common_filenames:
        paths_a = files_a[filename]
        paths_b = files_b[filename]

        for path_a in paths_a:
            for path_b in paths_b:
                if compare_files(path_a, path_b):
                    continue  # 内容完全相同，跳过
                if differences_are_only_first_line_and_trailing_spaces_diff(path_a, path_b):
                    continue  # 只有第一行不同或只有行末尾多了空格，跳过
                differing_files.append((filename, path_a, path_b))

    # 输出结果
    if output_path:
        with open(output_path, "w", encoding="utf-8") as f:
            if differing_files:
                f.write("内容不同的同名文件列表（排除只有第一行不同和只有行末尾空格差异的文件）：\n\n")
                for filename, path_a, path_b in differing_files:
                    f.write(f"文件名: {filename}\n")
                    f.write(f"  A: {path_a}\n")
                    f.write(f"  B: {path_b}\n")
                    f.write("-" * 60 + "\n")
                f.write(f"\n总共有 {len(differing_files)} 对文件内容不同。\n")
                print(f"内容不同的文件已记录在 {output_path} 中。")
            else:
                f.write("所有同名文件的内容相同，或只有第一行不同，或只有行末尾空格差异。\n")
                print("所有同名文件的内容相同，或只有第一行不同，或只有行末尾空格差异。")
    else:
        if differing_files:
            print("内容不同的同名文件列表（排除只有第一行不同和只有行末尾空格差异的文件）：\n")
            for filename, path_a, path_b in differing_files:
                print(f"文件名: {filename}")
                print(f"  A: {path_a}")
                print(f"  B: {path_b}")
                print("-" * 60)
            print(f"\n总共有 {len(differing_files)} 对文件内容不同。")
        else:
            print("所有同名文件的内容相同，或只有第一行不同，或只有行末尾空格差异。")

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="比较两个文件夹中同名文件的内容差异，排除只有第一行不同和只有行末尾空格差异的文件。")
    parser.add_argument("dir_a", help="第一个目录路径（A）")
    parser.add_argument("dir_b", help="第二个目录路径（B）")
    parser.add_argument("-e", "--extensions", nargs='*', help="只比较具有指定扩展名的文件，例如：-e .txt .csv")
    parser.add_argument("-o", "--output", help="将结果输出到指定文件路径")

    args = parser.parse_args()

    dir_a = args.dir_a
    dir_b = args.dir_b
    extensions = tuple(args.extensions) if args.extensions else None
    output_path = args.output

    # 检查目录是否存在
    if not os.path.isdir(dir_a):
        print(f"错误: 目录A不存在或不是一个目录: {dir_a}")
        sys.exit(1)
    if not os.path.isdir(dir_b):
        print(f"错误: 目录B不存在或不是一个目录: {dir_b}")
        sys.exit(1)

    main(dir_a, dir_b, extensions, output_path)

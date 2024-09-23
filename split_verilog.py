import os
import re
import argparse

def split_verilog_file(input_file, output_dir):
    """
    将包含多个 Verilog module 的文件按模块名称拆分为多个文件。
    每个模块将保存到一个新文件中，文件名以模块名称命名。
    """
    # 读取输入文件
    with open(input_file, 'r') as f:
        verilog_code = f.read()

    # 正则表达式用于匹配 Verilog module 的开始和结束
    module_pattern = re.compile(r"\bmodule\s+(\w+)\b")  # 匹配 module 关键字和模块名称
    endmodule_pattern = re.compile(r"\bendmodule\b")  # 匹配 endmodule 关键字

    # 初始化变量
    module_starts = []
    module_ends = []
    modules = []

    # 找到所有模块的开始位置
    for match in module_pattern.finditer(verilog_code):
        module_name = match.group(1)
        module_starts.append((match.start(), module_name))

    # 找到所有模块的结束位置
    for match in endmodule_pattern.finditer(verilog_code):
        module_ends.append(match.end())

    # 确保模块的数量匹配
    if len(module_starts) != len(module_ends):
        raise ValueError("Verilog 文件中的模块数不匹配（可能缺少 'endmodule'）")

    # 按照模块的起始和结束位置提取每个模块
    for i, (start, module_name) in enumerate(module_starts):
        end = module_ends[i]
        modules.append((module_name, verilog_code[start:end]))

    # 创建输出目录
    os.makedirs(output_dir, exist_ok=True)

    # 打印模块列表
    print("发现以下模块：")
    for module_name, _ in modules:
        print(f"- rtl/{module_name}.sv")

    # 将每个模块写入单独的文件
    for module_name, module_code in modules:
        output_file = os.path.join(output_dir, f"{module_name}.sv")
        with open(output_file, 'w') as f:
            f.write(module_code)
        print(f"模块 {module_name} 已保存到文件 {output_file}")

if __name__ == "__main__":
    # 使用 argparse 来解析命令行参数
    parser = argparse.ArgumentParser(description="将包含多个 Verilog module 的文件按模块名称拆分为多个文件。")
    parser.add_argument("input_file", help="要分隔的 Verilog 文件路径")
    parser.add_argument("-o", "--output_dir", default=None, help="输出文件夹路径（可选），默认为当前目录下的以输入文件名为基础的文件夹")

    args = parser.parse_args()
    input_file = args.input_file
    output_dir = args.output_dir

    # 检查文件是否存在
    if not os.path.isfile(input_file):
        print(f"错误: 文件 {input_file} 不存在。")
        exit(1)

    # 如果没有指定输出目录，使用默认值
    if output_dir is None:
        output_dir = os.path.splitext(input_file)[0] + "_modules"

    # 运行拆分函数
    split_verilog_file(input_file, output_dir)
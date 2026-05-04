+++
title = 'Python List'
date = 2025-10-19T11:08:05+08:00
draft = false
slug = "54414bb"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"
+++

# List

这篇用最简单的话，讲清 Python 列表（list）：它是有序、可变的序列，增删改查都很顺手，但有几个常见坑需要避开。

**数据越大，就越耗时，因为逐一翻查**

## 一句话认识 list
- `list` 是有序集合，元素可重复、类型可混（不建议混用）。
- 可变：支持原地修改（增删改）；与 `tuple`（不可变）相对。
- 字面量：`[]` 空列表，`[1, 2, 3]`。

## 快速上手
```python
nums = [1, 2, 3]
nums[0]       # 1（索引）
nums[-1]      # 3（倒数第一个）
nums[1:3]     # [2, 3]（切片）

nums.append(4)       # [1, 2, 3, 4]（尾部追加）
nums.extend([5, 6])  # [1, 2, 3, 4, 5, 6]（批量追加）
nums.insert(1, 99)   # [1, 99, 2, 3, 4, 5, 6]（在索引处插入）

nums.remove(99)      # 删除第一个匹配值（若不存在报错）
x = nums.pop()       # 弹出并返回最后一个元素
nums.clear()         # 清空
```

## 常用方法（够用版）
- 添加：`append(x)`（单个）、`extend(iterable)`（多个）、`insert(i, x)`（在 i 处插入）。
- 删除：`pop(i=-1)`（按索引并返回）、`remove(x)`（按值）、`clear()`（清空）。
- 查找：`index(x)`（找第一个索引，未找到报错）、`count(x)`（计数）。
- 排序与方向：`sort(key=None, reverse=False)`（原地排序，返回 None）、`reverse()`（原地反转）。
- 复制：`copy()`（浅拷贝），或切片 `lst[:]`。

## 切片与拷贝
```python
lst = [0, 1, 2, 3, 4]
lst[1:4]      # [1, 2, 3]
lst[:3]       # [0, 1, 2]
lst[::2]      # [0, 2, 4]（步长）
lst[::-1]     # 反转副本

# 浅拷贝：新列表，但内部引用不变
shallow = lst[:]           # 或 lst.copy()

# 深拷贝：连同内部对象也复制
import copy
deep = copy.deepcopy(lst)
```
- 浅拷贝适合扁平列表；嵌套结构需深拷贝防止共享引用。

## 排序与合并
```python
nums = [3, 1, 2]
nums.sort()           # 原地排序；返回 None
sorted(nums)          # 返回新列表，不改原列表

# 自定义排序
words = ['apple', 'Banana', 'pear']
words.sort(key=str.lower)  # 忽略大小写排序

# 合并
a = [1, 2]
b = [3, 4]
c = a + b          # 新列表 [1,2,3,4]
a.extend(b)        # 原地扩展 a -> [1,2,3,4]
```
- 记忆点：`list.sort()`原地修改且返回 `None`；`sorted(list)`返回新列表。

## 列表推导式（推荐写法）
```python
squares = [x*x for x in range(5)]            # [0,1,4,9,16]
even = [x for x in range(10) if x % 2 == 0]  # 过滤保留偶数
pairs = [(x, y) for x in range(2) for y in range(2)]
```
- 用推导式替代“遍历 + append”，代码更简洁、少错。

## 遍历与索引
```python
lst = ['a', 'b', 'c']
for item in lst:
    print(item)

for i, item in enumerate(lst, start=1):  # 从 1 开始编号
    print(i, item)
```

## 容易踩雷（简明版）
- `append` vs `extend`：`append([1,2])` 会加一个“子列表”；`extend([1,2])` 会把元素打散追加。
- 浅拷贝 vs 深拷贝：`lst[:]`/`lst.copy()` 只复制顶层；嵌套列表需要 `copy.deepcopy`。
- 乘法复制的“共享坑”：`matrix = [[0]*3]*2` 两行指向同一子列表，改一行另一行也变。正确：`matrix = [[0]*3 for _ in range(2)]`。
- 边遍历边删除：会跳元素或错位。正确做法：构造新列表或从后往前删，或用推导式过滤。
- `remove` 不存在会报错：用前先判断 `if x in lst:`，或 `try/except`。
- 排序返回值：`lst.sort()` 返回 `None`，不要写成 `lst = lst.sort()`。
- 性能直觉：`append` 均摊 O(1)；`insert(0, x)`/在头部操作是 O(n)；大列表频繁头部插入用 `collections.deque` 更合适。
- 拼接创建新列表：`a + b` 生成新列表，原列表不变；大量拼接做汇总更高效的方法是一次性 `extend` 或推导式生成。

## 速查清单
- 添加：`append` / `extend` / `insert`
- 删除：`pop` / `remove` / `clear`
- 查找：`index` / `count`
- 排序：`sort`（原地） / `sorted`（新列表） / `reverse`
- 切片：`lst[a:b:c]` / 复制 `lst[:]` / 反转 `lst[::-1]`
- 推导式：`[expr for x in iterable if cond]`
- 安全拷贝：`copy.deepcopy`（嵌套结构）

## 小示例
```python
# 过滤并转换
names = ['Alice', '', 'Bob', '  ']
clean = [n.strip() for n in names if n.strip()]  # ['Alice', 'Bob']

# 扁平化二维列表
matrix = [[1,2],[3,4]]
flat = [x for row in matrix for x in row]        # [1,2,3,4]

# 稳妥删除
items = [1,2,3,2]
items = [x for x in items if x != 2]             # [1,3]

# 排序 + 生成新列表
scores = [88, 92, 75]
sorted_scores = sorted(scores, reverse=True)     # [92, 88, 75]
```
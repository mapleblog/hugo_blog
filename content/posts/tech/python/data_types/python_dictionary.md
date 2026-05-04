+++
title = 'Python Dictionary'
date = 2025-10-19T11:08:28+08:00
draft = false
slug = "e349600"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"
+++

# Dictionary

这篇用最简单的话，讲清 Python 字典（dict）：它是“键-值”映射，键必须可哈希（可做字典键），适合快速查找、聚合统计、配置与数据表达。



```python
d = {1: "a", 2: "b", 3: "c"}
print(d[2])
```

字典做了一个魔法操作：**把 key 转换成一个位置**。



```python
key = 3  →  [魔法计算]  →  位置 = "c"
```

这个"魔法计算"叫做**哈希函数**（hash function）。它的作用是：

> 输入任何 key（数字、字符串等），输出一个固定的"位置编号"。

每次输入 `2`，输出的位置永远是同一个。所以 Python 拿到 key=2，**不需要找**，它**算出来**位置直接去拿。



**Python 做的事：**

1. 拿到 key = `2`
2. 计算 `hash(2)` → 得到一个位置编号
3. **直接跳到那个位置**，拿出值 `"b"`
4. 返回 `"b"`



> 你有一个房间 10 个抽屉，要去 2 号抽屉拿东西。 你有另一个房间 100 万个抽屉，每个都编了号，要去 2 号抽屉拿东西。
>
> **两种情况，你都是直接走到 2 号抽屉**。
>
> 第二个房间的抽屉**多**，但你**没有去看其他抽屉**。你只去了 1 个



##### 抽屉数量多 ≠ 你要操作的次数多。**只要你知道编号，操作次数永远是 1**。



## 一句话认识 dict
- 特性：键唯一、值可任意类型、无序（3.7+按插入顺序显示但别依赖排序）。
- 键必须可哈希：数字、字符串、元组可以；列表、字典不行。
- 常见创建：`{}`、`dict()`、`dict(a=1,b=2)`、`dict([('a',1),('b',2)])`。

## 快速上手
```python
# 创建与访问
user = {'name': 'Alice', 'age': 20}
user['age']          # 20（不存在会报 KeyError）
user.get('city')     # None（安全访问）
user.get('city', 'Beijing')  # 默认值

# 新增与更新
user['city'] = 'Beijing'
user.update({'age': 21, 'job': 'dev'})

# 删除
user.pop('job')      # 返回值并删除
user.pop('not_exist', None)  # 给默认值避免报错
user.popitem()       # 弹出最后插入的键值对（LIFO）
del user['city']

# 查询
'age' in user        # True
len(user)            # 键的个数

# 视图（动态）
user.keys()          # 所有键
user.values()        # 所有值
user.items()         # (键,值) 对

# 遍历（推荐）
for k, v in user.items():
    print(k, v)
```

## 常用命令（方法）
- 访问：`d[key]`、`d.get(key, default)`、`d.setdefault(key, default)`（不存在时写入并返回）。
- 更新：`d[key] = val`、`d.update(other)`、合并：`d1 | d2`（3.9+，右侧覆盖）。
- 删除：`d.pop(key, default)`、`d.popitem()`、`del d[key]`、`d.clear()`。
- 复制：`d.copy()`（浅拷贝）；深拷贝用 `copy.deepcopy(d)`。
- 视图：`d.keys()`、`d.values()`、`d.items()`（动态反映字典变化）。

## 高频场景与技巧
- 计数：
```python
from collections import Counter
Counter(['a','b','a'])  # {'a': 2, 'b': 1}
```
- 分组：
```python
groups = {}
for x in ['US', 'CN', 'US']:
    groups.setdefault(x, []).append(1)
# {'US': [1,1], 'CN': [1]}
```
- 字典推导式：
```python
squares = {x: x*x for x in range(5)}
# {0:0, 1:1, 2:4, 3:9, 4:16}
```
- 按 key/value 排序显示：
```python
sorted_items = sorted(user.items(), key=lambda kv: kv[0])  # 按键
sorted_by_val = sorted(user.items(), key=lambda kv: kv[1]) # 按值
```

## 容易踩雷（简明版）
- 键重复会覆盖：`{'a':1, 'a':2}` -> `{'a':2}`。
- 键必须可哈希：`d[[1,2]] = 'x'` 会报错；可用元组 `d[(1,2)]='x'`。
- 边遍历边修改易出错：先 `list(d.items())` 再改，或生成新字典。
- `popitem()` 是弹出“最后插入”的项，不是随机。
- 浅拷贝不复制嵌套对象：`copy()` 只复制最外层引用，需 `deepcopy`。
- `get` 默认返回 `None`，容易误判；可显式给默认值。
- `setdefault` 会写入字典：仅当“需要默认结构并立即使用”时用。
- 视图是动态的：`keys()/items()` 随字典变化实时更新。
- JSON 键通常要字符串：非字符串键序列化可能会不符合预期。

## 速查清单
- 创建：`{}`, `dict()`, `dict(a=1)`, `dict([(k,v)])`
- 访问：`[]`, `get`, `setdefault`
- 更新/合并：`=`, `update`, `|`
- 删除：`pop`, `popitem`, `del`, `clear`
- 遍历：`for k,v in d.items()`
- 视图：`keys`, `values`, `items`
- 拷贝：`copy`, `deepcopy`
- 推导式：`{k:v for ... if ...}`

## 小示例
```python
# 合并并保留右侧覆盖
cfg = {'host': 'localhost', 'port': 8000}
override = {'port': 8080, 'debug': True}
final = cfg | override
print(final)  # {'host': 'localhost', 'port': 8080, 'debug': True}

# 统计并找 Top-N
from collections import Counter
words = ['a','b','a','c','a','b']
print(Counter(words).most_common(2))  # [('a',3), ('b',2)]

# 安全读取嵌套结构
user = {'profile': {'name': 'Alice'}}
name = user.get('profile', {}).get('name', 'unknown')
print(name)
```
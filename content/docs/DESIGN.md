# DESIGN.md

> **设计规范文档** — 所有 UI 相关任务执行前必须先读此文档。
> Generator 代理生成组件、页面、样式时，以本文档为唯一设计依据。
> 不得在组件代码中自行发明不在本规范内的样式决策。

---

## 1. 设计哲学

**风格定义：日式极简 · MUJI 精神**

> 「これでいい」而非「これがいい」——不是"我想要这个"，而是"这样就够了"。

核心原则：
- **减法优先** — 每一个元素必须有存在的理由，无法说明理由的一律移除
- **留白即设计** — 空白不是空缺，是呼吸感和节奏的载体
- **素材本色** — 颜色来自自然，不使用人工感强烈的饱和色
- **功能即美学** — 界面的美感来自功能的清晰，而非装饰的堆砌
- **一致的克制** — 所有页面保持同一种安静的气质

---

## 2. 色彩系统

所有颜色通过 CSS 变量定义，组件中只使用变量名，不使用硬编码色值。

### 2.1 Tailwind CSS 配置（tailwind.config.ts）

```ts
colors: {
  // 背景层级
  "muji-bg":        "#F7F5F2",   // 主背景 — 温暖的米白，不是纯白
  "muji-bg-card":   "#FDFCFA",   // 卡片背景 — 比主背景略亮
  "muji-bg-hover":  "#F0EDE8",   // hover 状态背景

  // 边框
  "muji-border":    "#E8E4DE",   // 标准边框 — 亚麻色
  "muji-border-strong": "#D4CFC8", // 强调边框

  // 文字层级
  "muji-text-primary":   "#2C2C2C", // 主文字 — 接近黑但不刺眼
  "muji-text-secondary": "#6B6560", // 次要文字 — 温暖灰
  "muji-text-muted":     "#9E9890", // 辅助文字、占位符
  "muji-text-inverse":   "#FDFCFA", // 反色文字（用于深色背景）

  // 功能色
  "muji-accent":    "#8B7355",   // 强调色 — 温暖棕，来自木材
  "muji-accent-hover": "#7A6448",// 强调色 hover

  // 状态色（克制版）
  "muji-success":   "#6B8F71",   // 成功 — 苔绿
  "muji-warning":   "#B8956A",   // 警告 — 琥珀
  "muji-error":     "#A05C5C",   // 错误 — 砖红
  "muji-info":      "#6B82A0",   // 信息 — 青石蓝
}
```

### 2.2 使用规则

```
页面背景        → muji-bg
卡片 / 面板     → muji-bg-card + border muji-border
主要文字        → muji-text-primary
说明文字        → muji-text-secondary
占位符 / 标签   → muji-text-muted
强调按钮        → muji-accent（背景）+ muji-text-inverse（文字）
次要按钮        → transparent + border muji-border + muji-text-primary
危险操作        → muji-error
```

**禁止使用：**
- 任何饱和度 > 40% 的颜色
- 纯白 `#FFFFFF` 或纯黑 `#000000` 作为背景或主文字
- Tailwind 默认色板中的 blue / purple / pink 系列

---

## 3. 字体系统

### 3.1 字体选择

```ts
// next/font 配置
import { Noto_Serif_JP, Noto_Sans_JP } from "next/font/google"

// 标题字体 — 衬线，传递手工质感
const titleFont = Noto_Serif_JP({
  weight: ["300", "400"],
  subsets: ["latin"],
  variable: "--font-title",
})

// 正文字体 — 无衬线，清晰易读
const bodyFont = Noto_Sans_JP({
  weight: ["300", "400", "500"],
  subsets: ["latin"],
  variable: "--font-body",
})
```

> 如果项目为纯英文界面，替换为：
> - 标题：`Cormorant Garamond`（weight 300/400）
> - 正文：`DM Sans`（weight 300/400/500）

### 3.2 字号阶梯

```
--text-xs:   0.75rem  / 12px  — 标签、角标
--text-sm:   0.875rem / 14px  — 辅助说明、表单标签
--text-base: 1rem     / 16px  — 正文基准
--text-lg:   1.125rem / 18px  — 卡片标题、小节标题
--text-xl:   1.25rem  / 20px  — 区块标题
--text-2xl:  1.5rem   / 24px  — 页面主标题
--text-3xl:  1.875rem / 30px  — Hero 标题
```

### 3.3 字重规则

```
页面主标题    → font-light (300)
区块标题      → font-normal (400)
正文内容      → font-normal (400)
强调 / 标签   → font-medium (500)
禁止使用      → font-bold (700) 及以上
```

### 3.4 行高规则

```
标题类        → leading-snug (1.375)
正文类        → leading-relaxed (1.625)
说明文字      → leading-loose (2)
```

---

## 4. 间距系统

**基础单位：8px**，所有间距为 8 的倍数。

```
间距 1  =  8px   → Tailwind: p-2  / gap-2  / m-2
间距 2  = 16px   → Tailwind: p-4  / gap-4  / m-4
间距 3  = 24px   → Tailwind: p-6  / gap-6  / m-6
间距 4  = 32px   → Tailwind: p-8  / gap-8  / m-8
间距 6  = 48px   → Tailwind: p-12 / gap-12 / m-12
间距 8  = 64px   → Tailwind: p-16 / gap-16 / m-16
间距 12 = 96px   → Tailwind: p-24 / gap-24 / m-24
```

### 4.1 布局规则

```
页面最大宽度    → max-w-3xl (768px)   — 窄列，强制聚焦
内容区左右内边距 → px-6 (mobile) / px-8 (desktop)
区块间垂直间距  → space-y-16 或 gap-16
卡片内边距      → p-6 (mobile) / p-8 (desktop)
```

> **核心原则：宁可更窄，不要撑满。** 内容区不超过 768px，两侧留大量空白。

---

## 5. 圆角系统

```
小元素（标签、badge）→ rounded-sm  (2px)
输入框、按钮         → rounded     (4px)
卡片、面板           → rounded-lg  (8px)
模态框               → rounded-xl  (12px)
禁止使用             → rounded-full（除头像/图标外）
```

---

## 6. 阴影系统

MUJI 风格阴影极度克制，只用于区分层级，不用于装饰。

```css
/* 卡片默认 — 几乎感知不到 */
.shadow-muji-sm  { box-shadow: 0 1px 3px rgba(44, 44, 44, 0.06); }

/* 卡片 hover / 浮层 */
.shadow-muji-md  { box-shadow: 0 4px 12px rgba(44, 44, 44, 0.08); }

/* 模态框 / 抽屉 */
.shadow-muji-lg  { box-shadow: 0 8px 32px rgba(44, 44, 44, 0.10); }
```

**禁止使用：** 带颜色的阴影、`drop-shadow` 特效、多层叠加阴影。

---

## 7. 核心组件规范

### 7.1 Button

```
主要按钮（Primary）
  背景: muji-accent | 文字: muji-text-inverse
  hover: muji-accent-hover | 过渡: 150ms ease
  内边距: px-6 py-2.5 | 圆角: rounded | 字重: font-normal

次要按钮（Secondary）
  背景: transparent | 边框: border muji-border
  文字: muji-text-primary
  hover: 背景 muji-bg-hover | 过渡: 150ms ease

危险按钮（Danger）
  背景: transparent | 边框: border muji-error
  文字: muji-error
  hover: 背景 muji-error/10

禁用状态
  opacity-40 | cursor-not-allowed | 不加任何其他样式
```

### 7.2 Input / Textarea

```
背景: muji-bg-card
边框: border muji-border | focus: border muji-accent（不用 ring）
圆角: rounded | 内边距: px-4 py-2.5
文字: muji-text-primary | 占位符: muji-text-muted
过渡: border-color 150ms ease
禁止: focus 时出现蓝色外发光（移除默认 focus:ring）
```

### 7.3 Card

```
背景: muji-bg-card
边框: border muji-border
圆角: rounded-lg
阴影: shadow-muji-sm
hover: shadow-muji-md + 过渡 200ms ease
内边距: p-6 或 p-8
```

### 7.4 Divider（分隔线）

```
颜色: muji-border
粗细: 1px（不用 2px）
样式: solid（不用 dashed 或 dotted）
上下间距: my-8 或 my-12
```

### 7.5 Badge / Tag

```
背景: muji-bg-hover
文字: muji-text-secondary | 字号: text-xs | 字重: font-medium
圆角: rounded-sm | 内边距: px-2 py-0.5
不加边框、不加阴影
```

### 7.6 Empty State（空状态）

```
居中布局 | 图标: 线条风格，32px，muji-text-muted
标题: muji-text-secondary, text-sm, font-normal
说明: muji-text-muted, text-xs
不加装饰性插图
```

---

## 8. 动效规范

MUJI 的动效哲学：**存在感极低，但缺失会被察觉。**

```
标准过渡时长   → 150ms（hover 状态切换）
内容出现       → 200ms ease-out（淡入 + 轻微上移 4px）
模态框         → 250ms ease-out（淡入 + 缩放 0.97 → 1）
页面切换       → 200ms ease（淡入淡出）
```

### 8.1 标准动画类（全局 CSS）

```css
@keyframes muji-fade-in {
  from { opacity: 0; transform: translateY(4px); }
  to   { opacity: 1; transform: translateY(0); }
}

@keyframes muji-scale-in {
  from { opacity: 0; transform: scale(0.97); }
  to   { opacity: 1; transform: scale(1); }
}

.animate-muji-fade  { animation: muji-fade-in  200ms ease-out both; }
.animate-muji-scale { animation: muji-scale-in 250ms ease-out both; }
```

**禁止使用：**
- 弹跳（bounce）、旋转、翻转等活泼动效
- 超过 300ms 的过渡
- 滚动视差效果
- 粒子、光晕、渐变流动特效

---

## 9. 响应式断点

```
mobile   → 默认（< 640px）  单列，内边距 px-6
tablet   → sm: (≥ 640px)   单列，内边距 px-8，字号略增
desktop  → md: (≥ 768px)   内容区居中，max-w-3xl，两侧大量留白
wide     → lg: (≥ 1024px)  布局不变，只增加垂直间距
```

> **原则：不为大屏扩张内容宽度。** 宽屏下两侧留白更大，不是内容更多。

---

## 10. 图标规范

```
图标库       → lucide-react（线条风格，与 MUJI 气质一致）
默认尺寸     → 16px（行内图标）/ 20px（按钮图标）/ 24px（独立图标）
描边粗细     → strokeWidth={1.5}（比默认 2 更纤细）
颜色         → 继承父元素文字色，不单独设置图标色
禁止使用     → 填充风格图标（filled icons）
```

---

## 11. 页面结构模板

```
<body class="bg-muji-bg font-body text-muji-text-primary">

  <!-- 顶部导航 — 极简，无阴影，只有底部细线 -->
  <header class="border-b border-muji-border">
    <nav class="max-w-3xl mx-auto px-6 h-14 flex items-center justify-between">
      <!-- Logo（文字，不用图形）| 导航项（≤ 4个）-->
    </nav>
  </header>

  <!-- 主内容区 -->
  <main class="max-w-3xl mx-auto px-6 py-16 space-y-16">
    <!-- 页面内容 -->
  </main>

  <!-- 底部 — 最简，只有版权 -->
  <footer class="border-t border-muji-border mt-24">
    <div class="max-w-3xl mx-auto px-6 py-8 text-muji-text-muted text-xs">
      <!-- 版权信息 -->
    </div>
  </footer>

</body>
```

---

## 12. 禁止事项（红线）

以下任何一条出现在代码中，视为违反设计规范，Evaluator 应标记为 🟡 警告：

```
[ ] 使用纯白 #FFFFFF 或纯黑 #000000
[ ] 使用 font-bold 或 font-extrabold
[ ] 使用 rounded-full（头像和图标除外）
[ ] 使用 Tailwind 默认 blue / purple / pink 色板
[ ] 使用任意值（如 w-[347px]、text-[13px]）
[ ] 动效时长超过 300ms
[ ] 单个页面出现 3 种以上不同的阴影层级
[ ] 内容区宽度超过 max-w-3xl（768px）
[ ] 使用填充风格（filled）图标
[ ] 卡片或容器叠加超过 2 层背景色
```

---

## 13. 设计自检清单（Evaluator 使用）

每个 UI 任务完成后，对照以下问题检查：

```
[ ] 去掉所有装饰元素后，页面是否仍然清晰传达了功能？
[ ] 页面上最重要的一个操作，用户 3 秒内能找到吗？
[ ] 所有颜色是否来自本文档定义的色彩系统？
[ ] 字重是否没有超过 font-medium？
[ ] 动效是否在 300ms 以内且方向自然？
[ ] 在 375px 宽度下，是否没有任何元素溢出或重叠？
[ ] 留白是否足够——能再减少一个元素吗？
```

---

---

## 14. DropZone 文件拖拽上传

OfficeKit 每个工具页的核心交互元素。

```
容器
  背景: muji-bg-card
  边框: border-2 border-dashed border-muji-border
  圆角: rounded-lg
  内边距: py-12 px-8
  布局: flex flex-col items-center justify-center gap-3

默认状态
  图标: Upload，24px，muji-text-muted，strokeWidth={1.5}
  主文字: "Drop files here" — text-sm, muji-text-secondary, font-normal
  副文字: "or click to browse" — text-xs, muji-text-muted
  过渡: border-color 150ms ease

拖拽悬停状态（dragover）
  边框: border-muji-accent
  背景: muji-bg-hover
  图标颜色: muji-accent

已有文件时
  缩小为细条（py-4）
  显示"Add more files"文字
  不显示副文字

禁止
  不加背景图案或虚线装饰
  不用 rounded-full
  不加阴影
```

---

## 15. File Item 文件列表项

上传后每个文件的展示行。

```
容器
  背景: muji-bg-card
  边框: border border-muji-border
  圆角: rounded
  内边距: px-4 py-3
  布局: flex items-center gap-3

左侧图标
  File / FileText 图标，16px，muji-text-muted，strokeWidth={1.5}

文件信息（flex-1）
  文件名: text-sm, muji-text-primary, font-normal, truncate
  文件大小: text-xs, muji-text-muted（格式：1.2 MB）

右侧操作
  删除按钮: X 图标，16px，muji-text-muted
  hover: muji-error，过渡 150ms ease
  不加边框、不加背景

处理成功状态
  右侧显示 CheckCircle 图标，16px，muji-success

处理失败状态
  整行边框变为 muji-error/30
  右侧显示 AlertCircle 图标，16px，muji-error
```

---

## 16. Loading / Spinner

文件处理期间的等待状态。

```
Spinner（行内加载）
  元素: 圆形 border，border-muji-border，border-t-muji-accent
  尺寸: 16px（行内）/ 20px（按钮内）/ 24px（页面级）
  动画: spin 600ms linear infinite
  禁止: 使用彩色多段 spinner

按钮加载状态
  按钮内左侧显示 16px spinner
  文字变为 "Processing…"
  按钮 disabled + opacity-60
  禁止按钮消失或跳动

页面级加载（大文件处理）
  居中显示 24px spinner + 文字说明
  文字: text-sm, muji-text-secondary, "Processing your file…"
  不加遮罩层，不加模态框
```

CSS：
```css
@keyframes muji-spin {
  to { transform: rotate(360deg); }
}
.animate-muji-spin {
  animation: muji-spin 600ms linear infinite;
}
```

---

## 17. Progress Bar 进度条

大文件处理时显示进度。

```
容器
  高度: h-1（4px）— 极细，不抢视觉
  背景: muji-bg-hover
  圆角: rounded-full（进度条是少数可用 rounded-full 的例外）
  宽度: w-full

进度填充
  背景: muji-accent
  圆角: rounded-full
  过渡: width 200ms ease

文字说明（进度条下方）
  text-xs, muji-text-muted
  格式: "Processing… 64%" 或 "2 of 3 files done"
  右对齐

禁止
  不加条纹动画
  不加闪烁效果
  不显示多余的数字框
```

---

## 18. Toast 通知

操作完成或失败后的轻量反馈，3 秒后自动消失。

```
位置: 右下角固定，bottom-6 right-6，z-50
宽度: w-72，不超过屏幕宽度

容器
  背景: muji-bg-card
  边框: border border-muji-border
  圆角: rounded-lg
  阴影: shadow-muji-md
  内边距: px-4 py-3
  布局: flex items-start gap-3

左侧图标（16px，strokeWidth={1.5}）
  成功: CheckCircle — muji-success
  错误: AlertCircle — muji-error
  信息: Info — muji-info
  警告: AlertTriangle — muji-warning

文字区（flex-1）
  标题: text-sm, muji-text-primary, font-normal
  说明: text-xs, muji-text-muted（可选）

关闭按钮
  X 图标，14px，muji-text-muted
  hover: muji-text-primary，过渡 150ms

出现动画: animate-muji-fade（从右侧 translateX(8px) 淡入）
消失动画: opacity 0，200ms ease-in

多条 Toast: 垂直堆叠，gap-2，新的在上方
```

---

## 19. Error State 错误状态

API 失败、网络错误、文件处理失败时的页面级提示。

```
容器
  背景: muji-error/5（极淡红）
  边框: border border-muji-error/30
  圆角: rounded-lg
  内边距: px-4 py-3
  布局: flex items-start gap-3

左侧图标
  AlertCircle，16px，muji-error，strokeWidth={1.5}

文字
  错误标题: text-sm, muji-error, font-normal
  错误说明: text-xs, muji-text-muted（说明原因或建议操作）

操作（可选）
  右侧放次要按钮"Try again"
  text-xs, muji-text-secondary, underline-offset-2, hover:underline

禁止
  不用红色背景大块铺满
  不用感叹号图标（用 AlertCircle 替代）
  不加动效（错误状态应该稳定，不闪烁）
```

---

## 20. Download Button 下载按钮

文件处理完成后的专属下载操作。

```
样式: 主要按钮（Primary）基础上加图标
图标: Download，16px，左侧，strokeWidth={1.5}
文字: "Download" 或 "Download PDF"
布局: flex items-center gap-2

处理完成后出现动画: animate-muji-fade
出现前不渲染（不用 opacity-0 占位）

文件大小提示（按钮下方）
  text-xs, muji-text-muted
  格式: "2.4 MB · PDF"

多文件下载
  显示"Download All (3 files)"
  或逐个显示下载按钮，垂直排列，gap-2
```

---

## 21. Modal 确认弹窗

用于删除确认、危险操作二次确认等场景。

```
遮罩层
  背景: rgba(44, 44, 44, 0.3)（不用纯黑）
  不加 blur 效果

弹窗容器
  背景: muji-bg-card
  边框: border border-muji-border
  圆角: rounded-xl
  阴影: shadow-muji-lg
  内边距: p-8
  宽度: w-full max-w-sm（不超过 384px）
  位置: 屏幕垂直居中

标题
  text-lg, muji-text-primary, font-normal

说明文字
  text-sm, muji-text-secondary, leading-relaxed, mt-2

按钮区
  mt-8, flex gap-3, justify-end
  取消: 次要按钮
  确认（危险操作）: 危险按钮
  确认（普通操作）: 主要按钮

出现动画: animate-muji-scale
关闭: 点击遮罩层或取消按钮，200ms 淡出

禁止
  不加标题图标
  不加彩色顶部条
  不用 rounded-full 按钮
```

---

## 22. Select 下拉选择

```
外观与 Input 保持一致
  背景: muji-bg-card
  边框: border muji-border | focus: border muji-accent
  圆角: rounded | 内边距: px-4 py-2.5
  文字: muji-text-primary
  右侧图标: ChevronDown，16px，muji-text-muted

选项列表
  背景: muji-bg-card
  边框: border muji-border
  圆角: rounded-lg
  阴影: shadow-muji-md
  每项内边距: px-4 py-2.5
  hover: 背景 muji-bg-hover
  选中项: 文字 muji-accent，右侧 Check 图标 16px

禁止
  不用浏览器默认 select 样式（使用自定义实现）
  不加彩色选中高亮背景
```

---

## 23. Form Label & Form Error 表单标签与错误

```
Label
  text-sm, muji-text-secondary, font-normal
  位置: Input 上方，mb-1.5
  必填标记: 文字后加 * ，颜色 muji-error，不加说明文字

Form Error（字段级错误）
  text-xs, muji-error
  位置: Input 下方，mt-1.5
  左侧加 AlertCircle 图标，12px
  不加边框、不加背景

表单组间距
  每个字段组（Label + Input + Error）之间: space-y-5
```

---

## 24. Header & Footer 组件规范

### 24.1 Header

```
高度: h-14（固定）
背景: muji-bg（与页面背景相同，无阴影）
底部边框: border-b border-muji-border
内容区: max-w-3xl mx-auto px-6，flex items-center justify-between

Logo
  纯文字，font-normal，text-base，muji-text-primary
  不加图形、不加 icon、不加 bold

导航项（最多 4 个）
  text-sm, muji-text-secondary
  hover: muji-text-primary，过渡 150ms
  当前页: muji-text-primary（不加下划线、不加背景）
  间距: gap-6

移动端
  导航项隐藏，显示 Menu 图标（Hamburger），24px
```

### 24.2 Footer

```
上方边框: border-t border-muji-border
内边距: py-8
内容区: max-w-3xl mx-auto px-6
布局: flex items-center justify-between（或单行居左）

版权文字
  text-xs, muji-text-muted, font-normal

链接（可选）
  text-xs, muji-text-muted
  hover: muji-text-secondary，过渡 150ms
  间距: gap-4

禁止
  不加背景色（与页面背景相同）
  不加图标堆砌
  不加社交媒体图标（除非明确需要）
```

---

## 25. Checkbox & Radio

```
Checkbox
  尺寸: 16px × 16px
  边框: border muji-border，圆角 rounded-sm
  选中: 背景 muji-accent，边框 muji-accent
  勾选图标: Check，10px，muji-text-inverse
  focus: outline none，border muji-accent

Radio
  尺寸: 16px × 16px
  边框: border muji-border，圆角 rounded-full（Radio 是例外）
  选中: 内圆 6px，背景 muji-accent

Label 文字
  text-sm, muji-text-primary，ml-2.5
  行内对齐: flex items-center gap-2.5

禁止
  不用浏览器默认样式
  不加彩色选中状态
```

---

*DESIGN.md · MUJI 极简风格 · 与 AGENTS.md + GENERATOR.md + EVALUATOR.md 配套使用*
*所有设计决策以本文档为准，组件代码不得包含本文档未定义的样式规则*
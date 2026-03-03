# 设计风格描述

## 特定元素格子风格
#### 1. 极简磨砂玻璃
- 视觉：柔和磨砂、低饱和半透明底、干净圆角；标题与金额保持高对比清晰可读
- 技术：backdrop-blur-md + bg-white/10（暗色为 bg-white/5）+ border-white/20（暗色为 white/10）+ 轻微阴影
- 性能：低到中；满足流畅性与质感的平衡
- 适配：深浅色通用，英文字体与数字对比度最佳

#### 2. 渐变边框玻璃
- 视觉：卡片外圈渐变边框与内阴影，层次更强、精致感更高
- 技术：玻璃底上再加渐变边框叠层（可用伪元素或额外容器），保持主体文本清晰
- 性能：中等；边框渲染与叠层略增成本
- 适配：适合强调视觉存在感的场景

#### 3. 极光动效玻璃
- 视觉：柔和彩色渐变与微光泽滑动动画，交互更炫、更“活”
- 技术：玻璃底 + 轻微彩色渐变 + Framer Motion 小幅度光泽位移；Hover 提升 blur/shadow
- 性能：中到高；在低性能设备可降级关闭动画
- 适配：适合需要更强吸引力的仪表区域

## 任务卡设计风格
#### The "Settings" List (原生列表风)
核心理念 ：致敬 iOS 设置页面的极简主义。 视觉特点 ：
- 布局 ：全宽或大圆角分组列表 (Inset Grouped)，极度整洁。
- 细节 ：左侧是圆角矩形图标（类似设置里的功能图标），右侧是金额和箭头。
- 色彩 ：背景纯白（Dark Mode 为深灰），依靠精细的分割线和排版区分层级。
- 亮点 ：分类颜色仅作为左侧图标的背景色，非常克制。
- 适用场景 ：如果您希望应用看起来像系统原生应用一样专业、冷静。

#### The "App Store" Card (现代浮动风)
核心理念 ：模仿 App Store "Today" 标签页或现代 iOS 组件。 视觉特点 ：
- 布局 ：独立的卡片，拥有较大的圆角 (Rounded-3xl) 和柔和的弥散阴影。
- 细节 ：卡片有轻微的悬浮感，点击时有细腻的缩放动画。
- 色彩 ：卡片背景带有极其轻微的分类颜色倾向（比如 Health 类卡片背景泛着极淡的绿色），或者在卡片左侧有一条鲜艳的色条 (Accent Bar)。
- 亮点 ：金额数字加粗放大，视觉冲击力强。
- 适用场景 ：如果您希望应用看起来现代、年轻、有活力。

#### The "Wallet" Pass (磨砂透视风)
核心理念 ：灵感来自 Apple Wallet 的票据和 Control Center 的毛玻璃效果。 视觉特点 ：
- 布局 ：高饱和度的视觉风格。
- 细节 ：使用 Glassmorphism (毛玻璃) 效果。如果是在 Dark Mode 下，卡片背景是半透明的，透出底部的壁纸或颜色。
- 色彩 ：分类颜色作为卡片的主色调（渐变背景），文字反白。例如 Health 订阅就是一张绿色的卡片。
- 亮点 ：看起来像一张张精致的会员卡或票据，非常有质感。
- 适用场景 ：如果您希望应用在视觉上非常惊艳，且分类区分度极高。

## 分类时尚颜色风格
#### Soft Pastel（清爽高级的马卡龙）
- 适合：偏生活方式、轻量 UI、想要“干净但不无聊”的感觉
- 特点：低饱和 + 高明度，分类多也不刺眼
- 建议用法：标签底色用 100-200 明度，文字用同色系更深一档（或统一深色字）
配色（主色 / 浅底色）：

- Coral： #FF6B6B / #FFE3E3
- Peach： #FF9F68 / #FFE9DC
- Butter： #F2C94C / #FFF4CC
- Mint： #2ED3B7 / #D9FBF5
- Sky： #56CCF2 / #DDF3FF
- Lavender： #9B8AFB / #E9E6FF
- Rose： #F26BAA / #FFE0EE
- Slate（中性/其它）： #6B7280 / #EEF2F7

#### Neo Neon（暗色系霓虹，科技潮流）
- 适合：深色模式为主、偏“潮”“酷”“赛博”的产品气质
- 特点：高对比、识别度极强，适合少量点缀（不要大面积铺满）
- 建议用法：暗底上用主色做描边/小块色，文字尽量用白或接近白；浅底用“发光色”会太亮不耐看
配色（霓虹主色 / 暗底推荐）：

- Neon Cyan： #00E5FF / #0B1220
- Electric Purple： #8B5CF6 / #0B1220
- Laser Pink： #FF3DAB / #0B1220
- Acid Lime： #B6FF00 / #0B1220
- Neon Orange： #FF7A00 / #0B1220
- Plasma Red： #FF2E2E / #0B1220
- Vivid Blue： #3B82F6 / #0B1220
- Graphite（中性/其它）： #94A3B8 / #0B1220

#### Modern Neutral + Accent（克制的中性色 + 时尚点睛色）
- 适合：偏商务、订阅管理/记账类、追求“耐看”和“质感”
- 特点：整体统一高级，分类靠少量“点睛色”区分，不会花
- 建议用法：所有分类统一使用中性浅底（例如 #F5F6F8 ），仅用不同 accent 做左侧色条/圆点/图标；可显著提升一致性
中性底（统一）：

- Base BG： #F5F6F8
- Border： #E6E8EE
- Text： #111827
点睛色（分类只变这一项）：

- Cobalt： #2563EB
- Teal： #0EA5A4
- Emerald： #10B981
- Amber： #F59E0B
- Coral： #FB7185
- Violet： #7C3AED
- Sky： #38BDF8
- Charcoal（其它）： #374151

#### iOS System Colors（最符合 Apple 的系统色）
- 适合：想要“一眼像 iOS”，分类标签/图标/小色点都好用
- 用法建议：同一分类用“主色 + 很浅的底色”（浅底色用于 badge 背景或列表左侧条）
颜色（主色 / 浅底色）：

- Blue： #007AFF / #EAF3FF
- Green： #34C759 / #E9F8EE
- Orange： #FF9500 / #FFF2E0
- Red： #FF3B30 / #FFE9E8
- Purple： #AF52DE / #F3E9FB
- Teal： #5AC8FA / #E6F7FF
- Yellow： #FFCC00 / #FFF7D6
- Pink： #FF2D55 / #FFE6EC
- Indigo： #5856D6 / #EBEBFF
- Gray（其它/未知）： #8E8E93 / #F2F2F7

#### Apple Neutral + Single Accent（极简中性 + 单一品牌强调色）
- 适合：整体更“Apple 官网/系统设置”质感，分类很多也不花
- 用法建议：所有分类统一中性浅底，仅用一个 accent 做“选中态/关键分类/CTA”；分类区分靠图标/SF 风格而不是靠彩虹色
基底（统一）：

- Background： #F5F5F7
- Card： #FFFFFF
- Separator： #E5E5EA
- Primary Text： #111111
- Secondary Text： #6E6E73
强调色（选一个即可）：

- Apple Blue（推荐）： #007AFF
- 或更克制一点： #0A84FF （偏深色模式也稳）


#### Vibrancy Pastel（更时尚但仍像 Apple 的“通透浅彩”）
- 适合：想保留 Apple 的干净，但比系统色更“温柔高级”
- 用法建议：浅色背景 + 低饱和浅底做分类 badge；文字用深灰，避免每个分类都用彩色字
配色（浅底色 / 对应主色点缀）：

- Mist Blue： #EAF3FF / #007AFF
- Sage： #EAF7EF / #34C759
- Apricot： #FFF1E6 / #FF9500
- Blush： #FFE8EE / #FF2D55
- Lilac： #F2ECFF / #5856D6
- Iris： #F3E9FB / #AF52DE
- Lemon： #FFF7D6 / #FFCC00
- Neutral： #F2F2F7 / #8E8E93
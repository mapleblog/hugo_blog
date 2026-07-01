重新设计并优化订阅卡表格中category选择菜单的**视觉样式与交互体验**。要求实现现代化**下拉菜单组件**，包含以下具体改进：统一配色方案与品牌视觉规范，增加**悬停高亮**与**选中状态反馈**，优化**字体层级**与**间距提升可读性**，添加**平滑展开动画过渡效果**，确保在**桌面端**和**移动端均具备良好的响应式表现**。**需兼容现有表单验证逻辑，保持与表格其他元素的风格一致性，并通过多浏览器测试验证无样式冲突**。最终**交付包含更新后的CSS样式文件、重构的HTML结构以及交互行为测试用例**。

将amount字段的汇率选择功能从当前样式改为与category字段相同的下拉菜单交互效果。
具体要求：
1) 保持与category下拉菜单一致的UI样式、动画效果和交互逻辑；
2) 确保下拉列表支持键盘导航、点击外部关闭等标准行为；
3) 汇率选项数据需动态加载并正确绑定到amount字段；
4) 完成修改后需验证下拉列表在桌面端和移动端的显示一致性，并通过单元测试确保功能与category下拉菜单保持同步更新



**居中布局适合**

- 正文内容区：菜单列表、文章段落、联系信息——内容行太长会影响阅读，`max-width` 控制行宽更舒适
- 表单、卡片组合——视觉上更聚焦

**全宽铺满适合**

- 导航栏 Header——横跨全屏有"锚定"感，边界清晰
- Hero 区——大图、大标题需要视觉张力，全宽冲击力更强
- 背景色块分割区——整行换色时必须全宽，否则色块会断掉


**Project Requirement Document** - Project name, Project Description, Project Functionality, Pain Point, Resolve Expectation, Business Logic, Target Users 
**Scaffold** - Initial related folder & files with code without UI components / page sections
**page section** - navbar, hero, feature, footer, social, pricing

**Use CLAUDE.md to set a standing rule** `Wireframe` 
When asked to create a wireframe or layout draft, output structure only:
- Plain semantic HTML or | JSX 纯语义HTML或JSX
- No CSS, no Tailwind, no styled-components, no inline styles | 没有CSS，没有顺风，没有样式组件，没有内联样式
- Use bordered placeholder boxes or text labels for content blocks | 对内容块使用带边框的占位符框或文本标签
- Do not suggest colors, fonts, or spacing
Styling is a separate, explicit follow-up step | 不建议颜色、字体或间距
样式化是单独的、显式的后续步骤



---



**Semantic correctness** — read through the tag choices rather than the appearance. Is <header>, <nav>, <main>, <footer> used appropriately? Are headings nested in a sensible order (one h1, then h2s for major sections, h3/h4 for subsections)? In your file this looks right — hero h1, section h2s, item/card h3s, news-list h4s.
**Content completeness** — does every placeholder represent something you actually intend to have content for? Walk through and ask "do I have real copy/images for this eventually?" For example here: logo, 4 nav links, CTA, hero headline/subhead/two CTAs/image, 4 menu items, featured news article, 3 secondary news items, social links + 4-post feed, footer with 3 link columns, newsletter form, copyright + legal links. If something's missing or something's there that you don't actually need, now's the cheap time to fix it.
**Logical grouping** — are related things wrapped together? E.g. each menu item's image/title/description/price as one <li>, each news item's thumbnail/title/date together. That's true here.
**Accessibility scaffolding** — aria-labels on sections/nav, alt-worthy image placeholders, <label for> tied to the input. You've got most of this already (e.g. aria-label="Hero", aria-label="Social media links").
### Ask Claude refer AGENTS template and create new AGENT skill.md

I want to create a SKILL.md, when user trigger "create new agents.md" or "create a agents.md" . Ask user provide the AGENTS.md template, you will read and analyze it, after finished read and ready, ask user to describe the new project and communicate with user to explore more details. 


Required follow new project and modify content title: 

**§ 1. Project Overview**
**§ 5. Commands & Tooling**

Once everything finalize, start to generate new project AGENTS.md, the content title and format must 100% follow the template user given. Disallow add or remove any title by self-assertion. main language must is English



**项目身份**（名称、一句话定位、目标用户、解决什么问题）

**核心功能**（MVP 要什么，后续阶段要什么）

**技术栈与部署**（语言/框架、关键依赖、部署目标）

**当前阶段与 DoD**（在哪个 phase，完成标准是什么）

**硬约束与 Out of Scope**（哪些是底线，哪些明确不做）

**是否需要 DESIGN.md / MIGRATION.md / SECURITY.md**



---



### Refer AGENT content, Refer GENERATOR template, generate new GENERATOR skill.md

I want to create a SKILL.md, when user trigger "create a generator" or "create new generator". Ask user provide **AGENTS.md** of new project information & **GENERATOR.md** of **GENERATOR.md** template, you will read and analyze these 2 files. After finished and ready, starting to generate high match **GENERATOR.md** to fit to the new project **AGENTS.md**. 



Required follow new project and modify content title:


§1 Project Background - 必须对照 **AGENTS.md**

§1 Scaffold — 如果 ToDoList 不需要 `--src-dir` 或其他 create-next-app 参数，调整初始化命令。 

§2 Install Dependencies — OfficeKit 装了 `pdf-lib`、`sharp`、`formidable`、`qrcode`，ToDoList 完全不需要这些。换成 ToDoList 实际需要的包，比如数据库客户端（`prisma`、`sqlite3`）、状态管理等。

 §3 Create Folder Structure — 这是改动最大的地方。OfficeKit 的 `src/modules/pdf/`、`src/modules/image/`、`src/modules/qrcode/` 全部要换成 ToDoList 的目录结构，比如 `src/modules/tasks/`、`src/modules/lists/` 等。 

§4 Placeholder Files — 所有 stub 文件的路径和内容都跟模块名绑定，需要完全重写。`modules.ts` 的 MODULES 注册表也要换成 ToDoList 的功能条目。 

§5 Environment & Config — `.env.example` 里的变量要换，`next.config.ts` 的 `bodySizeLimit` ToDoList 可能不需要，Dockerfile 和 docker-compose 基本可以复用。 

§7 Verification — 预期目录树要改成 ToDoList 的实际结构。


## Require to declare 
- Deployment Target:  Options: [ Local Physical Server | Cloud VPS | Docker Container | Vercel | Netlify ]  
- Selected: ___  
- Rationale: ___




Once everything finalize, start to create **GENERATOR.md**, the content title and format must 100% follow the template user given. Disallow add or remove any title by self-assertion. main language must is **English**



----

### Refer AGENT content, Refer GENERATOR template, generate new GENERATOR skill.md



I want to create a SKILL.md, when user trigger "create a evaluator" or "create new evaluator". Ask user provide **AGENTS.md** of new project information & **EVALUATOR.md** of **EVALUATOR.md** template, you will read and analyze these 2 files. After finished and ready, starting to generate high match **EVALUATOR.md** to fit to the new project **AGENTS.md**.

Required follow new project and modify content title:

- **§3 The file processing security special project of Dimension B**
- **§9 Phase Gate‘s Smoke Test**


if the project using **Dockerfile** to implement, please make sure docker rules following:
Dockerfile 规范检查
[ ] Base image 锁定具体版本，不使用 latest
    grep "^FROM" Dockerfile | grep -v "latest" — 应有结果

[ ] 容器以非 root 用户运行
    docker inspect surveykit:phase-N-check --format='{{.Config.User}}' — 不应为空或 root

[ ] .dockerignore 存在且包含 .env
    grep "\.env" .dockerignore — 应有结果

[ ] CMD 使用 JSON 数组格式
    grep "^CMD" Dockerfile | grep "\[" — 应有结果

[ ] 镜像内不含 secrets（docker history 验证）
    docker history surveykit:phase-N-check | grep -i "secret\|api_key\|password" — 应无结果


The rest - the four-dimensional evaluation standard table, EVAL_REPORT format, FIX/ESCALATE decision instruction, round cap, LOGS.md format, Deployer handover statement, document write permission table - ** all can be reused directly without any modification **

Once everything finalize, start to create **EVALUATOR.md**, the content title and format must 100% follow the template user given. Disallow add or remove any title by self-assertion.

The **SKILL.md** output file must be written in **English**. The **EVALUATOR.md** output file must be written in **English**.

------

### 生成 DESIGN.md



I want to create a SKILL.md, when user trigger "create a design.md" or "create new design.md". Ask user provide **AGENTS.md** of new project information & **DESIGN.md** of **DESIGN.md** template, you will read and analyze these 2 files. You necessary perform Interactive communication with user to confirm all the details and information and replace the real information to the **placeholder**. After finished and ready, start to **DESIGN.md**.

Required follow new project and replace real information to following section content title:

- **§1 Design Philosophy** `[PROJECT_STYLE_NAME]`, `[PROJECT_STYLE_MOTTO]`, `[PRINCIPLE_1~5_NAME]`, `[PRINCIPLE_1~5_DESC]`
- **§2 Colour System** `[PREFIX]`, `[BG_PRIMARY]`, `[BG_CARD]`, `[BG_HOVER]`, `[BORDER_DEFAULT]`, `[BORDER_STRONG]`, `[TEXT_PRIMARY]`, `[TEXT_SECONDARY]`, `[TEXT_MUTED]`, `[TEXT_INVERSE]`, `[ACCENT]`, `[ACCENT_HOVER]`, `[COLOR_SUCCESS]`, `[COLOR_WARNING]`, `[COLOR_ERROR]`, `[COLOR_INFO]`, `[PROJECT_FORBIDDEN_COLORS]`
- ** §3 Typography System** `[FONT_DISPLAY_IMPORT]`, `[FONT_BODY_IMPORT]`, `[FONT_DISPLAY_RATIONALE]`, `[FONT_BODY_RATIONALE]`, `[DISPLAY_WEIGHT_1~2]`, `[BODY_WEIGHT_1~3]`
- **§4 Spacing System** `[MAX_WIDTH]`
- **§5 Border Radius System** `[PROJECT_SPECIAL_RADIUS]` *(optional — only if the project uses a non-standard radius)*
- **§6 Shadow System** `[SHADOW_RGB]`
- **§7 Core Component Specifications** `[PREFIX]` *(propagated from §2 — no new values needed)*
- **§8 Motion & Animation** `[ANIMATION_PHILOSOPHY]`, `[PROJECT_FORBIDDEN_ANIMATIONS]`
- **§9 Responsive Breakpoints** `[MAX_WIDTH]`, `[PROJECT_WIDE_BEHAVIOR]`
- **§10 Icon Specification** No placeholders — fully reusable as-is.
- **§11 Page Structure Template** `[PREFIX]`, `[MAX_WIDTH_VALUE]`, `[PROJECT_NAME]`
- **§12 Prohibited Items** `[MAX_WIDTH]`, `[PROJECT_ADDITIONAL_WARNINGS]`
- **§13 Design Quality Checklist** No placeholders — fully reusable as-is.

The **SKILL.md** output file must be written in **English**. The **DESIGN.md** output file must be written in **English**.




### Ask Claude refer AGENTS template and create new AGENT skill.md

I want to create a SKILL.md, when user trigger "create new agents.md" or "create a agents.md" . Ask user provide the AGENTS.md template, you will read and analyze it, after finished read and ready, ask user to describe the new project and communicate with user to explore more details. 

Required follow new project and modify content title: ## 1. Project Overview ## 5. Commands & Tooling

Once everything finalize, start to generate new project AGENTS.md, the content title and format must 100% follow the template user given. Disallow add or remove any title by self-assertion. main language must is English



---



### Refer AGENT content, Refer GENERATOR template, generate new GENERATOR skill.md

I want to create a SKILL.md, when user trigger "create a generator" or "create new generator". Ask user provide **AGENTS.md** of new project information & **GENERATOR.md** of **GENERATOR.md** template, you will read and analyze these 2 files. After finished and ready, starting to generate high match **GENERATOR.md** to fit to the new project **AGENTS.md**. 



Required follow new project and modify content title:



§1 Scaffold — 如果 ToDoList 不需要 `--src-dir` 或其他 create-next-app 参数，调整初始化命令。 

§2 Install Dependencies — OfficeKit 装了 `pdf-lib`、`sharp`、`formidable`、`qrcode`，ToDoList 完全不需要这些。换成 ToDoList 实际需要的包，比如数据库客户端（`prisma`、`sqlite3`）、状态管理等。

 §3 Create Folder Structure — 这是改动最大的地方。OfficeKit 的 `src/modules/pdf/`、`src/modules/image/`、`src/modules/qrcode/` 全部要换成 ToDoList 的目录结构，比如 `src/modules/tasks/`、`src/modules/lists/` 等。 

§4 Placeholder Files — 所有 stub 文件的路径和内容都跟模块名绑定，需要完全重写。`modules.ts` 的 MODULES 注册表也要换成 ToDoList 的功能条目。 

§5 Environment & Config — `.env.example` 里的变量要换，`next.config.ts` 的 `bodySizeLimit` ToDoList 可能不需要，Dockerfile 和 docker-compose 基本可以复用。 

§7 Verification — 预期目录树要改成 ToDoList 的实际结构。



Once everything finalize, start to create **GENERATOR.md**, the content title and format must 100% follow the template user given. Disallow add or remove any title by self-assertion. main language must is English



---



(You will check the location **/docs/templates/** to see whether have a file called GENERATOR.md, if yes, you will refer the file use as a base and you will need to fully follow the format from the GENERATOR.md template.)
# Caddy Reverse Proxy

使用**Caddy**在windows环境实现本地反向代理。
Caddy 反代 + 内部 CA HTTPS）完整落地流程（Windows）

## 第一步

- 1) **选一个域名（推荐本机先跑通）**

  本机： integrations.localhost

  局域网： integrations.lan （可选）

- 2) **配置 hosts**

  编辑： C:\Windows\System32\drivers\etc\hosts

  本机加一行：

  ```text
  127.0.0.1 integrations.localhost
  ```

  局域网加一行（把 IP 换成服务机 IP）：

  ```text
  192.168.100.189 integrations.lan
  ```

3) **安装并信任 Caddy（管理员 PowerShell）**

- 安装（若已装可跳过）：

https://chocolatey.org/install#individual

```powershell
choco install caddy -y
```

- 信任 Caddy 的本地根证书（关键）：

```powershell
caddy trust
```

4) **启动 Next.js（HTTP 本地端口）**

- 在项目目录：

```powershell
npm run dev
```

- 如果要让局域网设备也能访问（可选）：

```powershell
npx next dev -H 0.0.0.0 -p 3000
```

5. **启动 Caddy 反代为 HTTPS**

- 在任意目录新建 Caddyfile （内容二选一）：
  - 本机：
  
  ```caddyfile
  integrations.localhost {
    tls internal
    reverse_proxy 127.0.0.1:3000
  }
  ```
  
  - 局域网
  
  ```caddyfile
  integrations.lan {
    tls internal
    reverse_proxy 127.0.0.1:3000
  }
  ```
  
  - 运行：
  
  ```powershell
  caddy run --config .\Caddyfile
  ```



> [!TIP]
> 创建 Caddyfile（推荐先用 8443，避免 443 被占用）
>
> ```caddyfile
> {
> admin 127.0.0.1:2019
> http_port 8080
> https_port 8443
> }
> 
> integrations.localhost:8443 {
> tls internal
> reverse_proxy 127.0.0.1:3000
> }
> 
> integrations.lan:8443 {
> tls internal
> reverse_proxy 127.0.0.1:3000
> }
> ```
>
> 



## 第二步

1. **准备 hosts（本机 + 可选局域网）**

   编辑 C:\Windows\System32\drivers\etc\hosts （需要管理员权限）：

   本机：

   ```text
   127.0.0.1 integrations.localhost
   ```

   局域网（可选，你这台机器 IP 是 192.168.100.189）：

   ```text
   192.168.100.189 integrations.lan
   ```

2. **创建 Caddyfile（推荐先用 8443，避免 443 被占用）**

   ```caddyfile
   {
     admin 127.0.0.1:2019
     http_port 8080
     https_port 8443
   }
   
   integrations.localhost:8443 {
     tls internal
     reverse_proxy 127.0.0.1:3000
   }
   
   integrations.lan:8443 {
     tls internal
     reverse_proxy 127.0.0.1:3000
   }
   ```

3. **启动 Caddy（必须保持运行）**
   开一个“管理员 PowerShell”：

   ```powershell
   cd C:\caddy
   caddy run --config .\Caddyfile --adapter caddyfile
   ```

   看到类似 “admin endpoint started … 127.0.0.1:2019” 才算起来了。

4. **再执行 trust（另一个管理员 PowerShell）**

   ```powershell
   caddy trust --address 127.0.0.1:2019
   ```

5. **用 HTTPS 访问（此时下载会跟着变 HTTPS）**

   - 本机：
     - https://integrations.localhost:8443
   - 局域网（可选）：
     - https://integrations.lan:8443


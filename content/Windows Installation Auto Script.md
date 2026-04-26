## 📋 Part 1: Prerequisites & Folder Structure

### Create the required folders on your D: drive (or any drive with 100GB+ free space):

Open **File Explorer** and create:
```text
D:\
├── WDS\           (WDS working directory)
├── ISO\           (store Windows ISO files)
├── Mount\         (temporary mount for editing install.wim)
└── Scripts\       (cleanup PowerShell scripts)
```


Run **PowerShell as Administrator** to create them:

```powershell
New-Item -Path "D:\WDS", "D:\ISO", "D:\Mount", "D:\Scripts" -ItemType Directory -Force
```



---



## 📥 Part 2: Prepare the Cleanup Script

### Step 1: Create Cleanup.ps1

Open **Notepad**, copy the entire script below, and save as `D:\Scripts\Cleanup.ps1`

```powershell
# Cleanup.ps1 - Runs automatically after Windows installation
$LogFile = "$env:SystemRoot\Temp\Cleanup.log"
Start-Transcript -Path $LogFile -Append

Write-Host "=========================================" -ForegroundColor Green
Write-Host "   Starting Windows Cleanup" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green

# 1. Remove provisioned Appx packages (bloatware)
Write-Host "[1/5] Removing pre-installed apps..." -ForegroundColor Yellow

$AppsToRemove = @(
    "Microsoft.BingWeather", "Microsoft.GetHelp", "Microsoft.Getstarted",
    "Microsoft.Microsoft3DViewer", "Microsoft.MicrosoftOfficeHub",
    "Microsoft.MicrosoftSolitaireCollection", "Microsoft.MixedReality.Portal",
    "Microsoft.Office.OneNote", "Microsoft.OneConnect", "Microsoft.People",
    "Microsoft.Print3D", "Microsoft.SkypeApp", "Microsoft.WindowsAlarms",
    "Microsoft.WindowsCamera", "Microsoft.WindowsFeedbackHub", "Microsoft.WindowsMaps",
    "Microsoft.WindowsSoundRecorder", "Microsoft.Xbox.TCUI", "Microsoft.XboxApp",
    "Microsoft.XboxGameCallableUI", "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxIdentityProvider", "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.YourPhone", "Microsoft.ZuneMusic", "Microsoft.ZuneVideo"
)

$RemovedCount = 0
foreach ($App in $AppsToRemove) {
    $Package = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq $App }
    if ($Package) {
        Remove-AppxProvisionedPackage -Online -PackageName $Package.PackageName -ErrorAction SilentlyContinue
        Write-Host "  Removed: $App" -ForegroundColor Green
        $RemovedCount++
    }
}
Write-Host "  Removed $RemovedCount apps" -ForegroundColor Cyan

# 2. Disable unnecessary services
Write-Host "[2/5] Disabling background services..." -ForegroundColor Yellow

$ServicesToDisable = @(
    @{Name="XblAuthManager"; Display="Xbox Live Auth Manager"},
    @{Name="XboxNetApiSvc"; Display="Xbox Live Network"},
    @{Name="PcaSvc"; Display="Program Compatibility Assistant"},
    @{Name="WSearch"; Display="Windows Search"}
)

foreach ($Service in $ServicesToDisable) {
    Set-Service -Name $Service.Name -StartupType Disabled -ErrorAction SilentlyContinue
    Stop-Service -Name $Service.Name -Force -ErrorAction SilentlyContinue
    Write-Host "  Disabled: $($Service.Display)" -ForegroundColor Green
}

# 3. Disable scheduled background tasks
Write-Host "[3/5] Disabling scheduled tasks..." -ForegroundColor Yellow

$TasksToDisable = @(
    "Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
    "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
    "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
)

foreach ($TaskPath in $TasksToDisable) {
    $TaskName = $TaskPath.Split('\')[-1]
    $TaskFolder = $TaskPath.Replace("\$TaskName", "")
    Disable-ScheduledTask -TaskPath "\$TaskFolder\" -TaskName $TaskName -ErrorAction SilentlyContinue
    Write-Host "  Disabled: $TaskName" -ForegroundColor Green
}

# 4. Clean temporary files
Write-Host "[4/5] Cleaning temporary files..." -ForegroundColor Yellow

$TempFolders = @("$env:SystemRoot\Temp", "$env:SystemRoot\Prefetch", "$env:TEMP")
foreach ($Folder in $TempFolders) {
    if (Test-Path $Folder) {
        Get-ChildItem -Path $Folder -Recurse -Force -ErrorAction SilentlyContinue |
            Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-7) } |
            Remove-Item -Force -ErrorAction SilentlyContinue
        Write-Host "  Cleaned: $Folder" -ForegroundColor Green
    }
}

# 5. Apply Windows optimizations
Write-Host "[5/5] Applying optimizations..." -ForegroundColor Yellow

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableFirstLogonAnimation" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -ErrorAction SilentlyContinue

Write-Host "=========================================" -ForegroundColor Green
Write-Host "   Cleanup Completed Successfully!" -ForegroundColor Green
Write-Host "   Log saved to: $LogFile" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Green

Stop-Transcript
```

### Step 2: Create FirstLogon.cmd (trigger script)

Save as `D:\Scripts\FirstLogon.cmd`:

```batch
@echo off
echo Running system cleanup, please wait...
powershell.exe -ExecutionPolicy Bypass -File "C:\Windows\Setup\Scripts\Cleanup.ps1"
```



---



## ⚙️ Part 3: Modify Windows ISO (Inject Cleanup Script)

### Step 3: Mount the Windows ISO

```powershell
# 1. Mount the ISO (double-click it in Explorer, or use PowerShell)
# Let's assume it mounts as E: drive

# 2. Copy install.wim to D:\WDS
Copy-Item "E:\sources\install.wim" -Destination "D:\WDS\install.wim" -Verbose

# Note: If you have install.esd instead, convert it:
dism /Export-Image /SourceImageFile:"E:\sources\install.esd" /SourceIndex:1 /DestinationImageFile:"D:\WDS\install.wim" /Compress:max
```

### Step 4: Mount install.wim for editing

```powershell
# Check available editions (index numbers)
dism /Get-ImageInfo /ImageFile:"D:\WDS\install.wim"

# Mount the desired edition (usually Index 6 for Windows 11 Pro)
dism /Mount-Image /ImageFile:"D:\WDS\install.wim" /Index:1 /MountDir:"D:\Mount"
```

### Step 5: Inject scripts into the mounted image

```powershell
# Create Scripts folder
New-Item -Path "D:\Mount\Windows\Setup\Scripts" -ItemType Directory -Force

# Copy cleanup scripts
Copy-Item "D:\Scripts\Cleanup.ps1" -Destination "D:\Mount\Windows\Setup\Scripts\" -Force
Copy-Item "D:\Scripts\FirstLogon.cmd" -Destination "D:\Mount\Windows\Setup\Scripts\" -Force
```

### Step 6: Create unattend.xml (auto-login + auto-cleanup)

Create `D:\Mount\Windows\Panther\unattend.xml`:

```powershell
# Create Panther folder
New-Item -Path "D:\Mount\Windows\Panther" -ItemType Directory -Force
```

Then create the file with this content:

```xml
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
    <settings pass="windowsPE">
        <component name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
            <UserData>
                <AcceptEula>true</AcceptEula>
            </UserData>
        </component>
    </settings>
    
    <settings pass="oobeSystem">
        <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
            <OOBE>
                <HideEULAPage>true</HideEULAPage>
                <HideLocalAccountScreen>true</HideLocalAccountScreen>
                <HideOEMRegistrationScreen>true</HideOEMRegistrationScreen>
                <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
                <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
                <SkipMachineOOBE>true</SkipMachineOOBE>
                <SkipUserOOBE>true</SkipUserOOBE>
            </OOBE>
            <UserAccounts>
                <AdministratorPassword>
                    <Value>Admin@123</Value>
                    <PlainText>true</PlainText>
                </AdministratorPassword>
            </UserAccounts>
            <AutoLogon>
                <Username>Administrator</Username>
                <Password>
                    <Value>Admin@123</Value>
                    <PlainText>true</PlainText>
                </Password>
                <Enabled>true</Enabled>
                <LogonCount>1</LogonCount>
            </AutoLogon>
            <FirstLogonCommands>
                <SynchronousCommand wcm:action="add">
                    <Order>1</Order>
                    <Description>Run Cleanup Script</Description>
                    <CommandLine>C:\Windows\Setup\Scripts\FirstLogon.cmd</CommandLine>
                    <RequiresUserInput>false</RequiresUserInput>
                </SynchronousCommand>
            </FirstLogonCommands>
        </component>
    </settings>
</unattend>
```

### Step 7: Save and unmount the image

```powershell
# Save changes and unmount
dism /Unmount-Image /MountDir:"D:\Mount" /Commit

# Verify the image
dism /Get-ImageInfo /ImageFile:"D:\WDS\install.wim"
```




---

### Step 8: Using anyburn to replace the install.esd to install.wim in .ISO files

1. Install & Open **Anyburn** 
2. Select the **Edit image file** button
3. Remove the **install.esd** in .ISO resources 
4. Copy & Paste the modified **install.wim** to .ISO resources
5. Next to create a new **.ISO**





> [!TIP]
>
> 挂载 **windows.iso** 到 **mount目录** （如真实的生产环境目录结构）： `dism /Mount-Image /ImageFile:"D:\WDS\install.wim" /Index:1 /MountDir:"D:\Mount"`
>
> 闭载 **mount目录** ：`powershell dism /Unmount-Image /MountDir:"D:\Mount" /Commit `
>
> 
>
> | 脚本执行阶段                                      | 推荐路径 (在镜像中)                                    | 关键要求                                                     | 适用脚本类型                                                 |
> | :------------------------------------------------ | :----------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
> | **系统安装好，首次登录桌面前** (静默运行，权限高) | `%WINDIR%\Setup\Scripts\SetupComplete.cmd`             | 脚本名必须为 `SetupComplete.cmd`；无交互 (不能弹出窗口或要求点击) | 安装驱动、修改系统级注册表、运行 PowerShell (可在此 .cmd 里调用你的 .ps1) |
> | **首次登录桌面时** (可见，可交互)                 | `%WINDIR%\Panther\unattend.xml` (通过文件内容指定脚本) | 需配置 `FirstLogonCommands` 节；可指定任意路径的脚本，无需放在特定文件夹 | 运行需要用户界面的程序、你的 `Cleanup.ps1` 清理脚本、个性化设置 |
>
> | 场景                    | 是否可以自定义文件名        | 推荐做法            |
> | :---------------------- | :-------------------------- | :------------------ |
> | 文件放在 `Panther` 目录 | ❌ 必须叫 `unattend.xml`     | 最简单、最可靠      |
> | 文件放在安装介质根目录  | ❌ 必须叫 `autounattend.xml` | 适用于 USB/光盘安装 |
> | 通过 DISM 命令手动指定  | ✅ 完全自由                  | 适合高级定制        |
> | 通过 WDS 服务器指定     | ✅ 完全自由                  | 适合企业部署        |
>
> - `unattend.xml`：继续使用这个名字，放在 `Windows\Panther\`，没问题
> - `Cleanup.ps1`：可以保持这个名字，也可以改成任何你喜欢的名字，灵活自由
>
> 如果你想重命名 `Cleanup.ps1` 为其他名字（比如 `SystemOptimizer.ps1`），只需要同时修改 `unattend.xml` 中的 `CommandLine` 路径即可。
>
> 



## $OEM$ 文件夹的目录结构遵循一套严格的映射规则

```text
sources/
└── $OEM$/
    ├── $$ /                  (对应 C:\Windows)
    │   ├── Resources/
    │   │   └── Wallpapers/   (自定义壁纸)
    │   ├── System32/         (系统组件)
    │   └── Setup/
    │       └── Scripts/
    │           └── SetupComplete.cmd  (安装完成后自动运行的关键脚本)
    ├── $1 /                  (对应 C:\ 根目录)
    │   ├── Drivers/          (存放驱动安装包)
    │   └── Install/          (存放静默安装包)
    ├── $Docs /               (对应 C:\Users)
    │   └── Public/
    │       └── Desktop/      (所有用户的公共桌面图标)
    └── $Progs /              (对应 C:\Program Files)
        └── MyCustomApp/      (预装应用的文件夹)
```

使用 **Anyburn** 进行 **resouces** 文件修改


















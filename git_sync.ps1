# 这里的 -am 是 -a 和 -m 的组合
git commit -am "update content"
git push origin dev
git status

# Pause the terminal
Write-Host "`nPress any key to close this window..." -ForegroundColor Yellow
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
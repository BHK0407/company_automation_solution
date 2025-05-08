$registryPath = "HKCU:\Software\Microsoft\Internet Explorer\PageSetup"

# Lấy các giá trị hiện tại
$currentSettings = Get-ItemProperty -Path $registryPath

# Kiểm tra từng giá trị
if (
    $currentSettings.header -eq "" -and
    $currentSettings.footer -eq "" -and
    $currentSettings.margin_left -eq "0.25" -and
    $currentSettings.margin_right -eq "0.25" -and
    $currentSettings.margin_top -eq "0.5" -and
    $currentSettings.margin_bottom -eq "0.5"
) {
    Write-Host "Cau hinh da duoc ap dung day du. " -ForegroundColor Green
    Start-Sleep -Seconds 2
} else {
    Write-Host "Cau hinh chu duoc ap dung day du hoac da bi thay doi." -ForegroundColor Red
    Start-Sleep -Seconds 2
}
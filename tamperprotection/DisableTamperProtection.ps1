# Start Windows Security app
Start-Process "ms-settings:windowssecuritycenter"

# Wait for the app to open (adjust delay as needed)
Start-Sleep -Seconds 2

# Simulate key presses to navigate to Virus & Threat Protection
Add-Type -AssemblyName PresentationCore,PresentationFramework
[System.Windows.Forms.SendKeys]::SendWait("V")
[System.Windows.Forms.SendKeys]::SendWait("i")
[System.Windows.Forms.SendKeys]::SendWait("r")
[System.Windows.Forms.SendKeys]::SendWait("u")
[System.Windows.Forms.SendKeys]::SendWait("s")
[System.Windows.Forms.SendKeys]::SendWait(" ")
[System.Windows.Forms.SendKeys]::SendWait("&")
[System.Windows.Forms.SendKeys]::SendWait(" ")
[System.Windows.Forms.SendKeys]::SendWait("T")
[System.Windows.Forms.SendKeys]::SendWait("h")
[System.Windows.Forms.SendKeys]::SendWait("r")
[System.Windows.Forms.SendKeys]::SendWait("e")
[System.Windows.Forms.SendKeys]::SendWait("a")
[System.Windows.Forms.SendKeys]::SendWait("t")
[System.Windows.Forms.SendKeys]::SendWait(" ")
[System.Windows.Forms.SendKeys]::SendWait("P")
[System.Windows.Forms.SendKeys]::SendWait("r")
[System.Windows.Forms.SendKeys]::SendWait("o")
[System.Windows.Forms.SendKeys]::SendWait("t")
[System.Windows.Forms.SendKeys]::SendWait("e")
[System.Windows.Forms.SendKeys]::SendWait("c")
[System.Windows.Forms.SendKeys]::SendWait("t")
[System.Windows.Forms.SendKeys]::SendWait("i")
[System.Windows.Forms.SendKeys]::SendWait("o")
[System.Windows.Forms.SendKeys]::SendWait("n")

Start-Sleep -Seconds 2
Add-Type -AssemblyName PresentationCore,PresentationFramework
[System.Windows.Forms.SendKeys]::SendWait("{DOWN}")
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

Add-Type -AssemblyName PresentationCore,PresentationFramework
Start-Sleep -Seconds 2
for ($i = 0; $i -lt 4; $i++) {
    [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
    Start-Sleep -Milliseconds 100  # Optional delay between presses
}

Add-Type -AssemblyName PresentationCore,PresentationFramework
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

Add-Type -AssemblyName PresentationCore,PresentationFramework
Start-Sleep -Seconds 2
for ($i = 0; $i -lt 4; $i++) {
    [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
    Start-Sleep -Milliseconds 100  # Optional delay between presses
}

Start-Sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait(" ")

Start-Sleep -Seconds 5
Get-Process SystemSettings | Stop-Process -Force

# Close Windows Defender app
Get-Process SecHealthUI | Stop-Process -Force
Start-Sleep -Seconds 5

# Exclusion path for folder
Add-MpPreference -ExclusionPath "C:\setupPOS"
Add-MpPreference -ExclusionProcess "C:\setupPOS\info\setupIP.exe"

Write-Host "`Exclusions added for setupPOS folder, and process extension."

Get-MpPreference | Select-Object ExclusionPath, ExclusionProcess, ExclusionExtension

# Verify exclusions
$paths = (Get-MpPreference).ExclusionPath
$procs = (Get-MpPreference).ExclusionProcess

if ($paths -contains "C:\setupPOS" -and $procs -contains "C:\setupPOS\info\setupIP.exe") {
    Write-Host "Confirmed: Exclusions successfully applied." -ForegroundColor Green
} else {
    Write-Host "Warning: Exclusions NOT found in Defender settings." -ForegroundColor Red
}
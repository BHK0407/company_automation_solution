# Logic to test connection to domain controller
$dcIP = "10.1.1.21"
if (-not (Test-Connection -ComputerName $dcIP -Count 3 -Quiet)){
    Write-Host "Domain Controller $dcIP is unreachable. Aborting domain join" -ForegroundColor Red
    exit 1
} else {
    Write-Host "Domain Controller $dcIP is reachable. Proceeding..." -ForegroundColor Green
}

# Note to bypass set-execution policy
try {
    Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force -ErrorAction Stop *>&1 | Out-Null
    Write-Host "Execution policy set to RemoteSigned." -ForegroundColor Cyan
} catch {
    if ($_.ToString() -like "*overridden by a policy defined at a more specific scope*") {
        # Không cần báo lỗi nếu do GPO, vì script vẫn chạy
    } else {
        Write-Host "Failed to set execution policy: $_" -ForegroundColor Red
    }
}

$domain = "gs25vn.local"
$password = "gs25@123456" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\joindomain" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)

Add-Computer -DomainName $domain -Credential $credential


# PowerShell.exe -ExecutionPolicy Unrestricted -File .\add-Com-domain.ps1
# Set-ExecutionPolicy Bypass -Scope Process ; .\add-Com-domain.ps1
# Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy Unrestricted ;.\add-Com-domain.ps1
# Tim het profiles trong List profiles
$profileListPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"

$profiles = Get-ChildItem $profileListPath | Where-Object {
    $_.PSChildName -match '^S-1-5-21-' # Check for valid user SIDs
}

# Voi tung user trong profiles
foreach ($user in $profiles ) {
    try {
        $userSID = $user.PSChildName
        $userProfilePath = Get-ItemPropertyValue -Path $user.PSPath -Name "ProfileImagePath" -ErrorAction SilentlyContinue
        
        Write-Host "Found profile path: $userProfilePath" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 500

        # Tro den username path (C:\Users\VN0018 -> VN0018)
        if ($userProfilePath -and ($userProfilePath -match '\\Users\\(VN[^\\]*)$')) {
            #$userProfilePath phải có giá trị (không null hoặc rỗng)
            #Sau đó mới kiểm tra điều kiện -match
            #Nếu không có -and, PowerShell có thể bị lỗi nếu $userProfilePath chưa được khởi tạo.

            $username = $Matches[1]
            Write-Host "Username trung voi filter: $username (SID: $userSID)" -ForegroundColor Yellow 
            Start-Sleep -Milliseconds 500

            $registryPath = "Registry::HKEY_USERS\$userSID\Software\Microsoft\Internet Explorer\PageSetup"

            if (Test-Path $registryPath) {
                
                Write-Output "Editing Registry at: $registryPath"

                Set-ItemProperty -Path $registryPath -Name "header" -Value ""
                Set-ItemProperty -Path $registryPath -Name "footer" -Value ""
                Set-ItemProperty -Path $registryPath -Name "margin_left" -Value "0.25"
                Set-ItemProperty -Path $registryPath -Name "margin_right" -Value "0.25"
                Set-ItemProperty -Path $registryPath -Name "margin_top" -Value "0.5"
                Set-ItemProperty -Path $registryPath -Name "margin_bottom" -Value "0.5"

                Write-Host "Updated Page Setup for user: $username (SID: $userSID)" -ForegroundColor Green
                Start-Sleep -Milliseconds 500
            }
        }
    }
    catch {
        Write-Output "Error processing SID: $($user.PSChildName) - $_"
        Start-Sleep -Milliseconds 500 -ForegroundColor Red
    }
}
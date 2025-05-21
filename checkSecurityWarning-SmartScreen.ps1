Get-ChildItem "%~dp0" -Recurse | ForEach-Object {
    if (Get-Item $_.FullName -Stream "Zone.Identifier" -ErrorAction SilentlyContinue) {
        Write-Host "$($_.FullName) is BLOCKED" -ForegroundColor Red
    } else {
        Write-Output "$($_.FullName) is OK"
    }
}
# Run as Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

# Create a temp directory
New-Item -Type directory -Force -Path C:\Users\$env:UserName\Downloads\temp | Out-Null
Set-Location "C:\Users\$env:UserName\Downloads\temp"

# Visual C++ Redistributables
Write-Host "Downloading Visual C++ Redistributable 2005"

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE", "C:\Users\$env:UserName\Downloads\temp\vcredist_2005_x86.exe")
$proc = Start-Process "vcredist_2005_x86.exe" -Wait -ArgumentList "/Q" -PassThru
$proc.WaitForExit()

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE", "C:\Users\$env:UserName\Downloads\temp\vcredist_2005_x64.exe")
$proc = Start-Process "vcredist_2005_x64.exe" -Wait -ArgumentList "/Q" -PassThru
$proc.WaitForExit()

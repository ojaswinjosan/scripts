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

Write-Host "Downloading Visual C++ Redistributable 2008"

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/1/1/1/1116b75a-9ec3-481a-a3c8-1777b5381140/vcredist_x86.exe", "C:\Users\$env:UserName\Downloads\temp\vcredist_2008_x86.exe")

$proc = Start-Process "vcredist_2008_x86.exe" -Wait -ArgumentList "/Q" -PassThru
$proc.WaitForExit()

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/d/2/4/d242c3fb-da5a-4542-ad66-f9661d0a8d19/vcredist_x64.exe", "C:\Users\$env:UserName\Downloads\temp\vcredist_2008_x64.exe")

$proc = Start-Process "vcredist_2008_x64.exe" -Wait -ArgumentList "/Q" -PassThru
$proc.WaitForExit()

Write-Host "Downloading Visual C++ Redistributable 2010"

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/5/B/C/5BC5DBB3-652D-4DCE-B14A-475AB85EEF6E/vcredist_x86.exe", "C:\Users\$env:UserName\Downloads\temp\vcredist_2010_x86.exe")

$proc = Start-Process "vcredist_2010_x86.exe" -Wait -ArgumentList "/norestart /Q" -PassThru
$proc.WaitForExit()

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/A/8/0/A80747C3-41BD-45DF-B505-E9710D2744E0/vcredist_x64.exe", "C:\Users\$env:UserName\Downloads\temp\vcredist_2010_x64.exe")

$proc = Start-Process "vcredist_2010_x64.exe" -Wait -ArgumentList "/norestart /Q" -PassThru
$proc.WaitForExit()


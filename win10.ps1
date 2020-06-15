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

Write-Host "Downloading Visual C++ Redistributable 2012"

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe", "C:\Users\$env:UserName\Downloads\temp\vcredist_2012_x86.exe")
$proc = Start-Process "vcredist_2012_x86.exe" -Wait -ArgumentList "/norestart /Q" -PassThru
$proc.WaitForExit()

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe", "C:\Users\$env:UserName\Downloads\temp\vcredist_2012_x64.exe")
$proc = Start-Process "vcredist_2012_x64.exe" -Wait -ArgumentList "/norestart /Q" -PassThru
$proc.WaitForExit()

Write-Host "Downloading Visual C++ Redistributable 2013"

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x86.exe", "C:\Users\$env:UserName\Downloads\temp\vcredist_2013_x86.exe")
$proc = Start-Process "vcredist_2013_x86.exe" -Wait -ArgumentList "/norestart /Q" -PassThru
$proc.WaitForExit()

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe", "C:\Users\$env:UserName\Downloads\temp\vcredist_2013_x64.exe")
$proc = Start-Process "vcredist_2013_x64.exe" -Wait -ArgumentList "/norestart /Q" -PassThru
$proc.WaitForExit()

Write-Host "Downloading Visual C++ Redistributable 2015"

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/6/D/F/6DF3FF94-F7F9-4F0B-838C-A328D1A7D0EE/vc_redist.x86.exe", "C:\Users\$env:UserName\Downloads\temp\vcredist_2015_x86.exe")
$proc = Start-Process "vcredist_2015_x86.exe" -Wait -ArgumentList "/norestart /Q" -PassThru
$proc.WaitForExit()

(New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/6/D/F/6DF3FF94-F7F9-4F0B-838C-A328D1A7D0EE/vc_redist.x64.exe", "C:\Users\$env:UserName\Downloads\temp\vcredist_2015_x64.exe")
$proc = Start-Process "vcredist_2015_x64.exe" -Wait -ArgumentList "/norestart /Q" -PassThru
$proc.WaitForExit()

Write-Host "Downloading Visual C++ Redistributable 2017"

(New-Object System.Net.WebClient).DownloadFile("https://download.visualstudio.microsoft.com/download/pr/6ea9376d-6ab0-45ac-a305-d76274c006ed/6a1eef0ca6e0de1c1b41b6202d2208b2/vc_redist.x86.exe", "C:\Users\$env:UserName\Downloads\temp\vcredist_2017_x86.exe")
$proc = Start-Process "vcredist_2017_x86.exe" -Wait -ArgumentList "/norestart /Q" -PassThru
$proc.WaitForExit()

(New-Object System.Net.WebClient).DownloadFile("https://download.visualstudio.microsoft.com/download/pr/46db022e-06ea-4d11-a724-d26d33bc63f7/2b635c854654745078d5577a8ed0f80d/vc_redist.x64.exe", "C:\Users\$env:UserName\Downloads\temp\vcredist_2017_x64.exe")
$proc = Start-Process "vcredist_2017_x64.exe" -Wait -ArgumentList "/norestart /Q" -PassThru
$proc.WaitForExit()

# .NET Framework 3.5
Write-Host "Enabling .NET Framework 3.5"
DISM /Online /Enable-Feature /FeatureName:NetFX3 /All

# Hyper-V
Write-Host "Enabling Hyper-V"
DISM /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V /All /NoRestart

# Windows Sandbox
Write-Host "Enabling Windows Sandbox"
DISM /Online /Enable-Feature /FeatureName:Containers-DisposableClientVM /All /NoRestart

# WSL
Write-Host "Enabling WSL"
DISM /Online /Enable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /All /NoRestart

# Disable Bluetooth Absolute Volume
Write-Host "Disabling Bluetooth Absolute Volume"
Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Control\Bluetooth\Audio\AVRCP\CT" -Name "DisableAbsoluteVolume" -Type DWord -Value 1

# Enable Clipboard History
Write-Host "Enabling Clipboard History"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Type DWord -Value 1

# Display & sleep timeouts
Write-Host "Changing display & sleep timeouts"
powercfg /X monitor-timeout-ac 0
powercfg /X monitor-timeout-dc 15
powercfg /X standby-timeout-ac 0
powercfg /X standby-timeout-dc 30

# Open Explorer to 'This PC' by default
Write-Host "Setting 'This PC' as the default for Explorer"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

# Show file extensions
Write-Host "Enabling file extensions"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0

# Show full path
Write-Host "Enabling full path in Explorer title bar"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Type DWord -Value 1

# AutoHotKey
Write-Host "Downloading AutoHotKey"
curl -o ahk.exe https://www.autohotkey.com/download/ahk-install.exe
$proc = Start-Process "ahk.exe" -Wait -ArgumentList "/S" -PassThru
$proc.WaitForExit()

# Windows Terminal
Write-Host "Downloading Windows Terminal"
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/ojaswinjosan/scripts/master/win10/winterminal-install.ahk", "C:\Users\$env:UserName\Downloads\temp\winterminal-install.ahk")
Start microsoft-edge:
Start "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\Users\$env:UserName\Downloads\temp\winterminal-install.ahk"

# Windows Terminal Config
Write-Host "Applying Windows Terminal Config"
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module posh-git -Force
Install-Module oh-my-posh -Force
Start-Sleep -Seconds 30
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/ojaswinjosan/windows-terminal-config/master/settings.json", "C:\Users\oj\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json")
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/ojaswinjosan/windows-terminal-config/master/Microsoft.PowerShell_profile.ps1", "C:\Users\oj\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\Microsoft.PowerShell_profile.ps1")
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/ojaswinjosan/windows-terminal-config/master/terminal-bg.jpg", "C:\Users\oj\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\terminal-bg.jpg")

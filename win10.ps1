# Run as Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

# Disable progress bar for Invoke-WebRequest
$ProgressPreference = 'SilentlyContinue'

# Create a temp directory
New-Item -Type directory -Force -Path C:\Users\$env:UserName\Downloads\temp | Out-Null
Set-Location "C:\Users\$env:UserName\Downloads\temp"

# Visual C++ Redistributables
Write-Host "Downloading all Visual C++ Redistributables"

$vc2005x86 = "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE"
$vc2005x64 = "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE"
$vc2008x86 = "https://download.microsoft.com/download/1/1/1/1116b75a-9ec3-481a-a3c8-1777b5381140/vcredist_x86.exe"
$vc2008x64 = "https://download.microsoft.com/download/d/2/4/d242c3fb-da5a-4542-ad66-f9661d0a8d19/vcredist_x64.exe"
$vc2010x86 = "https://download.microsoft.com/download/5/B/C/5BC5DBB3-652D-4DCE-B14A-475AB85EEF6E/vcredist_x86.exe"
$vc2010x64 = "https://download.microsoft.com/download/A/8/0/A80747C3-41BD-45DF-B505-E9710D2744E0/vcredist_x64.exe"
$vc2012x86 = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe"
$vc2012x64 = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe"
$vc2013x86 = "https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x86.exe"
$vc2013x64 = "https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe"
$vc2015to2019x86 = "https://download.visualstudio.microsoft.com/download/pr/d60aa805-26e9-47df-b4e3-cd6fcc392333/A06AAC66734A618AB33C1522920654DDFC44FC13CAFAA0F0AB85B199C3D51DC0/VC_redist.x86.exe"
$vc2015to2019x64 = "https://download.visualstudio.microsoft.com/download/pr/d60aa805-26e9-47df-b4e3-cd6fcc392333/7D7105C52FCD6766BEEE1AE162AA81E278686122C1E44890712326634D0B055E/VC_redist.x64.exe"

Invoke-WebRequest -o "vcredist_2005_x86.exe" $vc2005x86
Invoke-WebRequest -o "vcredist_2005_x64.exe" $vc2005x64
Invoke-WebRequest -o "vcredist_2008_x86.exe" $vc2008x86
Invoke-WebRequest -o "vcredist_2008_x64.exe" $vc2008x64
Invoke-WebRequest -o "vcredist_2010_x86.exe" $vc2010x86
Invoke-WebRequest -o "vcredist_2010_x64.exe" $vc2010x64
Invoke-WebRequest -o "vcredist_2012_x86.exe" $vc2012x86
Invoke-WebRequest -o "vcredist_2012_x64.exe" $vc2012x64
Invoke-WebRequest -o "vcredist_2013_x86.exe" $vc2013x86
Invoke-WebRequest -o "vcredist_2013_x64.exe" $vc2013x64
Invoke-WebRequest -o "vcredist_2015_2019_x86.exe" $vc2015to2019x86
Invoke-WebRequest -o "vcredist_2015_2019_x64.exe" $vc2015to2019x64

Start-Process "vcredist_2005_x86.exe" -Wait -ArgumentList "/Q"
Start-Process "vcredist_2005_x64.exe" -Wait -ArgumentList "/Q"
Start-Process "vcredist_2008_x86.exe" -Wait -ArgumentList "/Q"
Start-Process "vcredist_2008_x64.exe" -Wait -ArgumentList "/Q"
Start-Process "vcredist_2010_x86.exe" -Wait -ArgumentList "/norestart /Q"
Start-Process "vcredist_2010_x64.exe" -Wait -ArgumentList "/norestart /Q"
Start-Process "vcredist_2012_x86.exe" -Wait -ArgumentList "/norestart /Q"
Start-Process "vcredist_2012_x64.exe" -Wait -ArgumentList "/norestart /Q"
Start-Process "vcredist_2013_x86.exe" -Wait -ArgumentList "/norestart /Q"
Start-Process "vcredist_2013_x64.exe" -Wait -ArgumentList "/norestart /Q"
Start-Process "vcredist_2015_2019_x86.exe" -Wait -ArgumentList "/norestart /Q"
Start-Process "vcredist_2015_2019_x64.exe" -Wait -ArgumentList "/norestart /Q"

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
Invoke-WebRequest -o ahk.exe https://www.autohotkey.com/download/ahk-install.exe
Start-Process "ahk.exe" -Wait -ArgumentList "/S"

# Windows Terminal
Write-Host "Downloading Windows Terminal"
$terminal_dl = "https://raw.githubusercontent.com/ojaswinjosan/scripts/master/win10/ms-store-install.ahk"
Invoke-WebRequest -o "ms-store-install.ahk" $terminal_dl
Start-Process ms-windows-store://pdp/?ProductId=9n0dx20hk701
Start-Sleep -Seconds 5
Start-Process "C:\Program Files\AutoHotkey\AutoHotkey.exe" "ms-store-install.ahk"
Start-Sleep -Seconds 20

# Windows Terminal Config
Write-Host "Applying Windows Terminal Config"
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module posh-git -Force
Install-Module oh-my-posh -Force
Start-Sleep -Seconds 15

$terminal_config_path = "C:\Users\oj\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
$terminal_config_url = "https://raw.githubusercontent.com/ojaswinjosan/windows-terminal-config/master/"
$terminal_config_settings = $terminal_config_url+"settings.json"
$terminal_config_psprofile = $terminal_config_url+"Microsoft.PowerShell_profile.ps1"
$temrinal_config_bg = $terminal_config_url+"terminal-bg.jpg"

Invoke-WebRequest -o $terminal_config_path"settings.json" $terminal_config_settings
Invoke-WebRequest -o $terminal_config_path"Microsoft.PowerShell_profile.ps1" $terminal_config_psprofile
Invoke-WebRequest -o $terminal_config_path"terminal-bg.jpg" $temrinal_config_bg

# Windows Terminal in context menu
Write-Host "Adding Windows Terminal to the Context Menu"
New-Item -Path "HKLM:\SOFTWARE\Classes\Directory\background\shell\WinTerminal" -Value "Open Windows Terminal here" -Force
New-Item -Path "HKLM:\SOFTWARE\Classes\Directory\background\shell\WinTerminal\command" -Value "C:\Users\oj\AppData\Local\Microsoft\WindowsApps\Microsoft.WindowsTerminal_8wekyb3d8bbwe\wt.exe -d ." -Force

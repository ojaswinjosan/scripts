# Run as Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

# Disable Progress bar for Invoke-WebRequest
$ProgressPreference = 'SilentlyContinue'

# Create a temp directory
$temp_location = "C:\Users\$($env:UserName)\Downloads\temp"
New-Item -Type directory -Force -Path $temp_location | Out-Null
Set-Location $temp_location

### Initial Setup ###
Write-Host "`nSetting up the script"
Start-Process iexplore
Start-Sleep -Seconds 5
Invoke-WebRequest -o "ahk.exe" "https://www.autohotkey.com/download/ahk-install.exe"
New-Item -Path . -Name "ie.ahk" -ItemType "File" -Force  | Out-Null
Start-Process "ahk.exe" -Wait -ArgumentList "/S"
Add-Content "ie.ahk" "Send {Down}`nSleep, 2000`nSend ``n"
Start-Process "C:\Program Files\AutoHotkey\AutoHotkey.exe" "ie.ahk" -Wait
Start-Sleep -Seconds 15
taskkill /F /IM iexplore.exe | Out-Null

# Microsoft Store AHK
Write-Host "`nPreparing Microsoft Store"
Start-Process ms-windows-store:
Start-Sleep -Seconds 30
taskkill /F /IM winstore.App.exe | Out-Null
$ms_store_url = "https://raw.githubusercontent.com/ojaswinjosan/scripts/master/win10/ms-store-install.ahk"
Invoke-WebRequest -o "ms-store-install.ahk" $ms_store_url

### Install applications ###
# Python 
Write-Host "`nInstalling Python"
$py_url = Invoke-WebRequest "https://www.python.org/downloads/"
$py_text = $py_url.AllElements | Where-Object {$_.TagName -eq "a"} | Where-Object {$_.class -eq "button"}
$py_ver = ($py_text[1].innerText).SubString(($py_text[1].innerText).Length - 5)
$py_filename = "python-"+$py_ver+"-amd64.exe"
$py_url = "https://www.python.org/ftp/python/"+$py_ver+"/python-"+$py_ver+"-amd64.exe"
Invoke-WebRequest -o $py_filename $py_url -UseBasicParsing
Start-Process $py_filename -Wait -ArgumentList "/quiet InstallLauncherAllUsers=0 PrependPath=1"
# Reload PATH variable
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
# Install pip packages and start scripts
python -m pip install --upgrade pip | Out-Null
pip install bs4 | Out-Null
pip install lxml | Out-Null
pip install requests | Out-Null

# Windows Terminal
Write-Host "`nInstalling Windows Terminal"
Add-Content "winterminal.ahk" "if WinExist(`"Microsoft Store`")`n{`nWinActivate`n}`nsleep, 10000`nsend ``t`nsleep, 2000`nsend ``t`nsend ``n`nsleep, 2000`nWinMaximize"
Add-Content "winterminal.ahk" "if WinExist(`"Administrator`")`n{`nWinActivate`n}`nreturn"
Start-Process ms-windows-store://pdp/?ProductId=9n0dx20hk701
Start-Sleep -Seconds 5
Start-Process "C:\Program Files\AutoHotkey\AutoHotkey.exe" "winterminal.ahk" -Wait

### VCRedist ###
Write-Host "`nInstalling all Visual C++ Redistributables"
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
# Download all VCRedists
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
# Install all VCRedists
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

# 7-Zip
Write-Host "`nInstalling 7-Zip"
$7z_url = "https://raw.githubusercontent.com/ojaswinjosan/scripts/master/win10/dl-7zip.py"
Invoke-WebRequest -o "dl-7zip.py" $7z_url
python "dl-7zip.py" $temp_location -Wait
Start-Process "7zip.exe" -Wait -ArgumentList "/S"

# Notepad++
Write-Host "`nInstalling Notepad++"
$npp_url = "https://raw.githubusercontent.com/ojaswinjosan/scripts/master/win10/dl-npp.py"
Invoke-WebRequest -o "dl-npp.py" $npp_url
python "dl-npp.py" $temp_location -Wait
Start-Process "npp.exe" -Wait -ArgumentList "/S"

# Chrome
Write-Host "`nInstalling Chrome"
$chrome_url = "https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi"
Invoke-WebRequest -o "chrome.msi" $chrome_url
Start-Process "chrome.msi" -Wait -ArgumentList "/qn"

# OBS Studio
Write-Host "`nInstalling OBS Studio"
$obs_url = "https://raw.githubusercontent.com/ojaswinjosan/scripts/master/win10/dl-obs.py"
Invoke-WebRequest -o "dl-obs.py" $obs_url
python "dl-obs.py" $temp_location -Wait
Start-Process "obs.exe" -Wait -ArgumentList "/S"

# TeamViewer
Write-Host "`nInstalling TeamViewer"
$tv_url = "https://raw.githubusercontent.com/ojaswinjosan/scripts/master/win10/dl-tviewer.py"
Invoke-WebRequest -o "dl-tviewer.py" $tv_url
python "dl-tviewer.py" $temp_location -Wait
Start-Process "teamviewer.exe" -Wait -ArgumentList "/S"

# Git
Write-Host "`nInstalling Git"
$git_url = "https://raw.githubusercontent.com/ojaswinjosan/scripts/master/win10/dl-git.py"
Invoke-WebRequest -o "dl-git.py" $git_url
python "dl-git.py" $temp_location -Wait
Start-Process "git.exe" -Wait -ArgumentList "/VERYSILENT /NORESTART"
New-Item "C:\Users\$($env:UserName)\.gitconfig" -Force | Out-Null
Set-Content "C:\Users\$($env:UserName)\.gitconfig" "[core] `n`teditor = nano"

# Spotify
Write-Host "`nInstalling Spotify"
taskkill /F /IM winstore.App.exe | Out-Null
Start-Sleep -Seconds 5
Start-Process ms-windows-store://pdp/?ProductId=9ncbcszsjrsb
Start-Sleep -Seconds 15
Start-Process "C:\Program Files\AutoHotkey\AutoHotkey.exe" "ms-store-install.ahk" -Wait
Start-Sleep -Seconds 15

# VLC
Write-Host "`nInstalling VLC"
$vlc_url = "https://raw.githubusercontent.com/ojaswinjosan/scripts/master/win10/dl-vlc.py"
Invoke-WebRequest -o "dl-vlc.py" $vlc_url
python "dl-vlc.py" $temp_location -Wait
Start-Process "vlc-x64.exe" -Wait -ArgumentList "/S"

# DirectX
Write-Host "`nInstalling DirectX"
$dx_url = "http://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe"
$dx_path = "C:\Users\$($env:UserName)\Downloads\temp\directx"
Invoke-WebRequest -o "directx.exe" $dx_url
New-Item -Path . -Name "directx" -ItemType "Directory" -Force | Out-Null
Start-Process "directx.exe" -Wait -ArgumentList "/Q /C /T:$dx_path"
Start-Process ".\directx\DXSETUP.exe" -Wait -ArgumentList "/silent"

### VS Code ###
Write-Host "`nInstalling VS Code"
Invoke-WebRequest -o "vscode.exe" "https://aka.ms/win32-x64-user-stable"
Start-Process "vscode.exe" -Wait -ArgumentList "/VERYSILENT /mergetasks=`"addcontextmenufiles,addcontextmenufolders,addtopath,!runcode`""
# Reload PATH variable
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
# VS Code Extensions
Write-Host "`nInstalling VS Code extensions"
code --install-extension jolaleye.horizon-theme-vscode | Out-Null
code --install-extension ms-vscode.powershell | Out-Null
code --install-extension ms-python.python | Out-Null
code --install-extension ritwickdey.liveserver | Out-Null
code --install-extension ms-azuretools.vscode-docker | Out-Null
code --install-extension redhat.vscode-yaml | Out-Null
code --install-extension coenraads.bracket-pair-colorizer-2 | Out-Null
code --install-extension pkief.material-icon-theme | Out-Null
code --install-extension pranaygp.vscode-css-peek | Out-Null
code --install-extension kamikillerto.vscode-colorize | Out-Null
code --install-extension cweijan.vscode-autohotkey-plus | Out-Null
code --install-extension ms-vscode-remote.remote-wsl | Out-Null
code --install-extension eamodio.gitlens | Out-Null
code --install-extension donjayamanne.githistory | Out-Null
code --install-extension chrmarti.regex | Out-Null
code --install-extension xabikos.JavaScriptSnippets | Out-Null
code --install-extension dbaeumer.vscode-eslint | Out-Null
code --install-extension ms-vscode-remote.remote-containers | Out-Null
code --install-extension James-Yu.latex-workshop | Out-Null

# Download WSL 2 kernel update
$wsl2_url = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
Invoke-WebRequest -o "wsl_update_x64.msi" $wsl2_url
start wsl_update_x64.msi "/quiet /passive"

# Docker
$docker_url = "https://download.docker.com/win/stable/Docker%20Desktop%20Installer.exe"
Invoke-WebRequest -o "docker.exe" $docker_url
Start-Process "docker.exe" -ArgumentList "install --quiet" -Wait | Out-Null

# FFmpeg
Write-Host "`nInstalling FFmpeg"
$ffmpeg_path = ";C:\Program Files\ffmpeg\bin"
$ffmpeg_url = "https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-latest-win64-static.zip"
Invoke-WebRequest -o "ffmpeg.zip" $ffmpeg_url
Expand-Archive -Path "ffmpeg.zip" -Force
Copy-Item -Path "ffmpeg\ffmpeg*\" -Destination "C:\Program Files\ffmpeg\" -Force -Recurse
[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path",[EnvironmentVariableTarget]::Machine) + $ffmpeg_path, [EnvironmentVariableTarget]::Machine)

# Ubuntu WSL
Write-Host "`nInstalling Ubuntu WSL"
Start-Process ms-windows-store://pdp/?ProductId=9nblggh4msv6
Start-Sleep -Seconds 15
Start-Process "C:\Program Files\AutoHotkey\AutoHotkey.exe" "ms-store-install.ahk" -Wait
Start-Sleep -Seconds 15

### Windows Terminal Config ###
Write-Host "`nApplying Windows Terminal config"
$terminal_config_url = "https://raw.githubusercontent.com/ojaswinjosan/windows-terminal-config/master/"
$terminal_icon_url = "https://raw.githubusercontent.com/microsoft/terminal/master/res/terminal.ico"
$terminal_config_path = "C:\Users\"+$env:UserName+"\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
$terminal_settings_url = $terminal_config_url+"settings.json"
$terminal_psprofile_url = $terminal_config_url+"Microsoft.PowerShell_profile.ps1"
$terminal_bg_url = $terminal_config_url+"terminal-bg.jpg"
$cascadia_font_url = "https://github.com/microsoft/cascadia-code/releases/download/v2005.15/CascadiaCode_2005.15.zip"
# Download the files
Invoke-WebRequest -o $terminal_config_path"settings.json" $terminal_settings_url
Invoke-WebRequest -o $terminal_config_path"Microsoft.PowerShell_profile.ps1" $terminal_psprofile_url
Invoke-WebRequest -o $terminal_config_path"terminal-bg.jpg" $terminal_bg_url
Invoke-WebRequest -o $terminal_config_path"terminal.ico" $terminal_icon_url
# Powershell Modules
Write-Host "`nInstalling Powershell modules"
Install-PackageProvider -Name NuGet -Force | Out-Null
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module posh-git -Force
Install-Module oh-my-posh -Force
# Font
Invoke-WebRequest -o "font.zip" $cascadia_font_url
Expand-Archive "font.zip" -Force
Copy-Item "./font/ttf/CascadiaCodePL.ttf" "..\"

# Enable system features
Write-Host "`nEnabling Windows features"
DISM /Online /Enable-Feature /FeatureName:NetFX3 /All | Out-Null
DISM /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V /All /NoRestart | Out-Null
DISM /Online /Enable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /All /NoRestart | Out-Null
DISM /Online /Enable-Feature /FeatureName:VirtualMachinePlatform /All /NoRestart | Out-Null

# Registry Tweaks
Write-Host "`nApplying Registry Tweaks"
New-Item -Path "HKLM:\SOFTWARE\Classes\Directory\background\shell\WinTerminal" -Value "Open Windows Terminal here" -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Classes\Directory\background\shell\WinTerminal\command" -Value "C:\Users\$($env:UserName)\AppData\Local\Microsoft\WindowsApps\Microsoft.WindowsTerminal_8wekyb3d8bbwe\wt.exe -d ." -Force  | Out-Null
New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\Explorer" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Classes\Directory\background\shell\WinTerminal" -Name "Icon" -Value "C:\Users\$($env:UserName)\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\terminal.ico" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Control\Bluetooth\Audio\AVRCP\CT" -Name "DisableAbsoluteVolume" -Type DWord -Value 1 | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Type DWord -Value 1 | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1 | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0 | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Type DWord -Value 1 | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "UseOLEDTaskbarTransparency" -Type DWord -Value 1 | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0 | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Type DWord -Value 0 | Out-Null
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 1 -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0 | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0 | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0 | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Type DWord -Value 0 | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0 | Out-Null
Remove-Item "HKLM:\SOFTWARE\Classes\Directory\shell\git_gui" -Force -Recurse | Out-Null
Remove-Item "HKLM:\SOFTWARE\Classes\Directory\Background\shell\git_gui" -Force -Recurse | Out-Null

# Restart Explorer
taskkill /F /IM explorer.exe | Out-Null
Start-Process explorer
Start-Sleep -Seconds 10

# Remove files after reboot
New-Item "C:\Users\$($env:UserName)\Downloads\removefiles.ps1" -Force | Out-Null
New-Item "C:\Users\$($env:UserName)\Downloads\removefiles.bat" -Force | Out-Null
Add-Content "C:\Users\$($env:UserName)\Downloads\removefiles.bat" "wsl --set-default-version 2`npowershell.exe -ExecutionPolicy Bypass -File C:\Users\$($env:UserName)\Downloads\removefiles.ps1"
Add-Content "C:\Users\$($env:UserName)\Downloads\removefiles.ps1" "Set-Location C:\Users\$($env:UserName)\Downloads\`nRemove-Item -Path temp -Recurse -Force"
Add-Content "C:\Users\$($env:UserName)\Downloads\removefiles.ps1" "Remove-Item -Path removefiles.bat`nRemove-Item -Path win10.ps1`nRemove-Item -Path `$MyInvocation.MyCommand.Source"
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name ScriptV2 -Propertytype String -Value "C:\Users\$env:UserName\Downloads\removefiles.bat" | Out-Null

# Bloatware
Write-Host "`nRemoving Bloatware"
Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsFeedbackHub| Remove-AppxPackage
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage
Get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage

# endall Alias
$endall_func = "Get-Process Explorer| Stop-Process ; Get-Process | Where-Object {`$`_.MainWindowTitle -ne """" }| Stop-Process -Force"
New-Item -Path "C:\Users\$($env:UserName)\Documents\" -Name "WindowsPowerShell" -ItemType "Directory" -Force | Out-Null
Set-Location "C:\Users\$($env:UserName)\Documents\WindowsPowerShell"
New-Item -Path . -Name "Microsoft.PowerShell_profile.ps1" -ItemType "File" -Force | Out-Null
Add-Content "Microsoft.PowerShell_profile.ps1" "function Close-All {`n`t $($endall_func) `n} `n`nSet-Alias endall Close-All"

# Display and Sleep timeouts
Write-Host "`nTweaking Display and sleep timeouts"
powercfg /X monitor-timeout-ac 0
powercfg /X monitor-timeout-dc 15
powercfg /X standby-timeout-ac 0
powercfg /X standby-timeout-dc 30

# Restart
Read-Host -Prompt "`nAll done. Press Enter to restart the system"
Write-Host "`nThe system will restart in 30 seconds"
Start-Sleep -Seconds 30
Restart-Computer

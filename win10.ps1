# Run as Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

# Create a temp directory
New-Item -Type directory -Force -Path C:\Users\$env:UserName\Downloads\temp | Out-Null
Set-Location "C:\Users\$env:UserName\Downloads\temp"

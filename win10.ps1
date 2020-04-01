# Create a temp directory
New-Item -Type directory -Force -Path C:\Users\$env:UserName\Downloads\temp | Out-Null
Set-Location "C:\Users\$env:UserName\Downloads\temp"

# Install chocolatey and give global agreement to terms and licenses
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation


choco install foxitreader -y
choco install chromium -y
choco install firefox -y
choco install ublockorigin-firefox
choco install pdfcreator -y
choco install jre8 -y
choco install vcredist140 -y
choco install k-litecodecpackfull -y
choco install winrar -y
#choco install malwarebytes -y
#choco install vlc -y
#choco install thunderbird -y
#choco install libreoffice-fresh -y
#choco install chocolateygui -y

#Set firefox default browser
$regKey      = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\{0}\UserChoice"
$regKeyHttp  = $regKey -f 'http'
$regKeyHttps = $regKey -f 'https'
Set-ItemProperty $regKeyHttp  -name ProgId FirefoxURL
Set-ItemProperty $regKeyHttps -name ProgId FirefoxURL

echo "finished"
pause
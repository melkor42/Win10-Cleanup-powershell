# Install chocolatey and give global agreement to terms and licenses
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation

choco install vlc -y
choco install foxitreader -y
choco install winrar -y
choco install chromium -y
choco install ublockorigin-chrome
choco install firefox -y
choco install ublockorigin-firefox
choco install pdfcreator -y
choco install jre8 -y
choco install vcredist140 -y

#Set firefox default browser
$regKey      = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\{0}\UserChoice"
$regKeyHttp  = $regKey -f 'http'
$regKeyHttps = $regKey -f 'https'
Set-ItemProperty $regKeyHttp  -name ProgId FirefoxURL
Set-ItemProperty $regKeyHttps -name ProgId FirefoxURL

echo "finished"
pause
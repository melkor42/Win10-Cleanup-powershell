# if the Script doesn't start maybe change the executionPolicy
# save your Policy first
# $pol = Get-ExecutionPolicy
# change it
# set-executionpolicy -executionPolicy Unrestricted -force
# load the saved policySetting
#s et-executionpolicy -executionPolicy $pol -force

# System restore
Enable-ComputerRestore -drive "c:\"

# Disable UAC
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value "0" 

# Disable Defender
Set-MpPreference -DisableRealtimeMonitoring $true

# Disable X-box Monitoring
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\xbgm" -Name "Start" -Value "4"

# Disabel App recommendations
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" DisableWindowsConsumerFeatures 1

# Explorer Settings
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty $key HideFileExt 0
Set-ItemProperty $key LaunchTo 1
Set-ItemProperty $key NavPaneExpandToCurrentFolder 1
Set-ItemProperty $key NavPaneShowAllFolders 1
#Taskbar remove Contacts&taskview
Set-ItemProperty $key ShowTaskViewButton 0
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" PeopleBand 0
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" EnableAutoTray 0
Stop-Process -processname explorer

# Call script form same Folder
./remove_taskbaricons.ps1

# Uninstall all unwanted apps exept those named 
Get-AppxPackage -AllUsers | where-object {$_.name -notlike "*Xbox*"} | where-object {$_.name -notlike "*Stickynotes*"} | where-object {$_.name -notlike "*LanguageExperiencePackde-de*"}  | where-object {$_.name -notlike "*NET.*"}  | where-object {$_.name -notlike "*VCLibs.*"}  | where-object {$_.name -notlike "*MSPaint*"}  | where-object {$_.name -notlike "*Microsoft.WindowsStore*"} | where-object {$_.name -notlike "*Microsoft.WindowsCalculator*"} | where-object {$_.name -notlike "*Microsoft.Windows.Photos*"} | Remove-AppxPackage
# Make sure they get never installed again
Get-AppXProvisionedPackage -online | where-object {$_.name -notlike "*Xbox*"} | where-object {$_.name -notlike "*Stickynotes*"} | where-object {$_.name -notlike "*LanguageExperiencePackde-de*"}  | where-object {$_.name -notlike "*NET.*"}  | where-object {$_.name -notlike "*VCLibs.*"}  | where-object {$_.name -notlike "*MSPaint*"}  | where-object {$_.name -notlike "*Microsoft.WindowsStore*"} | where-object {$_.name -notlike "*Microsoft.WindowsCalculator*"} | where-object {$_.name -notlike "*Microsoft.Windows.Photos*"} | Remove-AppxProvisionedPackage –online 

# Reinstall all Packages if you need exept those named 
# Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register “$($_.InstallLocation)\AppXManifest.xml”}

# Install chocolatey and give global agreement to terms and licenses
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation

choco install vlc -y
choco install foxitreader -y
choco install winrar -y
choco install chromium -y
choco install firefox -y
choco install pdfcreator -y
choco install jre8 -y
choco install vcredist140 -y
# choco install msiafterburner -y

#Set firefox default browser
$regKey      = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\{0}\UserChoice"
$regKeyHttp  = $regKey -f 'http'
$regKeyHttps = $regKey -f 'https'
Set-ItemProperty $regKeyHttp  -name ProgId FirefoxURL
Set-ItemProperty $regKeyHttps -name ProgId FirefoxURL

echo "you might want to install "
echo "win10ShutUp from here https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe"
echo "win10ShutUp Empfohlene und eingeschränkt empfohlene einstellungen anwenden"
echo "Firefox addons -> ublock -> foxygestures"
echo "driverbooster from here https://www.chip.de/downloads/Driver-Booster-Free_62401917.html"
pause
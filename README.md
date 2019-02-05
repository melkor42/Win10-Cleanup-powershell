## Cleanup the annoying Win 10 default settings

Read the comments in the cleanup script


# if the Script doesn't start maybe change the executionPolicy
# save your Policy first
# $pol = Get-ExecutionPolicy
# change it
# set-executionpolicy -executionPolicy Unrestricted -force
# load the saved policySetting
# set-executionpolicy -executionPolicy $pol -force

# System restore
Enable-ComputerRestore -drive "c:\"

# Disable UAC
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value "0" 

# Disable Defender
Set-MpPreference -DisableRealtimeMonitoring $true

# Disable X-box Monitoring
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\xbgm" -Name "Start" -Value "4"

# Disabel App recommendations
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value "1" -Force

# Explorer Settings
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty $key HideFileExt 0
Set-ItemProperty $key LaunchTo 1
Set-ItemProperty $key NavPaneExpandToCurrentFolder 1
Set-ItemProperty $key NavPaneShowAllFolders 1
#Taskbar remove Contacts&taskview
Set-ItemProperty $key ShowTaskViewButton 0
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" PeopleBand 0
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

choco install vlc
choco install foxitreader
choco install winrar
choco install firefox
choco install pdfcreator
choco install jre8
choco install vcredist140
# choco install msiafterburner 

echo you might want to install 
echo driverbooster from here 
echo win10ShutUp from here 
echo Firefox addons -> ublock -> foxygestures
pause
# if the Script doesn't start maybe change the executionPolicy
# save your Policy first
# $pol = Get-ExecutionPolicy
# change it
  set-executionpolicy -executionPolicy Unrestricted -force
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
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" DisableWindowsConsumerFeatures 1

# Disable tipps about Windows 10
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" SoftLandingEnabled 0
New-Item "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Type DWord -Value 1 -Force
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0
Set-ItemProperty "HKCU:\Software\Microsoft\GameBar" ShowStartupPanel 0

# Allow Microphone Access
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" Value Allow
 
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
./Remove_Taskbaricons.ps1


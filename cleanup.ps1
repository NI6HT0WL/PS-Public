# Stop the WinRM service
Stop-Service WinRM -PassThru 
Set-Service WinRM -StartupType Disabled -PassThru

# Remove listeners
dir wsman:\localhost\listener
Remove-Item -Path WSMan:\Localhost\listener\<Listener name>
Remove-Item -Path WSMan:\Localhost\listener\listener* -Recurse

# Disable Firewall exceptions
Set-NetFirewallRule -DisplayName 'Windows Remote Management (HTTP-In)' -Enabled False -PassThru | Select -Property DisplayName, Profile, Enabled

# Restrict remote access to members of the Administrators group on the computer
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system -Name LocalAccountTokenFilterPolicy -Value 0

# Disable PSRemoting
Disable-PSRemoting -Force

# Set Execution Policy back to restricted
Set-ExecutionPolicy Restricted

# Remove Modules
Uninstall-Module -Name PSWindowsUpdate -Force
Uninstall-Module -Name NuGet -Force

# Remove Cleanup Script
Remove-Item C:\Windows\Temp\cleanup.ps1 -Force

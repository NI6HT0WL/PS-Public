# Stop the WinRM service
Stop-Service WinRM -PassThruSet-Service WinRM -StartupType Disabled -PassThru

# Remove listeners
dir wsman:\localhost\listener
Remove-Item -Path WSMan:\Localhost\listener\<Listener name>
Remove-Item -Path WSMan:\Localhost\listener\listener* -Recurse

# Disable Firewall exceptions
Set-NetFirewallRule -DisplayName 'Windows Remote Management (HTTP-In)' -Enabled False -PassThru | Select -Property DisplayName, Profile, Enabled

# Restrict remote access to members of the Administrators group on the computer
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system -Name LocalAccountTokenFilterPolicy -Value 0

Remove-Item C:\Windows\Temp\cleanup.ps1 -Force

set-ExecutionPolicy Unrestricted
Set-NetConnectionProfile -Name "Unidentified network" -NetworkCategory Private
Set-VMSwitch WSL -NetAdapterName Ethernet
Start-Sleep -s 1
wsl --user root /home/aa-ros/network-config.sh
Import-module .\MrInternetConnectionSharing.ps1 -Force
Get-MrInternetConnectionSharing -InternetInterfaceName "vEthernet (WSL) 2", "WiFi" 
Set-MrInternetConnectionSharing -InternetInterfaceName "WiFi" -LocalInterfaceName "vEthernet (WSL) 2" -Enabled $true
Start-Sleep -s 1
set-ExecutionPolicy Restricted
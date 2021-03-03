#set-ExecutionPolicy Unrestricted
Set-NetConnectionProfile -Name "Unidentified network" -NetworkCategory Private
Set-VMSwitch WSL -NetAdapterName Ethernet
Start-Sleep -s 1
wsl --user root /home/rob/network-config.sh
Import-module "C:\Users\rob\Desktop\MrInternetConnectionSharing.ps1" -Force
Set-MrInternetConnectionSharing -InternetInterfaceName "WiFi" -LocalInterfaceName "vEthernet (WSL) 2" -Enabled $true
Get-MrInternetConnectionSharing -InternetInterfaceName "vEthernet (WSL) 2", "WiFi" 
Start-Sleep -s 3
#set-ExecutionPolicy Restricted
#set-ExecutionPolicy Unrestricted
Import-module "C:\Users\Robert Bush\Desktop\MrInternetConnectionSharing.ps1" -Force
Set-MrInternetConnectionSharing -InternetInterfaceName "WiFi" -LocalInterfaceName "vEthernet (WSL) 2" -Enabled $false
Get-MrInternetConnectionSharing -InternetInterfaceName "vEthernet (WSL) 2", "WiFi" 
Start-Sleep -s 1
Set-VMSwitch WSL -SwitchType Internal
wsl --shutdown
Start-Sleep -s 2
wsl --user root /home/aa-ros/network-config.sh
Start-Sleep -s 1
#set-ExecutionPolicy Restricted
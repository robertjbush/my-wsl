#set-ExecutionPolicy Unrestricted
Import-module "C:\Users\rob\Desktop\MrInternetConnectionSharing.ps1" -Force
Set-MrInternetConnectionSharing -InternetInterfaceName "WiFi" -LocalInterfaceName "vEthernet (WSL) 2" -Enabled $false
Get-MrInternetConnectionSharing -InternetInterfaceName "vEthernet (WSL) 2", "WiFi" 
Start-Sleep -s 1
Set-VMSwitch WSL -SwitchType Internal
wsl --shutdown
Start-Sleep -s 2
wsl --user root /home/rob/network-config.sh
Start-Sleep -s 1
wsl --shutdown
#set-ExecutionPolicy Restricted
#set-ExecutionPolicy Unrestricted
Import-module "C:\Users\rob\Desktop\MrInternetConnectionSharing.ps1" -Force
Set-MrInternetConnectionSharing -InternetInterfaceName "Wi-Fi" -LocalInterfaceName "vEthernet (WSL)" -Enabled $false
Get-MrInternetConnectionSharing -InternetInterfaceName "vEthernet (WSL)", "Wi-Fi" 
Start-Sleep -s 1
Set-VMSwitch WSL -SwitchType Internal
wsl --shutdown
Start-Sleep -s 2
wsl --user root /mnt/c/Users/rob/network-config.sh
Start-Sleep -s 3
#wsl --shutdown
#set-ExecutionPolicy Restricted
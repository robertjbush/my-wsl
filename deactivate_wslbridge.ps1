#set-ExecutionPolicy Unrestricted
Import-module "C:\Users\Robert Bush\Desktop\MrInternetConnectionSharing.ps1" -Force
Set-MrInternetConnectionSharing -InternetInterfaceName "WiFi" -LocalInterfaceName "vEthernet (WSL) 2" -Enabled $false
Get-MrInternetConnectionSharing -InternetInterfaceName "vEthernet (WSL) 2", "WiFi" 
Start-Sleep -s 1
Set-VMSwitch WSL -SwitchType Internal
wsl --shutdown
#set-ExecutionPolicy Restricted
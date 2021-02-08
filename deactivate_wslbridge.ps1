set-ExecutionPolicy Unrestricted
Import-module .\MrInternetConnectionSharing.ps1 -Force
Set-MrInternetConnectionSharing -InternetInterfaceName "WiFi" -LocalInterfaceName "vEthernet (WSL) 2" -Enabled $false
Start-Sleep -s 1
Set-VMSwitch WSL -SwitchType Internal
wsl --shutdown
set-ExecutionPolicy Restricted
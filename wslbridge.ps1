set-ExecutionPolicy Unrestricted
$remoteport = bash.exe -c "ifconfig eth0 | grep 'inet '"
$found = $remoteport -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';

if( $found ){
  $remoteport = $matches[0];
} else{
  echo "The Script Exited, the ip address of WSL 2 cannot be found";
  exit;
}

#[Ports]

#All the ports you want to forward separated by coma (e.g. 80,443,10000,3000,5000)
$ports=@(9090,8080);


#[Static ip]
#You can change the addr to your ip config to listen to a specific address
$addr = '127.0.0.1';
$laddr1= bash.exe -c "ifconfig eth0 | grep -Po 'inet \K[\d.]+'";
$laddr2 = ((ipconfig | Select-String -Pattern WSL -Context 0,4 | findstr IPv4).Split()[-1]);
$laddr = @($laddr1, $laddr2);
$laddr_a = $laddr -join ",";
$ports_a = $ports -join ",";


#Remove Firewall Exception Rules
iex "Remove-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' ";
iex "Remove-NetFireWallRule -DisplayName 'X11 Window Server' ";

#adding Exception Rules for inbound and outbound Rules
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Outbound -LocalAddress $laddr_a -LocalPort $ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Inbound -LocalAddress $laddr_a -LocalPort $ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName 'X11 Window Server' -Direction Inbound -LocalAddress $laddr_a -LocalPort '6000' -Action Allow -Protocol TCP -Program 'C:\program files\vcxsrv\vcxsrv.exe'";
iex "New-NetFireWallRule -DisplayName 'X11 Window Server' -Direction Outbound -LocalAddress $laddr_a -LocalPort '6000' -Action Allow -Protocol TCP -Program 'C:\program files\vcxsrv\vcxsrv.exe'";


for( $i = 0; $i -lt $ports.length; $i++ ){
  $port = $ports[$i];
  iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr";
  iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$remoteport";
}
#X11 port forwarding
iex "netsh interface portproxy add v4tov4 listenport='6000' listenaddress=$addr connectport='6000' connectaddress=$laddr2";
set-ExecutionPolicy Restricted
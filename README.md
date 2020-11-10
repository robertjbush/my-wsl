# my-wsl

1. In WSL start `x11-over-vsock` and set `DISPLAY=:0`.
2. Start x-server (e.g. vxsrv) on TCP port 6000.
3. Execute `x11-over-vsock.exe --daemon` with admin privileges.

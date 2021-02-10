# my-wsl
For reference: https://github.com/nbdd0121/x11-over-vsock
1. In WSL start `wsld` and set `DISPLAY=:0`.
2. Start x-server (e.g. vxsrv) on TCP port 6000.
3. Execute `wsldhost.exe --daemon` with admin privileges.
---
To run scripts on local machine first set your `CurrentUser` execution policy:
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Get-ExecutionPolicy -List
```

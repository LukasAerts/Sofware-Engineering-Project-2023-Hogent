# Transfer a file securely to a Windows server

## Copy-Item through a PSSession via Powershell
### Prerequisite 
- Remote computer and server need to be on the same network or a route needs to exist beteen them.
- Remote managment must be enabled on the server
  - use the following command with eleviated permissions: ```powershell Enable-PSRemoting -Force ```
- Windows PowerShell Execution Policy must allow you to execute remote commands
  - use the following command with elevated permissons ```powershell Set-ExecutionPolicy RemoteSigned ```   
- Firewall rules: The Windows Server must allow traffic on the ports required for PowerShell remoting. The default ports for PowerShell remoting are TCP 5985 and TCP 5986 for HTTP and HTTPS connections, respectively.
### command
```powershell
    $Session = New-PSSession -ComputerName SERVER_IP_ADDRESS -Credential (Get-Credential)
    Copy-Item -Path "LOCAL_PATH_TO_SCRIPT" -Destination "REMOTE_PATH_TO_SCRIPT" -ToSession $Session
    Remove-PSSession $Session
```
# SFTP
### Prerequisite

    <!-- Procedure needs to be completed and fine tuned -->  
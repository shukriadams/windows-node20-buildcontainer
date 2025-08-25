FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set shell to PowerShell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# install nodejs 20, confirm installation with --version check
RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    Invoke-WebRequest -Uri https://nodejs.org/dist/v20.19.4/node-v20.19.4-x64.msi -OutFile node-installer.msi ; \
    cmd.exe /c "msiexec /i node-installer.msi /quiet /log node-install.log"; \
    Remove-Item node-installer.msi -Force ; \
    node --version

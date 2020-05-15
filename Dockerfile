FROM mcr.microsoft.com/powershell

LABEL Description="PowerShell Container" Vendor="Microsoft" Version="1.0"
RUN pwsh -Command Install-Module -Name AWSPowerShell.NetCore -Force

CMD [ "pwsh" ]
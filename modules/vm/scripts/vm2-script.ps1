Install-WindowsFeature -Name Web-Server -IncludeManagementTools
Set-Content -Path "C:\inetpub\wwwroot\Default.htm" -Value "<h1>Server 2</h1>"

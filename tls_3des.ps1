#Author: Andrew McDonald W0426368
#Name: tls_3des.ps1
#Decription: disable TLS 1.0 and 1.1. disable 3DES. enable TLS 1.2. restart server
#Date Created: February 4, 2023
#Date Modified: February 6, 2023

#create new registry keys to disable TLS 1.0 as a server and set it disabled by default

New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null


#create new registry keys to disable TLS 1.1 as a server and set it to disabled by default

New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null

#create registry keys to set TLS 1.2 to be enabled/enabled by default

New-Item ‘HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server’ -Force
New-ItemProperty -Path ‘HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server’ -Name ‘Enabled’ -Value ‘0xffffffff’ –PropertyType 'DWord'
New-ItemProperty -Path ‘HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server’ -Name ‘DisabledByDefault’ -Value 0 –PropertyType 'DWord'

#disable the 3DES cipher from TLS 1.2 

Disable-TlsCipherSuite -Name "TLS_RSA_WITH_3DES_EDE_CBC_SHA"

#display actions to user

Write-Host "TLS 1.0 and 1.1 disabled" -ForegroundColor Yellow
Write-Host "3DES cipher disabled" -ForegroundColor Yellow
Write-Host "Server will restart in 10 seconds..." -ForegroundColor Cyan

#restart the server after 10 second pause
Start-Sleep 10
Restart-Computer

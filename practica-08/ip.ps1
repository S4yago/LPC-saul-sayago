function Get-PublicIP {
    $IP = Invoke-WebRequest ifconfig.me | Select-Object -ExpandProperty Content
    Write-Output "Tu IP publica es: "$IP "`n"
}

function Get-LocalIP {
    $IP = Get-NetIPAddress -AddressFamily IPv4 | Format-Table
    Write-Output "Tu IP local es: "$IP "`n"
}

Get-PublicIP
Get-LocalIP

function Get-PublicIP {
    $IP = Invoke-WebRequest ifconfig.me | Select-Object -ExpandProperty Content
    Write-Output "Tu IP publica es: "$IP "`n"
}

function Get-LocalIP {
    $IP = Get-NetIPAddress -AddressFamily IPv4 | Format-Table
    Write-Output "Tu IP local es: "$IP "`n"
}

function Use-Nmap {
    $IP = Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex 11
    $IPAddress = $IP.IPAddress
    $Nmap = nmap.exe $IPAddress
    Write-Output "Se realizó un escaneo ==> "$IPAddress $Nmap
}

function Use-NmapWithURL {
    $url = Read-Host -Prompt 'Ingresa la url: '
    $Nmap = nmap.exe $url
    Write-Output "`n" "Se realizó un escaneo ==> "$url $Nmap
}

function Main {
    Get-PublicIP | Out-File -FilePath ./result.txt
    Get-LocalIP | Out-File -FilePath ./result.txt -Append
    Use-Nmap | Out-File -FilePath ./result.txt -Append
    Use-NmapWithURL | Out-File -FilePath ./result.txt -Append
}

Main

$file = ".\result.txt"
[System.Convert]::ToBase64String((Get-Content $file -Encoding Byte)) | Out-File -FilePath ./encrypted-result.txt

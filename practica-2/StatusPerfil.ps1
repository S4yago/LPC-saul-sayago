function Cambiar-StatusPerfil{
    param([Parameter(Mandatory)] [ValidateSet("Public","Private")] [string] $perfil)
    $status = Get-NetFirewallProfile -Name $perfil  
    Write-Host "Perfil:" $perfil  
    if($status.enabled){  
        Write-Host "Status actual: Activado"  
        $opc = Read-Host -Promt "Deseas desactivarlo? [Y] Si [N] No"  
            if ($opc -eq "Y"){  
                Set-NetFirewallProfile -Name $perfil -Enabled False  
            }  
    } else{
        Write-Host "Status: Desactivado"  
        $opc = Read-Host -Promt "Deseas activarlo? [Y] Si [N] No"  
        if ($opc -eq "Y"){  
            Write-Host "Activando perfil"  
            Set-NetFirewallProfile -Name $perfil -Enabled True  
        }  
    }  
    Ver-StatusPerfil -perfil $perfil  
}

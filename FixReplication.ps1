Write-Host "Please enter Domain Admin credentials" -ForegroundColor Green
$creds = Get-Credential
$un = $creds.username
$pw = $creds.GetNetworkCredential().password

Write-Host "Finding the PDC emulator FQDN" -ForegroundColor Green
$PDCemulator = (get-addomain).pdcemulator

Write-Host "Finding all the DCs" -ForegroundColor Green
$DomainName = (Get-ADDomain).DNSRoot
$DCs = Get-ADDomainController -Filter * -Server $DomainName | Select -expandproperty Name

Write-Host "Finding DNS root" -ForegroundColor Green
$OU = Get-ADDomain | Select -expandproperty DistinguishedName
$Config = "CN=Configuration," + $OU
$Schema = "CN=Schema," + $Config
$DomainDNS = "DC=DomainDNSZones," + $OU
$ForestDNS = "DC=ForestDNSZones," + $OU

Write-Host "Attempting to sync all naming contexts across all sites on" $PDCemulator -ForegroundColor Green
repadmin /syncall /A /e 

Write-Host "Recalculating inbound topology on" $PDCemulator -ForegroundColor Green
repadmin /kcc

foreach($DC in $DCs) {
    Write-Host "Attempting to replicate both ways between the PDC emulator" $PDCemulator "and" $DC -ForegroundColor Green
    repadmin /replicate $DC $PDCemulator $OU
    repadmin /replicate $PDCemulator $DC $OU

    repadmin /replicate $DC $PDCemulator $Config
    repadmin /replicate $PDCemulator $DC $Config

    repadmin /replicate $DC $PDCemulator $Schema
    repadmin /replicate $PDCemulator $DC $Schema

    repadmin /replicate $DC $PDCemulator $DomainDNS
    repadmin /replicate $PDCemulator $DC $DomainDNS

    repadmin /replicate $DC $PDCemulator $ForestDNS
    repadmin /replicate $PDCemulator $DC $ForestDNS
    
    Write-Host "Attempting to sync all naming contexts across all sites on" $DC -ForegroundColor Green
    Invoke-Command $DC -scriptblock {repadmin /syncall /A /e}
    
    Write-Host "Recalculating inbound topology on" $DC -ForegroundColor Green
    Invoke-Command $DC -scriptblock {repadmin /kcc}
    
    Write-Host "Stopping Key Distribution Center service on" $DC "in order to attempt to reset keys" -ForegroundColor Green
    Invoke-Command $DC -scriptblock {net stop kdc}

    Write-Host "Attempting to replicate between the PDC emulator" $PDCemulator "and" $DC -ForegroundColor Green
    repadmin /replicate $DC $PDCemulator $OU
    repadmin /replicate $DC $PDCemulator $Config
    repadmin /replicate $DC $PDCemulator $Schema
    repadmin /replicate $DC $PDCemulator $DomainDNS
    repadmin /replicate $DC $PDCemulator $ForestDNS

    Write-Host "Resetting machine password on" $DC -ForegroundColor Green
    netdom resetpwd /Server:$DC /UserD:$un /PasswordD:$pw

    Write-Host "Restarting Key Distribution Center on" $DC -ForegroundColor Green
    Invoke-Command $DC -scriptblock {net start kdc}

    Write-Host "Checking SPN registration on " $DC -ForegroundColor Green
    dcdiag /test:checksecurityerror replsource:$DC

    Write-Host "Flushing Kerberos tickets for system account on " $DC -ForegroundColor Green
    Invoke-Command $DC -scriptblock {KLIST -li 0x3e7 purge}

    }

Write-Host "Flushing Kerberos tickets for logged-on user on " $PDCemulator -ForegroundColor Green
    KLIST purge

Write-Host "Flushing Kerberos tickets for system account on " $PDCemulator -ForegroundColor Green
    KLIST -li 0x3e7 purge

Write-Host "Attempting to sync all naming contexts across all sites on " $PDCemulator -ForegroundColor Green
    repadmin /syncall /A /e 

Write-Host "Recalculating inbound topology on " $PDCemulator -ForegroundColor Green
    repadmin /kcc

foreach($DC in $DCs) {
    Write-Host "Reattempting to replicate both ways between the PDC emulator" $PDCemulator "and" $DC -ForegroundColor Green
    repadmin /replicate $DC $PDCemulator $OU
    repadmin /replicate $PDCemulator $DC $OU

    repadmin /replicate $DC $PDCemulator $Config
    repadmin /replicate $PDCemulator $DC $Config

    repadmin /replicate $DC $PDCemulator $Schema
    repadmin /replicate $PDCemulator $DC $Schema

    repadmin /replicate $DC $PDCemulator $DomainDNS
    repadmin /replicate $PDCemulator $DC $DomainDNS

    repadmin /replicate $DC $PDCemulator $ForestDNS
    repadmin /replicate $PDCemulator $DC $ForestDNS
    }

repadmin /showrepl -errorsonly
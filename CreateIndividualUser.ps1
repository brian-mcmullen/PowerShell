$creds = Get-Credential

Invoke-Command -ComputerName 11meulhddc01 -Credential $creds {

Write-Host "First name?" -ForegroundColor Green
$FirstName=read-Host
Write-Host "Last name?" -ForegroundColor Green
$LastName=read-Host
Write-Host "Rank?" -ForegroundColor Green
$Rank=read-Host
Write-Host "EDIPI?" -ForegroundColor Green
$EDIPI=read-Host
Write-Host "MSE?" -ForegroundColor Green
$MSE=read-Host


# Password length
$length = 20
 
# Characters
$chars = (48..57) + (65..90) + (97..122) + 36 + 33

$chars | Get-Random -Count $length | %{ $Password += [char]$_ }

    $OU = $null
    if ($MSE -eq 'ACE') {$OU = 'OU=Users,OU=ACE,OU=11MEULHD,DC=11MEULHD,DC=usmc,DC=mil'}
    if ($MSE -eq 'CE') {$OU = 'OU=Users,OU=CE,OU=11MEULHD,DC=11MEULHD,DC=usmc,DC=mil'}
    if ($MSE -eq 'LCE') {$OU = 'OU=Users,OU=LCE,OU=11MEULHD,DC=11MEULHD,DC=usmc,DC=mil'}
    if ($MSE -eq 'GCE') {$OU = 'OU=Users,OU=GCE,OU=11MEULHD,DC=11MEULHD,DC=usmc,DC=mil'}

$EDIPI = $EDIPI + '117274@mil'

New-ADUser -SamAccountName "$Firstname.$Lastname" `
               -GivenName $Firstname `
               -Surname $Lastname `
               -Name "$Lastname $Rank $Firstname" `
               -Enabled $true `
               -DisplayName "$Lastname $Rank $Firstname" `
               -Path $OU `
               -Title $Rank `
               -EmailAddress "$Firstname.$Lastname@11MEULHD.usmc.mil" `
               -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $False `
               -SmartCardLogonRequired $true `
               -PasswordNeverExpires $true `
               -UserPrincipalName $EDIPI `
               -Department $MSE
     
     $OFFICER = $null
     $SNCO = $null
     $CE = $null
     $ACE = $null
     $LCE = $null
     $GCE = $null

     if ($rank -eq 'Pvt') {$SNCO = $false ; Add-ADGroupMember -Identity "RiverCity Tier-4" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'PFC') {$SNCO = $false ; Add-ADGroupMember -Identity "RiverCity Tier-4" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'LCpl') {$SNCO = $false ; Add-ADGroupMember -Identity "RiverCity Tier-4" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'Cpl') {$SNCO = $false ; Add-ADGroupMember -Identity "RiverCity Tier-4" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'Sgt') {$SNCO = $false ; Add-ADGroupMember -Identity "RiverCity Tier-4" -Members "$Firstname.$Lastname"}

     if ($rank -eq 'SSgt') {$SNCO = $true ; Add-ADGroupMember -Identity "RiverCity Tier-4" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'GySgt') {$SNCO = $true ; Add-ADGroupMember -Identity "RiverCity Tier-3" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'MSgt') {$SNCO = $true ; Add-ADGroupMember -Identity "RiverCity Tier-2" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'MGySgt') {$SNCO = $true ; Add-ADGroupMember -Identity "RiverCity Tier-2" -Members "$Firstname.$Lastname"}
     if ($rank -eq '1stSgt') {$SNCO = $true ; Add-ADGroupMember -Identity "RiverCity Tier-2" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'SgtMaj') {$SNCO = $true ; Add-ADGroupMember -Identity "RiverCity Tier-2" -Members "$Firstname.$Lastname"}

     if ($rank -eq 'WO') {$OFFICER = $true ; Add-ADGroupMember -Identity "RiverCity Tier-3" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'CWO2') {$OFFICER = $true ; Add-ADGroupMember -Identity "RiverCity Tier-3" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'CWO3') {$OFFICER = $true ; Add-ADGroupMember -Identity "RiverCity Tier-3" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'CWO4') {$OFFICER = $true ; Add-ADGroupMember -Identity "RiverCity Tier-3" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'CWO5') {$OFFICER = $true ; Add-ADGroupMember -Identity "RiverCity Tier-3" -Members "$Firstname.$Lastname"}

     if ($rank -eq '2ndLt') {$OFFICER = $true ; Add-ADGroupMember -Identity "RiverCity Tier-3" -Members "$Firstname.$Lastname"}
     if ($rank -eq '1stLt') {$OFFICER = $true ; Add-ADGroupMember -Identity "RiverCity Tier-3" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'Capt') {$OFFICER = $true ; Add-ADGroupMember -Identity "RiverCity Tier-3" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'Maj') {$OFFICER = $true ; Add-ADGroupMember -Identity "RiverCity Tier-2" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'LtCol') {$OFFICER = $true ; Add-ADGroupMember -Identity "RiverCity Tier-2" -Members "$Firstname.$Lastname"}
     if ($rank -eq 'Col') {$OFFICER = $true ; Add-ADGroupMember -Identity "RiverCity Tier-2" -Members "$Firstname.$Lastname"}


     if ($MSE -eq 'CE') {$CE = $true}
     if ($MSE -eq 'ACE') {$ACE = $true}
     if ($MSE -eq 'LCE') {$LCE = $true}
     if ($MSE -eq 'GCE') {$GCE = $true}

     if ($SNCO -eq $false -and $ACE -eq $true) {Add-ADGroupMember -Identity "11MEULHD_ACE_E-5_Below" -Members "$Firstname.$Lastname"}
     if ($SNCO -eq $true -and $ACE -eq $true) {Add-ADGroupMember -Identity "11MEULHD_ACE_SNCO" -Members "$Firstname.$Lastname" ; Add-ADGroupMember -Identity "11MEULHD_ACE_Officers_And_SNCOS" -Members "$Firstname.$Lastname"}
     if ($OFFICER -eq $true -and $ACE -eq $true) {Add-ADGroupMember -Identity "11MEULHD_ACE_Officers" -Members "$Firstname.$Lastname" ; Add-ADGroupMember -Identity "11MEULHD_ACE_Officers_And_SNCOS" -Members "$Firstname.$Lastname"}

     if ($SNCO -eq $false -and $CE -eq $true) {Add-ADGroupMember -Identity "11MEULHD_CE_E-5_Below" -Members "$Firstname.$Lastname"}
     if ($SNCO -eq $true -and $CE -eq $true) {Add-ADGroupMember -Identity "11MEULHD_CE_SNCO" -Members "$Firstname.$Lastname" ;
     if ($OFFICER -eq $true -and $CE -eq $true) {Add-ADGroupMember -Identity "11MEULHD_CE_Officers" -Members "$Firstname.$Lastname" ; Add-ADGroupMember -Identity "11MEULHD_CE_Officers_And_SNCOS" -Members "$Firstname.$Lastname"}

     if ($SNCO -eq $false -and $LCE -eq $true) {Add-ADGroupMember -Identity "11MEULHD_LCE_E-5_Below" -Members "$Firstname.$Lastname"}
     if ($SNCO -eq $true -and $LCE -eq $true) {Add-ADGroupMember -Identity "11MEULHD_LCE_SNCO" -Members "$Firstname.$Lastname" ; Add-ADGroupMember -Identity "11MEULHD_LCE_Officers_And_SNCOS" -Members "$Firstname.$Lastname"}
     if ($OFFICER -eq $true -and $LCE -eq $true) {Add-ADGroupMember -Identity "11MEULHD_LCE_Officers" -Members "$Firstname.$Lastname" ; Add-ADGroupMember -Identity "11MEULHD_LCE_Officers_And_SNCOS" -Members "$Firstname.$Lastname"}

     if ($SNCO -eq $false -and $GCE -eq $true) {Add-ADGroupMember -Identity "11MEULHD_GCE_E-5_Below" -Members "$Firstname.$Lastname"}
     if ($SNCO -eq $true -and $GCE -eq $true) {Add-ADGroupMember -Identity "11MEULHD_GCE_SNCO" -Members "$Firstname.$Lastname" ; Add-ADGroupMember -Identity "11MEULHD_GCE_Officers_And_SNCOS" -Members "$Firstname.$Lastname"}
     if ($OFFICER -eq $true -and $GCE -eq $true) {Add-ADGroupMember -Identity "11MEULHD_GCE_Officers" -Members "$Firstname.$Lastname" ; Add-ADGroupMember -Identity "11MEULHD_GCE_Officers_And_SNCOS" -Members "$Firstname.$Lastname"}

     $Password = $null

     } }
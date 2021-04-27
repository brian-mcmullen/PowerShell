$ADuser = Import-Csv 'C:\Users\brmcmul\Desktop\MEU\11 MEU\MyScripts\11MEUFWD\AllUsers.csv'

# Password length
$length = 20
 
# Characters
$chars = (48..57) + (65..90) + (97..122) + 36 + 33

Foreach ($User in $ADuser) {
    #generate password
    $chars | Get-Random -Count $length | %{ $Password += [char]$_ }

    $OU = $null
    if ($User.MSE -eq 'ACE') {$OU = 'OU=Users,OU=ACE,OU=11MEUFWD,DC=11MEUFWD,DC=usmc,DC=mil'}
    if ($User.MSE -eq 'CE') {$OU = 'OU=Users,OU=CE,OU=11MEUFWD,DC=11MEUFWD,DC=usmc,DC=mil'}
    if ($User.MSE -eq 'LCE') {$OU = 'OU=Users,OU=LCE,OU=11MEUFWD,DC=11MEUFWD,DC=usmc,DC=mil'}
    if ($User.MSE -eq 'GCE') {$OU = 'OU=Users,OU=GCE,OU=11MEUFWD,DC=11MEUFWD,DC=usmc,DC=mil'}
    $Firstname = $User.FirstName
    $Lastname = $User.Lastname
    $Rank = $User.Rank
    $EDIPI = $User.EDIPI + "insert PIV num here" + "@mil"
    
    New-ADUser -SamAccountName "$Firstname.$Lastname" `
               -GivenName $Firstname `
               -Surname $Lastname `
               -Name "$Lastname $Rank $Firstname" `
               -Enabled $false `
               -DisplayName "$Lastname $Rank $Firstname" `
               -Path $OU `
               -Title $Rank `
               -EmailAddress "$Firstname.$Lastname@11MEUFWD.usmc.mil" `
               -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $False `
               -SmartCardLogonRequired $true `
               -PasswordNeverExpires $true `
               -UserPrincipalName $EDIPI `
               -Department $User.MSE


     if ($User.MSE -eq 'ACE') {Add-ADGroupMember -Identity "ACE_ALL_HANDS" -Members "$Firstname.$Lastname"}
     if ($User.MSE -eq 'CE') {Add-ADGroupMember -Identity "CE_ALL_HANDS" -Members "$Firstname.$Lastname"}
     if ($User.MSE -eq 'LCE') {Add-ADGroupMember -Identity "LCE_ALL_HANDS" -Members "$Firstname.$Lastname"}
     if ($User.MSE -eq 'GCE') {Add-ADGroupMember -Identity "GCE_ALL_HANDS" -Members "$Firstname.$Lastname"}
     
     $OFFICER = $null
     $SNCO = $null
     $CE = $null
     $ACE = $null
     $LCE = $null
     $GCE = $null

     if ($User.Rank -eq 'SSgt') {$SNCO = $true}
     if ($User.Rank -eq 'GySgt') {$SNCO = $true}
     if ($User.Rank -eq 'MSgt') {$SNCO = $true}
     if ($User.Rank -eq 'MGySgt') {$SNCO = $true}
     if ($User.Rank -eq '1stSgt') {$SNCO = $true}
     if ($User.Rank -eq 'SgtMaj') {$SNCO = $true}

     if ($User.Rank -eq '2ndLt') {$OFFICER = $true}
     if ($User.Rank -eq '1stLt') {$OFFICER = $true}
     if ($User.Rank -eq 'Capt') {$OFFICER = $true}
     if ($User.Rank -eq 'Maj') {$OFFICER = $true}
     if ($User.Rank -eq 'LtCol') {$OFFICER = $true}
     if ($User.Rank -eq 'Col') {$OFFICER = $true}


     if ($User.MSE -eq 'CE') {$CE = $true}
     if ($User.MSE -eq 'ACE') {$ACE = $true}
     if ($User.MSE -eq 'LCE') {$LCE = $true}
     if ($User.MSE -eq 'GCE') {$GCE = $true}

     if ($SNCO -eq $true -and $ACE -eq $true) {Add-ADGroupMember -Identity "ACE_SNCO" -Members "$Firstname.$Lastname"}
     if ($OFFICER -eq $true -and $ACE -eq $true) {Add-ADGroupMember -Identity "ACE_OFFICERS" -Members "$Firstname.$Lastname"}

     if ($SNCO -eq $true -and $CE -eq $true) {Add-ADGroupMember -Identity "CE_SNCO" -Members "$Firstname.$Lastname"}
     if ($OFFICER -eq $true -and $CE -eq $true) {Add-ADGroupMember -Identity "CE_OFFICERS" -Members "$Firstname.$Lastname"}

     if ($SNCO -eq $true -and $LCE -eq $true) {Add-ADGroupMember -Identity "LCE_SNCO" -Members "$Firstname.$Lastname"}
     if ($OFFICER -eq $true -and $LCE -eq $true) {Add-ADGroupMember -Identity "LCE_OFFICERS" -Members "$Firstname.$Lastname"}

     if ($SNCO -eq $true -and $GCE -eq $true) {Add-ADGroupMember -Identity "GCE_SNCO" -Members "$Firstname.$Lastname"}
     if ($OFFICER -eq $true -and $GCE -eq $true) {Add-ADGroupMember -Identity "GCE_OFFICERS" -Members "$Firstname.$Lastname"}
      
     #blank password so a new password can be generated for the next user         
     $password = $null
              
    -whatif
               }

    




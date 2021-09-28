    $RC1 = "RiverCity Tier-1"
    $RC2 = "RiverCity Tier-2"
    $RC3 = "RiverCity Tier-3"
    $RC4 = "RiverCity Tier-4"
    
$users = Get-ADUser -filter 'samaccountname -like "*"' -Properties MemberOf,SamAccountName,Name| Select-Object MemberOf,SamAccountName,Name

   Foreach($user in $users) {
        if ((!($user.MemberOf -match $RC1) -xor !($user.MemberOf -match $RC2) -xor !($user.MemberOf -match $RC3) -xor !($user.MemberOf -match $RC4)) -eq 'true')
            {
                Write-Host $User.SamAccountName"is already a member of a River City group"    
            }
        
        else
            {
                #MEU and MSE COs
                if ($User.Name -like 'LName Col FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName LtCol FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName LtCol FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName LtCol FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName LtCol FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                
                #MEU and MSE XOs
                if ($User.Name -like 'LName LtCol FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName Maj FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName LtCol FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName Maj FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName Maj FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}

                #MEU and MSE SgtsMaj
                if ($User.Name -like 'LName SgtMaj FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName SgtMaj FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName SgtMaj FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName SgtMaj FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName SgtMaj FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}

                #MEU Chaplain
                if ($User.Name -like 'LName LCDR FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}

                #MEU Primary Staff Officers
                if ($User.Name -like 'LName Capt FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName Maj FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName LtCol FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName Maj FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                if ($User.Name -like 'LName Maj FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}

                #MEU Staff Judge Advocate
                if ($User.Name -like 'LName Maj FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}

                #MEU COMMSTRAT Officer
                if ($User.Name -like 'LName Capt FName') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                
                #Marines
                if ($User.Name -like '* Pvt *') {Add-ADGroupMember -Identity "RiverCity Tier-4" -Members $user.samaccountname}
                if ($User.Name -like '* PFC *') {Add-ADGroupMember -Identity "RiverCity Tier-4" -Members $user.samaccountname}
                if ($User.Name -like '* LCpl *') {Add-ADGroupMember -Identity "RiverCity Tier-4" -Members $user.samaccountname}
                if ($User.Name -like '* Cpl *') {Add-ADGroupMember -Identity "RiverCity Tier-4" -Members $user.samaccountname}
                if ($User.Name -like '* Sgt *') {Add-ADGroupMember -Identity "RiverCity Tier-4" -Members $user.samaccountname}

                if ($User.Name -like '* SSgt *') {Add-ADGroupMember -Identity "RiverCity Tier-4" -Members $user.samaccountname}
                if ($User.Name -like '* GySgt *') {Add-ADGroupMember -Identity "RiverCity Tier-3" -Members $user.samaccountname}
                if ($User.Name -like '* MSgt *') {Add-ADGroupMember -Identity "RiverCity Tier-2" -Members $user.samaccountname}
                if ($User.Name -like '* MGySgt *') {Add-ADGroupMember -Identity "RiverCity Tier-2" -Members $user.samaccountname}
                if ($User.Name -like '* 1stSgt *') {Add-ADGroupMember -Identity "RiverCity Tier-2" -Members $user.samaccountname}
                if ($User.Name -like '* SgtMaj *') {Add-ADGroupMember -Identity "RiverCity Tier-2" -Members $user.samaccountname}

                if ($User.Name -like '* WO *') {Add-ADGroupMember -Identity "RiverCity Tier-3" -Members $user.samaccountname}
                if ($User.Name -like '* CWO2 *') {Add-ADGroupMember -Identity "RiverCity Tier-3" -Members $user.samaccountname}
                if ($User.Name -like '* CWO3 *') {Add-ADGroupMember -Identity "RiverCity Tier-3" -Members $user.samaccountname}
                if ($User.Name -like '* CWO4 *') {Add-ADGroupMember -Identity "RiverCity Tier-3" -Members $user.samaccountname}
                if ($User.Name -like '* CWO5 *') {Add-ADGroupMember -Identity "RiverCity Tier-2" -Members $user.samaccountname}

                if ($User.Name -like '* 2ndLt *') {Add-ADGroupMember -Identity "RiverCity Tier-3" -Members $user.samaccountname}
                if ($User.Name -like '* 1stLt *') {Add-ADGroupMember -Identity "RiverCity Tier-3" -Members $user.samaccountname}
                if ($User.Name -like '* Capt *') {Add-ADGroupMember -Identity "RiverCity Tier-3" -Members $user.samaccountname}
                if ($User.Name -like '* Maj *') {Add-ADGroupMember -Identity "RiverCity Tier-2" -Members $user.samaccountname}
                if ($User.Name -like '* LtCol *') {Add-ADGroupMember -Identity "RiverCity Tier-2" -Members $user.samaccountname}
                if ($User.Name -like '* Col *') {Add-ADGroupMember -Identity "RiverCity Tier-2" -Members $user.samaccountname}
                if ($User.Name -like '* BGen *') {Add-ADGroupMember -Identity "RiverCity Tier-1" -Members $user.samaccountname}
                
                #Contractors
                if ($User.Name -like '* CIV *') {Add-ADGroupMember -Identity "RiverCity Tier-2" -Members $User.samaccountname}
                if ($User.Name -like '* CTR *') {Add-ADGroupMember -Identity "RiverCity Tier-3" -Members $User.samaccountname}

                #Navy (incomplete)
                if ($User.Name -like '* HM3 *') {Add-ADGroupMember -Identity "RiverCity Tier-4" -Members $User.samaccountname}
                if ($User.Name -like '* HM2 *') {Add-ADGroupMember -Identity "RiverCity Tier-4" -Members $User.samaccountname}
                if ($User.Name -like '* HM1 *') {Add-ADGroupMember -Identity "RiverCity Tier-4" -Members $User.samaccountname}
                if ($User.Name -like '* RP3 *') {Add-ADGroupMember -Identity "RiverCity Tier-3" -Members $User.samaccountname}
                if ($User.Name -like '* RP2 *') {Add-ADGroupMember -Identity "RiverCity Tier-3" -Members $User.samaccountname}
                if ($User.Name -like '* RP1 *') {Add-ADGroupMember -Identity "RiverCity Tier-3" -Members $User.samaccountname}
 
                if ($User.Name -like '* SCPO *') {Add-ADGroupMember -Identity "RiverCity Tier-2" -Members $User.samaccountname}

                write-host $User.SamAccountName"is added to a River City group"
            }
        }

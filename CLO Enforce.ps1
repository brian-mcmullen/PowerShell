$searchbase = "OU=S-6,OU=Users,OU=CE,OU=MEUFWD,DC=MEUFWD,DC=usmc,DC=mil"

$accountlist = "C:\CLOexemptaccounts.csv" 

$cloexemptusers = Get-ADUser -SearchBase $searchbase -Filter {smartcardlogonrequired -eq $false} | fl Name,Description,Enabled,SmartCardLogonRequired
$cloexemptusers | Export-Csv $accountlist -NoTypeInformation

Get-ADUser -SearchBase $searchbase -Filter {smartcardlogonrequired -eq $false} | ForEach-Object {Set-ADUSer -Identity $_ -SmartcardLogonRequired $True} 
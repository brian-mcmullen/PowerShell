$ButtonTypeEnd = [System.Windows.MessageBoxButton]::OK
$MessageboxTitleEnd = "Disabled inactive accounts"
$MessageboxbodyEnd = "The script has now finished running."
$MessageIconEnd = [System.Windows.MessageBoxImage]::Information


$Look_Here = "OU=MEUFWD,DC=MEUFWD,DC=usmc,DC=mil"

$OutPath = "C:\"

$Logdate = Get-date -f yyyy.MM.dd.hh.mm

$ADDate = get-date -f yyyy.MM.dd

$End = $OutPath + "u_ll_more_than_90$logdate.csv"



$90dayusers = Get-ADUser -filter * -SearchBase $Look_Here -Properties * | where {
            ($_.lastlogondate -lt (get-date ).AddDays(-90))}
               
$90dayusers | % {set-aduser -identity $_.samaccountname -Description "Disabled from lack of activity: $ADDate" -Enabled $false -SmartcardLogonRequired $true}


$GrabInfo = $90dayusers | select Name, Description,Enabled,SmartCardLogonRequired

$GrabInfo | Export-Csv $End -NoTypeInformation

[System.Windows.MessageBox]::Show($MessageboxbodyEnd,$MessageboxTitleEnd,$ButtonTypeEnd,$MessageIconEnd)
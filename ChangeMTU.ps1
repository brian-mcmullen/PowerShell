$netadapter = Get-NetAdapter -name "ethernet*" | select -ExpandProperty ifindex
$adaptername = Get-NetAdapter -name "ethernet*" | select -ExpandProperty name
$MTU = 1200

foreach($net in $netadapter) {
    Set-NetIPInterface -NlMtuBytes $MTU -InterfaceIndex 22
    }
foreach($name in $adaptername) {
    Set-NetAdapterAdvancedProperty -Name $name -DisplayName "MTU" -DisplayValue $MTU -RegistryValue $MTU
    }

Get-NetAdapterAdvancedProperty -name "ethernet *" -DisplayName "MTU"
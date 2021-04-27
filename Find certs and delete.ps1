Get-ChildItem -Path 'Cert:\LocalMachine\Remote Desktop' |
 Where-Object { $_.Issuer -like "CN=HOSTNAME*" } |
 ForEach-Object { $Path = 'Cert:\LocalMachine\Remote Desktop\' + $_.Thumbprint ; Get-childitem $Path }


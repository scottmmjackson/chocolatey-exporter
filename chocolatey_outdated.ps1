$filename = "C:\Program Files\windows_exporter\textfile_inputs\chocolatey.prom"
$data = choco outdated -r | measure -line; 
echo @"
# HELP chocolatey_outdated The number of outdated chocolatey packages
# TYPE chocolatey_outdated counter
chocolatey_outdated{} $($data.Lines)
# HELP chocolatey_last_checked The last time we checked for outdated chocolatey packages, in epoch seconds.
# TYPE chocolatey_last_checked counter
chocolatey_last_checked{} $([Math]::Floor([decimal](Get-Date(Get-Date).ToUniversalTime()-UFormat "%s")))
"@ | set-content $filename
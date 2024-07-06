$filename = "C:\Program Files\windows_exporter\textfile_inputs\chocolatey.prom"
$data = choco outdated -r;
$count = $data | measure -Line;
$packages = @"
# HELP chocolatey_outdated_package Package that is outdated.
# TYPE chocolatey_outdated_package counter
"@
foreach ($line in $data -split "`n") {
    $parts = $line -split "\|"
    $packages += "`n"
    $packages += "chocolatey_outdated_package{package=`"$($parts[0])`",currentVersion=`"$($parts[1])`",latestVersion=`"$($parts[2])`",isPinned=`"$($parts[3])`"} 1"
}
echo @"
$($packages)
# HELP chocolatey_outdated The number of outdated chocolatey packages
# TYPE chocolatey_outdated counter
chocolatey_outdated{} $($count.Lines)
# HELP chocolatey_last_checked The last time we checked for outdated chocolatey packages, in epoch seconds.
# TYPE chocolatey_last_checked gauge
chocolatey_last_checked{} $([Math]::Floor([decimal](Get-Date(Get-Date).ToUniversalTime()-UFormat "%s")))
"@ | set-content $filename

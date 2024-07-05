# Chocolatey Exporter

This is an alpha release of something that's just really helpful to me. If you have chocolatey, feel free to utilize
this powershell script to enable alerting for outdated scripts.

# Requirements

- [Chocolatey](https://chocolatey.org/)
- [Prometheus Windows Exporter](https://community.chocolatey.org/packages/prometheus-windows-exporter.install)

If you have chocolatey, you can install the prometheus windows exporter by:

```PowerShell
choco install prometheus-windows-exporter.install -y
```

# Installation

Move `chocolatey_outdated.ps1` to an appropriate directory. Consider that it will be executed by `System` or a service
account with both chocolatey access and write access to Program Files, and handle your security accordingly.

**THIS IS NOT SAFE FOR ENTERPRISE USE. THERE IS NO WARRANTY, INCLUDING THE WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. I AM NOT RESPONSIBLE FOR YOUR FAILURE TO UNDERSTAND WHAT YOU'RE INSTALLING AND THREAT MODEL APPROPRIATELY.**

With that out of the way, create a scheduled task:

```PowerShell
schtasks /create /tn outdated /tr "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File C:\Users\scott\Documents\chocolatey_outdated.ps1" /sc daily /ru "System"
```

You may want to go into "Task Scheduler" and check "run as soon as possible after a scheduled start is missed" in the task properties once it is created, in order to ensure that it is run _at most_ daily but _at least_ once a day that your computer is turned on.

# Sample

```
# HELP chocolatey_last_checked The last time we checked for outdated chocolatey packages, in epoch seconds.
# TYPE chocolatey_last_checked counter
chocolatey_last_checked 1.72018897e+09
# HELP chocolatey_outdated The number of outdated chocolatey packages
# TYPE chocolatey_outdated counter
chocolatey_outdated 0
```

Good luck!


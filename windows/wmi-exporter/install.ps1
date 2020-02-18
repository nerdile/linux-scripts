[CmdletBinding()]
Param(
    [string]$Collectors = "cpu,cs,logical_disk,net,os,service,system,textfile",
    [string]$AddCollectors = "",
    [uint16]$ListenPort = 9182,
    [string]$ListenAddress = "0.0.0.0",
    [string]$TextFileDir = "C:\metrics"
)

if (!(Test-Path .\wmi_exporter.msi)) { throw "wmi_exporter.msi not downloaded"; }

# Let users add to the defaults rather than just respecify everything
if ($AddCollectors -ne "") { $Collectors += ",$AddCollectors"; }

msiexec /qb /i $pwd\wmi_exporter.msi ENABLED_COLLECTORS="$Collectors" LISTEN_PORT=$ListenPort LISTEN_ADDR=$ListenAddress TEXTFILE_DIR="$TextFileDir"


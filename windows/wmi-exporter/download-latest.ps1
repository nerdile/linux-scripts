# Releases and collector info: https://github.com/martinlindhe/wmi_exporter

$get_release = (wget https://api.github.com/repos/martinlindhe/wmi_exporter/releases/latest)
if ($get_release.StatusCode -ne 200) { throw "Failed to download release info"; }

$release = ConvertFrom-Json $get_release.Content
$msi = $release.Assets | %{ $_.browser_download_url } | ?{ $_.EndsWith("amd64.msi") }
if (!$msi -or $msi.Count -ne 1) { throw "Failed to find latest amd64 msi"; }

wget $msi -OutFile wmi_exporter.msi
echo $get_release.Content >wmi_exporter.txt
echo $release.name >wmi_exporter.ver.txt
echo $msi >wmi_exporter.url.txt


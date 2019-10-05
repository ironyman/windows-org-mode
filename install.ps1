$configFile = "$env:USERPROFILE\AppData\Roaming\.emacs"
$escapedRoot = $PSScriptRoot -replace "\\", "\\"
$content = "(load `"$escapedRoot\\org.el`")"
Add-Content $configFile $content
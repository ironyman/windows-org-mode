$configFile = "$env:USERPROFILE\AppData\Roaming\.emacs"
$content = "(load `"$PSScriptRoot\\org.el`")"
Add-Content $configFile $content
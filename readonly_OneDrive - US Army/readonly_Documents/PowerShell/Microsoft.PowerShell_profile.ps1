$env:FZF_DEFAULT_OPTS="--height 60% --layout reverse --border --preview='bat --color=always {}' --walker-skip .git,node_modules"

Import-Module posh-git

Set-PSReadlineKeyHandler -Key Tab -Function Complete

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# save command output to $LastOut
$PSDefaultParameterValues['Out-Default:OutVariable'] = 'LastOut'

# source aliases
. "$home/OneDrive - US Army/Documents/PowerShell/aliases.ps1"

# set location to workspace root
set-location "$home/workspace"

Invoke-Expression (&starship init powershell)

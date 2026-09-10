$ErrorActionPreference = "Stop"

Import-Module ZLocation

# $zDirs = (Get-ZLocation).GetEnumerator() | Sort-Object -Property Value -Descending | Select-Object -ExpandProperty Key
# $fdDirs = fd --type d --hidden --exclude .git . "$env:USERPROFILE\workspace"
# $dir = @($zDirs) + @($fdDirs) | Select-Object -Unique | fzf --prompt="Workspace dir> "

# Sort by weight (most frecently used first) and pipe paths into fzf
$dir = (Get-ZLocation).GetEnumerator() |
       Sort-Object -Property Value -Descending |
       Select-Object -ExpandProperty Key |
       fzf --prompt="Workspace dir> "

if (-not $dir) {
    Write-Host "No directory selected — aborting."
    Start-Sleep -Seconds 2
    exit 0
}

git -C $dir rev-parse --is-inside-work-tree *> $null
$isGitRepo = ($LASTEXITCODE -eq 0)

$ws = herdr workspace create --cwd "$dir" --label (Split-Path $dir -Leaf) --focus | ConvertFrom-Json
$workspaceId = $ws.result.workspace.workspace_id
$nvimTab     = $ws.result.tab.tab_id
$nvimPane    = $ws.result.root_pane.pane_id
herdr tab rename $nvimTab "neovim"
herdr pane run $nvimPane "nvim"

$tabPi = herdr tab create --workspace $workspaceId --cwd "$dir" --label "pi" | ConvertFrom-Json
herdr pane run $tabPi.result.root_pane.pane_id "pi"

if ($isGitRepo) {
    $tabGit = herdr tab create --workspace $workspaceId --cwd "$dir" --label "git" | ConvertFrom-Json
    herdr pane run $tabGit.result.root_pane.pane_id "lazygit"
}

herdr tab create --workspace $workspaceId --cwd "$dir" --label "term" | Out-Null

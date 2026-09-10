$ErrorActionPreference = "Stop"

$dir = $PWD.Path

git -C $dir rev-parse --is-inside-work-tree *> $null
$isGitRepo = ($LASTEXITCODE -eq 0)

# Get current active/focused workspace
$wsList = herdr workspace list | ConvertFrom-Json
$activeWs = $null
if ($wsList.result.workspaces) {
    $activeWs = $wsList.result.workspaces | Where-Object { $_.focused -eq $true -or $_.is_focused -eq $true }
} elseif ($wsList.result) {
    $activeWs = $wsList.result | Where-Object { $_.focused -eq $true -or $_.is_focused -eq $true }
} else {
    $activeWs = $wsList | Where-Object { $_.focused -eq $true -or $_.is_focused -eq $true }
}

if (-not $activeWs) {
    Write-Host "No active workspace found."
    exit 1
}

$workspaceId = $activeWs.workspace_id

# Get tabs of the workspace
$tabsList = herdr tab list --workspace $workspaceId | ConvertFrom-Json
$tabs = $null
if ($tabsList.result.tabs) {
    $tabs = $tabsList.result.tabs
} elseif ($tabsList.result) {
    $tabs = $tabsList.result
} else {
    $tabs = $tabsList
}

if ($tabs -and $tabs.Count -gt 0) {
    $nvimTab = $tabs[0].tab_id
    herdr tab rename $nvimTab "neovim"
    
    # Get panes for this workspace and filter by our tab_id
    $panesList = herdr pane list --workspace $workspaceId | ConvertFrom-Json
    $allPanes = if ($panesList.result.panes) { $panesList.result.panes } elseif ($panesList.result) { $panesList.result } else { $panesList }
    $tabPanes = $allPanes | Where-Object { $_.tab_id -eq $nvimTab }
    
    if ($tabPanes -and $tabPanes.Count -gt 0) {
        $nvimPane = $tabPanes[0].pane_id
        herdr pane run $nvimPane "nvim"
    }
} else {
    $tabNeovim = herdr tab create --workspace $workspaceId --cwd "$dir" --label "neovim" | ConvertFrom-Json
    $nvimPane = $tabNeovim.result.root_pane.pane_id
    herdr pane run $nvimPane "nvim"
}

$tabPi = herdr tab create --workspace $workspaceId --cwd "$dir" --label "pi" | ConvertFrom-Json
herdr pane run $tabPi.result.root_pane.pane_id "pi"

if ($isGitRepo) {
    $tabGit = herdr tab create --workspace $workspaceId --cwd "$dir" --label "git" | ConvertFrom-Json
    herdr pane run $tabGit.result.root_pane.pane_id "lazygit"
}

herdr tab create --workspace $workspaceId --cwd "$dir" --label "term" | Out-Null

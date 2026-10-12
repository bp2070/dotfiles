$env:FZF_DEFAULT_OPTS="--height 60% --layout reverse --border --walker-skip .git,node_modules"
$env:BAT_PAGING="never"
$env:NVIM_APPNAME="nvim"

Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# set tab to open fzf with command history
Set-PSReadLineKeyHandler -Key "Shift+Tab" -ScriptBlock {
  # Initialize the variables so [ref] doesn't throw an error
  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  # Get the path of the PSReadLine history file
  $historyPath = [Microsoft.PowerShell.PSConsoleReadLine]::GetOptions().HistorySavePath

  if (Test-Path $historyPath) {
      # Use .NET file reading (orders of magnitude faster than Get-Content)
      $allLines = [System.IO.File]::ReadLines($historyPath)
      $history = [System.Linq.Enumerable]::TakeLast($allLines, 5000)

      # Cast to an array so we can reverse it (newest commands on top)
      $historyArray = [string[]]$history
      [array]::Reverse($historyArray)

      $env:_PSFZF_FZF_DEFAULT_OPTS = '--height 60% --layout reverse --border '

      # dedupe using awk to preserve order
      $selection = $historyArray | awk '!seen[$0]++' | Invoke-Fzf -Query $line -NoSort
  } else {
      $selection = $null
  }

  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()

  if ($null -ne $selection) {
    [Microsoft.PowerShell.PSConsoleReadLine]::DeleteLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($selection)
  }
}

# Create a queue of modules to load asynchronously, from: https://matt.kotsenas.com/posts/pwsh-profiling-async-startup/
[System.Collections.Queue]$__initQueue = @(
  {
    Import-Module posh-git -Global
  },
  {
    Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
  },
  {
    New-Module -Name psfzf -ScriptBlock { Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' } | Import-Module -Global
  }
)

# Register our idle callback; use `-SupportEvent` to hide the registration from the user
Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -SupportEvent -Action {
    if ($__initQueue.Count -gt 0) {
      & $__initQueue.Dequeue()
    } else {
      # NOTE: Use `-Force` when unregistering because we used `-SupportEvent` when registering
      Unregister-Event -SubscriptionId $EventSubscriber.SubscriptionId -Force

      # Remove our queue variable to avoid polluting the environment
      Remove-Variable -Name '__initQueue' -Scope Global -Force

      [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
    }
}

. "$home/OneDrive - US Army/Documents/PowerShell/aliases.ps1"
. "$home/OneDrive - US Army/Documents/PowerShell/prompt.ps1"
Import-Module "$home/workspace/fzf-worktree/worktree.psm1"
Import-Module "$home/workspace/worktree-sessionizer/sessionizer.psm1"

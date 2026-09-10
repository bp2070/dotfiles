[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

function prompt {

    # Remember where the provisional prompt starts, so its completed version
    # can be redrawn at exactly the same screen position.
    if (Test-Path variable:global:__initQueue) {
        $global:__loadingPromptTop = [Console]::CursorTop
    }

    # Colors
    $e = [char]27
    $cFrame = "$e[38;2;92;95;119m" # Muted Gray-Blue
    $cText = "$e[38;2;147;154;183m" # Soft White/Gray
    $fgBlue = "$e[38;2;137;180;250m" # Vibrant Blue
    $fgLightGrey = "$e[38;2;200;200;200m"
    $fgGrey = "$e[38;2;18;18;18m"
    $fgPeach = "$e[38;2;250;179;135m"
    $fgYellow = "$e[38;2;249;226;175m"
    $bgGrey = "$e[48;2;18;18;18m" # charcoal grey bg

    $bgReset = "$e[49m"
    $cReset = "$e[0m"

    # Frame Glyphs
    $topLeft  = "╭"
    $topRight = "╮"
    $botLeft  = "╰"
    $lineChar = "─"
    $chevron  = "⟩"
    $leftRoundCap = ""
    $rightRoundCap = ""

    $fullPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path

    if ($fullPath -eq $HOME) {
        $currentFolder = "~"
    } else {
        $currentFolder = Split-Path $fullPath -Leaf
        if ($currentFolder -eq "") { 
          $currentFolder = $fullPath 
        }
    }

    $gitBranch = ""
    if (Get-Command git -ErrorAction SilentlyContinue) {
        $gitBranch = git branch --show-current 2>$null
    }

    $gitSegment = ""
    if ($gitBranch) {
        # Check for Clean/Dirty status
        git diff --quiet 2>$null
        $dirtySymbol = if ($LASTEXITCODE -ne 0) { "$fgPeach*$cText" } else { "" }
        
        # Check Ahead/Behind status
        $upstream = git rev-parse --abbrev-ref '@{u}' 2>$null
        $syncSymbol = ""
        if ($LASTEXITCODE -eq 0) {
            $counts = git rev-list --left-right --count 'HEAD...@{u}' 2>$null
            if ($counts -match "(\d+)\s+(\d+)") {
                $ahead = [int]$Matches[1]
                $behind = [int]$Matches[2]
                if ($ahead -gt 0)  { $syncSymbol += "↑$ahead" }
                if ($behind -gt 0) { $syncSymbol += "↓$behind" }
            }
        }

        $gitSegment = "$cText$chevron$fgLightGrey  $cText$gitBranch"
        if($syncSymbol -and $dirtySymbol) { $gitSegment += " [$dirtySymbol $syncSymbol]" } 
        elseif ($syncSymbol) { $gitSegment += " [$syncSymbol]" } 
        elseif ($dirtySymbol) { $gitSegment += " [$dirtySymbol]" }
    }

    # Profile loading text
    $profileText = ""
    if(Test-Path variable:global:__initQueue) {
        $profileText = "$cFrame$lineChar$lineChar Loading Profile... "
    }

    # Assemble Right Side
    $timestamp = (Get-Date).ToString("HH:mm:ss")
    $rightSide = " $cText$timestamp $cFrame$lineChar$topRight$cReset"

    # --- DYNAMIC TRUNCATION CHECK ---
    $windowWidth = $Host.UI.RawUI.WindowSize.Width
    $ansiRegex = "\x1B\[[0-9;]*[a-zA-Z]"

    # Test layout length before committing strings
    $testLeft = "$cFrame$topLeft$lineChar$fgGrey$leftRoundCap$bgGrey$fgBlue   $cText$chevron$fgLightGrey   $cText$currentFolder$gitSegment $bgReset$fgGrey$rightRoundCap$profileText"
    $cleanLeft = [regex]::Replace($testLeft, $ansiRegex, "")
    $cleanRight = [regex]::Replace($rightSide, $ansiRegex, "")

    # If it overflows, truncate the git branch first, then the folder name if needed
    $safetyBuffer = 6
    $overflow = $cleanLeft.Length + $cleanRight.Length + $safetyBuffer - $windowWidth

    if ($overflow -gt 0) {
        if ($gitBranch.Length -gt ($overflow + 5)) {
            # Truncate Git Branch
            $gitBranch = $gitBranch.Substring(0, $gitBranch.Length - $overflow - 3) + "..."
        } else {
            # Git branch isn't long enough to clear the overflow entirely, truncate folder too
            if ($currentFolder.Length -gt 5) {
                $currentFolder = "..." + $currentFolder.Substring([Math]::Min($overflow, $currentFolder.Length - 4))
            }
            if ($gitBranch.Length -gt 4) {
                $gitBranch = $gitBranch.Substring(0, 4) + "..."
            }
        }
        
        # Rebuild the git segment with truncated branch
        if ($gitBranch) {
            $gitSegment = "$cText$chevron$fgLightGrey  $cText$gitBranch"
            if($syncSymbol -and $dirtySymbol) { $gitSegment += " [$dirtySymbol $syncSymbol]" } 
            elseif ($syncSymbol) { $gitSegment += " [$syncSymbol]" } 
            elseif ($dirtySymbol) { $gitSegment += " [$dirtySymbol]" }
        }
    }

    # Re-assemble final Left Side
    $leftSide = "$cFrame$topLeft$lineChar$fgGrey$leftRoundCap$bgGrey$fgBlue   $cText$fgLightGrey$gitSegment $chevron   $cText$currentFolder"
    $leftSide += " $bgReset$fgGrey$rightRoundCap$profileText"

    # Recalculate definitive Padding
    $cleanLeft = [regex]::Replace($leftSide, $ansiRegex, "")
    $paddingLength = $windowWidth - $cleanLeft.Length - $cleanRight.Length - 4

    $linePadding = ""
    if ($paddingLength -gt 0) {
        $linePadding = $cFrame + ($lineChar * $paddingLength)
    }

    # Restore the provisional prompt's exact top row after async startup.
    # InvokePrompt may have moved the cursor, so do this here immediately
    # before emitting the completed layout.
    if (Test-Path variable:global:__replaceLoadingPrompt) {
        [Console]::SetCursorPosition(0, $global:__loadingPromptTop)
        [Console]::Write("$e[0J")
        Remove-Variable -Name '__replaceLoadingPrompt' -Scope Global -Force
        Remove-Variable -Name '__loadingPromptTop' -Scope Global -Force
    }

    # The host/PSReadLine positions prompts on a fresh line. Avoid adding an
    # extra spacer line so an async refresh can redraw this layout in place.
    [Console]::Write("`n$leftSide$linePadding$rightSide`n")

    return "$cFrame$botLeft$lineChar$cReset "
}

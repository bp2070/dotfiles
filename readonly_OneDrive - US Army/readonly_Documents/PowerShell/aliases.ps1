function DockerCompose {
  docker compose $args
}

function l {
  eza --all --group-directories-first --hyperlink --icons $args
}

function ll {
  eza --all --group-directories-first --hyperlink --icons --long $args
}

function lt {
  eza --all --group-directories-first --hyperlink --icons --tree --level=3 --git-ignore $args
}

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

function vf {
  if($null -eq $args[0]) {
    nvim $(fzf)
  }
  else { 
    nvim $(fzf --walker-root=$(resolve-path $args))
  }
}

function f {
  if($null -eq $args[0]) {
    fzf
  } else {
    fzf --walker-root=$(resolve-path $args)
  }
}

function pr {
  pnpm run $args
}

function .. {
  cd ..
}

function ... {
  cd ../..
}

function .... {
  cd ../../..
}

Set-Alias p pnpm 
Set-Alias v nvim
Set-Alias dc DockerCompose
Set-Alias lzd lazydocker
Set-Alias gg lazygit
Set-Alias dk drizzle-kit
Set-Alias cz chezmoi

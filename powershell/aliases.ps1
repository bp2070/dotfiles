function dc {
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

function rmrf {
  pnpm dlx rimraf $args
}

Set-Alias p pnpm
Set-Alias v nvim
Set-Alias gg lazygit
Set-Alias dk drizzle-kit

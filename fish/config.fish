if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source

    # OS specific config
    switch(uname)
      case Linux
        alias l="ls -ap --group-directories-first"
        alias bat="batcat"

      case Darwin
        alias l="gls -ap --group-directories-first --color=auto"
      
    end

    alias ll="l -lh"
end

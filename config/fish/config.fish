if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source

    alias l="ls -ap --group-directories-first"
    alias ll="l -lh"
    alias bat="batcat"
end

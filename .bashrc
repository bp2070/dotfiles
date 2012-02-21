# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

#append history instead of rewriting it on session close
shopt -s histappen 

#increase history size
unset HISTFILESIZE
HISTSIZE=1000000

#ignore commands that start with a space or are duplicated
HISTCONTROL=ignoreboth

#ignore calls to ls, bg, fg and history itself
HISTIGNORE='l:bg:fg:history'

#record timestamps
HISTTIMEFORMAT='%F %T '

#one command per line
shopt -s cmdhist

#store history immediately
PROMPT_COMMAND='history -a; history -n'

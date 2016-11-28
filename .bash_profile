# .bash_profile

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

if [ -f $HOME/.bashrc ]; then
	source $HOME/.bashrc
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


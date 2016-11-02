# .bash_profile

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f $HOME/.bashrc ]; then
	source $HOME/.bashrc
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


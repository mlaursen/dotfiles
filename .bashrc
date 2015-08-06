# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias ls='ls -AFG --color'
alias rm='rm -rf'
alias vi='vim'
alias mkdir='mkdir -pv'
alias cp='cp -r'

# Allows <ctrl-s> for Command-T
stty -ixon
PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u @ \[\e[33m\]\w\[\e[0m\]/\n$ '

export ECLIPSE_HOME=/tools/eclipse

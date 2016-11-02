[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# User specific aliases and functions
alias ls='ls -AFG'
alias rm='rm -rf'
alias vi='nvim'
alias vim='nvim'
alias mkdir='mkdir -pv'
alias cp='cp -r'
alias mysql=/usr/local/mysql/bin/mysql
alias mysql.server=/usr/local/mysql/support-files/mysql.server

# Allows <ctrl-s> for Command-T
stty -ixon
PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u @ \[\e[33m\]\w\[\e[0m\]/\n$ '

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.yarn-config/global/node_modules/.bin"

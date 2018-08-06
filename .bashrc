[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# User specific aliases and functions
alias ls='ls -AFG'
alias rm='rm -rf'
alias vi='nvim'
# still want to be able to use vim easily if needed
# alias vim='nvim'
alias mkdir='mkdir -pv'
alias cp='cp -r'
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
alias diefortidie="sudo pkill -f FortiClient"

# Allows <ctrl-s> for Command-T
stty -ixon
PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u @ \[\e[33m\]\w\[\e[0m\]/\n$ '

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export PATH="/usr/local/sbin:$PATH:~/bin:`yarn global bin`"

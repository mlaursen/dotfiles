# User specific aliases and functions
# alias vi='nvim'
# alias vim='nvim'
# alias vif='nvim `fzf`'
alias vi='vim'
alias vim='mvim -v'
alias vif='vim `fzf`'

alias ls='ls -AFG'
alias cp='cp -r'
alias rm='rm -rf'
alias mkdir='mkdir -pv'

alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'

# Allows <ctrl-s> for Command-T
stty -ixon
PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u @ \[\e[33m\]\w\[\e[0m\]/\n$ '

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export PATH="/usr/local/sbin:$PATH:~/dotfiles/bin"

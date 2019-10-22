# User specific aliases and functions
alias vi='vim'
alias vif='vim `fzf`'
alias nif='nvim `fzf`'
alias vim='nvim'

alias ls='ls -AFG'
alias cp='cp -r'
alias rm='rm -rf'
alias mkdir='mkdir -pv'
alias reso='source ~/.bashrc'
alias rmd='cd ~/code/react-md'
alias fwi='cd ~/code/fwi'

if [ -x "$(command -v brew)" ]; then
  alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
  # alias vim='mvim -v'

  # Allows <ctrl-s> in mac
  stty -ixon
fi

if [[ -e "/usr/local/share/bash-completion/bash_completion" ]]; then
  # allow bash2 completions
  export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
  source "/usr/local/share/bash-completion/bash_completion"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export PATH="/usr/local/sbin:$PATH:~/dotfiles/bin"

PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u @ \[\e[33m\]\w\[\e[0m\]/\n$ '

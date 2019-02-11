# User specific aliases and functions
# alias vi='nvim'
# alias vim='nvim'
# alias vif='nvim `fzf`'
alias vi='vim'
alias vif='vim `fzf`'
alias nif='nvim `fzf`'

alias ls='ls -AFG'
alias cp='cp -r'
alias rm='rm -rf'
alias mkdir='mkdir -pv'

if [ -x "$(command -v brew)" ]; then
  alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
  alias vim='mvim -v'

  if [ -f `brew --prefix`/etc/bash_completion ]; then
      . `brew --prefix`/etc/bash_completion
  fi

  # Allows <ctrl-s> in mac
  stty -ixon
fi

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export PATH="/usr/local/sbin:$PATH:~/dotfiles/bin"


PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u @ \[\e[33m\]\w\[\e[0m\]/\n$ '

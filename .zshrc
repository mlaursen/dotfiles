# reference https://github.com/ohmyzsh/ohmyzsh/blob/master/templates/zshrc.zsh-template
export ZSH=$HOME/.oh-my-zsh

CASE_SENSITIVE="true"
ZSH_THEME="mlaursen"

plugins=(
  git-prompt
  fzf
  npm
  nvm
  yarn
)

source $ZSH/oh-my-zsh.sh

# I don't know why zsh has so many stupid aliases... remove them all and only have my own
unalias -m '*'

# don't paginate if it's less than one page
export LESS="-F -X $LESS"

# User configuration (comes after to override zsh defaults)
alias fgrep='fgrep --color=auto'
alias gerep='egrep --color=auto'
alias grep='grep --color=auto'
alias vi='vim'
alias vif='vim `fzf`'
alias nif='nvim `fzf`'

# I switch between these two a lot. just swap to `1 -eq 1` if I want nvim
if [[ 0 -eq 1 ]]; then
  alias vim='nvim'
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# I'm lazy
alias cp='cp -r'
alias rm='rm -rf'
alias mkdir='mkdir -pv'

alias reso='source ~/.zshrc'
alias rmd='cd ~/code/react-md'

if [ -x "$(command -v brew)" ]; then
  # cheating and considering this mac specific stuff only
  alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
  alias vim='mvim -v'
  alias ls='ls -AFG'

  # Allows <ctrl-s> in mac
  stty -ixon

  PATH="/usr/local/sbin:$PATH"

  # the .dir_colors don't work with mac even with the gls version from coreutils
  export LSCOLORS=exfxfeaeBxxehehbadacea
else
  alias ls='ls -AF --color=auto'
fi

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export PATH="$PATH:~/dotfiles/bin"

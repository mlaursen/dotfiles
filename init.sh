#!/bin/bash
set -e

[[ "$(uname -s)" = "Darwin" ]] && current_os="Mac" || current_os="Linux"

echo "Initializing dotfiles for a $current_os setup..."
echo ""

if [[ ! -d "$HOME/dotfiles" ]]; then
  echo "Cloning dotfiles to $HOME/dotfiles"
  git clone git@github.com:mlaursen/dotfiles.git "$HOME/dotfiles"
else
  echo "$HOME/dotfiles found... skipping clone."
fi

cd "$HOME/dotfiles"

dotfiles=( ".zshrc" ".gitconfig" ".vimrc" ".dir_colors" ".tmux.conf" ".editorconfig" )

echo ""
echo "Symlinking default dotfiles with backups..."
for file in "${dotfiles[@]}"; do
  if [ -h "$HOME/$file" ]; then
    echo "Skipping \"$HOME/$file\" since it is already a symlink..."
  else
    if [ -f "$HOME/$file" ]; then
      mv -v "$HOME/$file" "$HOME/$file.bak"
    fi

    ln -s "$HOME/dotfiles/$file" "$HOME/$file"
  fi
done


echo ""
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  ln -s "$HOME/dotfiles/mlaursen.zsh-theme" "$HOME/.oh-my-zsh/themes/mlaursen.zsh-theme"
fi

echo ""
if [[ ! -d "$HOME/.nvm" ]]; then
  echo "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

  source "$HOME/.zshrc"
else
  echo "nvm installation found. Skipping..."
fi

if [ ! -x "$(command -v node)" ]; then
  echo "Installing node..."
  nvm install stable
  nvm alias default stable
  nvm use default

  source "$HOME/.zshrc"
else
  echo "node found... skipping installation"
fi

if [ ! -x "$(command -v stack)"]; then
  echo ""
  echo "Installing haskell-stack"
  # sudo yum install stack -y
  curl -sSL https://get.haskellstack.org/ | sh
else
  echo "stack found... skipping installation"
fi

echo ""
echo "Adding $current_os specific functionality..."
if [[ "$current_os" = "Mac" ]]; then

  echo ""
  echo "Installing xcode additional tools..."
  xcode-select --install

  echo ""
  echo "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo ""
  echo "Adding solarized..."
  curl -O http://ethanschoonover.com/solarized/files/solarized.zip \
    && unzip solarized.zip \
    && open solarized/iterm2-colors-solarized/Solarized\ Dark.itermcolors \
    && rm -rf solarized solarized.zip

  echo ""
  echo "Adding quicker key repeat (reqires re-login)..."
  defaults write NSGlobalDomain KeyRepeat -int 1
  defaults write NSGlobalDomain InitialKeyRepeat -int 10

  echo ""
  echo "Installing dependencies..."
  brew bundle

  echo ""
  echo "Initializing gpg settings..."
  mkdir "~/.gnupg"
  chmod 700 "~/.gnupg"
  ln -s "~/dotfiles/gpg.conf" "~/.gnupg/gpg.conf"
  ln -s "~/dotfiles/gpg-agent.conf" "~/.gnupg/gpg-agent.conf"
else
  echo ""
  echo "Updating default editor to be vim ..."
  sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
  sudo update-alternatives --set editor /usr/local/bin/vim

  echo ""
  echo "Installing nodejs for yarn dependency"
  sudo yum install epel-release -y
  sudo yum install nodejs -y

  echo ""
  echo "Installing haskell-stack"
  sudo yum install stack -y

  echo ""
  echo "Installing yarn..."
  curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
  sudo yum install yarn -y
fi

echo ""
echo "Updating yarn to work without a specific node version"
yarn config set scripts-prepend-node-path true --global

echo ""
echo "Cloning zsh-git-prompt and initializing"

code_dir="$HOME/code"
mkdir -p $code_dir

git clone https://github.com/zsh-git-prompt/zsh-git-prompt "$code_dir/zsh-git-prompt"
cd "$code_dir/zsh-git-prompt"
# This might not work on Apple Silicon M1 Chips
# I got it to work by updating the `haskell/stack.yaml` file with:
# diff --git a/haskell/stack.yaml b/haskell/stack.yaml
# index 7c9ea71..b4b5a22 100644
# --- a/haskell/stack.yaml
# +++ b/haskell/stack.yaml
# @@ -1,14 +1,18 @@
#  # For more information, see: https://github.com/commercialhaskell/stack/blob/release/doc/yaml_configuration.md
# 
#  # Specifies the GHC version and set of packages available (e.g., lts-3.5, nightly-2015-09-21, ghc-7.10.2)
# -resolver: lts-5.0
# +resolver:
# +  compiler: ghc-8.10.7
# 
#  # Local packages, usually specified by relative directory name
#  packages:
#  - '.'
# 
#  # Packages to be pulled from upstream that are not in the resolver (e.g., acme-missiles-0.3)
# -extra-deps: []
# +extra-deps:
# +  - QuickCheck-2.14.2
# +  - random-1.2.1.1
# +  - splitmix-0.1.0.4
# 
#  # Override default flag values for local packages and extra-deps
#  flags: {}
stack setup
stack build && stack install

nvim_dir="$HOME/.config/nvim"

echo ""
echo "Initializing vim and neovim..."
mkdir -p "$nvim_dir"
ln -s "~/dotfiles/coc-settings.json ~/.vim/coc-settings.json"
ln -s "~/dotfiles/coc-settings.json $nvim_dir/coc-settings.json"
ln -s "~/dotfiles/nvim/lua $nvim_dir/lua"
ln -s "~/dotfiles/nvim/init.lua $nvim_dir/init.lua"

if [[ "$current_os" = "Mac" ]]; then
  pip3 install neovim
else
  pip3 install neovim --user
fi

echo ""
echo "Initial setup complete! run vim +PlugInstall and nvim +PlugInstall to install vim packages"
echo ""
echo "Update the default shell to be zsh: \`chsh -s /usr/zsh\` (requires logout)"
echo "If the command above fails, run \`chsh -l\` to find the zsh path"
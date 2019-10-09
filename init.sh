#!/bin/bash
set -e

echo "Initializing dotfiles..."
cd ~
git clone git@github.com:mlaursen/dotfiles.git
cd dotfiles
git pull origin macbook

dotfiles=( ".bashrc" ".bash_profile" ".gitconfig" ".vimrc" )

echo ""
echo "Initializing base dotfiles and symlinking..."
for file in "${dotfiles[@]}"; do
  if [ -f "$HOME/$file" ]; then
    mv -v "$HOME/$file" "$HOME/$file.bak"
  fi

  ln -s "$HOME/dotfiles/$file" "$HOME/$file"
done

source ~/.bash_profile


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
echo "Adding useful fzf bindings and fuzzy completion"
$(brew --prefix)/opt/fzf/install

echo "Updating to use latest version of bash..."
echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
chsh -s /usr/local/bin/bash
source ~/.bash_profile

echo ""
echo "Updatig yarn to work without a specific node version"
yarn config set scripts-prepend-node-path true --global

echo ""
echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
nvm install stable
nvm alias default stable

echo ""
echo "Initializing vim and neovim..."

mkdir -p "$HOME/.config/nvim"
echo "source ~/.vimrc" > "$HOME/.config/nvim/init.vim"

echo ""
echo "Adding minpac for vim and neovim..."
git clone https://github.com/k-takata/minpac.git \
    ~/.vim/pack/minpac/opt/minpac

git clone https://github.com/k-takata/minpac.git \
    ~/.config/nvim/pack/minpac/opt/minpac

pip3 install neovim

vim +PackUpdate

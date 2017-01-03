# dotfiles
A repo for my dotfiles on a MacBook.


### Getting Started

1. Install Xcode from the app store
2. Install [homebrew](http://brew.sh/)
  - `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
3. Install all programs and stuffs
  - `brew bundle install`
4. Set colors
  - Download [solarized](http://ethanschoonover.com/solarized/files/solarized.zip)
  - Extract zip and double click `iterm-2-colors-solarized/Solarized Dark.itermcolors`
5. Open iterm

### Initializing Neovim/vim

```bash
# Might already have been installed from `brew bundle`
$ /usr/local/opt/fzf/install --all

# Optional if using neovim instad
$ brew link macvim

$ mkdir ~/.config/nvim
$ ln -s ~/.vimrc ~/.config/nvim/init.vim

# Install vim-plug for package management
$ curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
$ vim +PlugInstall +qall
$ cd ~/.vim/plugged/YouCompleteMe && ./install.py --tern-completer
```

### Initializing Linters and SASS

```bash
$ brew install yarn
$ yarn global add eslint \
                  babel-eslint \
                  eslint-config-airbnb \
                  eslint-plugin-import@1.16.0 \
                  eslint-plugin-react \
                  eslint-plugin-import
$ gem install sass scss_lint
```

### Random Optimizations

```bash
# Faster arrow keys in terminals
$ defaults write NSGlobalDomain KeyRepeat -int 1
$ defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Show Path bar
$ defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
$ defaults write com.apple.finder ShowStatusBar -bool true
```

- Update Profile to `Reuse previous session's directory` under general tab for iterm2

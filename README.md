# dotfiles
A repo for my dotfiles on a MacBook.


### Getting Started

1. Install Xcode from the app store
2. Install [homebrew](http://brew.sh/)
  - `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
3. Install better terminal
  - `brew install Caskroom/cask/iterm2`
4. Set colors
  - Download [solarized](http://ethanschoonover.com/solarized/files/solarized.zip)
  - Extract zip and double click `iterm-2-colors-solarized/Solarized Dark.itermcolors`
5. Open iterm

### Installing Neovim

```bash
$ brew install CMake neovim fzf
$ /usr/local/opt/fzf/install --all

$ mkdir ~/.config/nvim
$ ln -s ~/.vimrc ~/.config/nvim/init.vim

# Install vim-plug for package management
$ curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
$ vim +PlugInstall
$ cd ~/.vim/plugged/YouCompleteMe && ./install.py --tern-completer
```

### Initilizing VIM (Instead of Neovim)

```bash
$ brew install CMake vim macvim
$ brew link macvim
$ mkdir ~/.vim/bundle && git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle

# Install plugins
$ touch package.json && vim +PluginInstall +qall && rm package.json
$ cd ~/.vim/bundle/YouCompleteMe && ./install.py --tern-completer
$ cd ~/.vim/bundle/command-t/ruby/command-t && ruby extconf.rb && make
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
```

- Update Profile to `Reuse previous session's directory` under general tab

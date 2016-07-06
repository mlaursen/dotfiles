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

### Initilizing VIM

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
$ gem install sass scss_lint
$ npm i -g eslint@2.x
           eslint-config-airbnb
           eslint-plugin-import
           eslint-plugin-jsx-a11y
           eslint-plugin-react

```

### Random Optimizations

```bash
# Faster arrow keys in terminals
$ defaults write NSGlobalDomain KeyRepeat -int 0
```

- Update Profile to `Reuse previous session's directory` under general tab

# dotfiles
A repo for my dotfiles on a MacBook.

## Installation
### Xcode
Install Xcode from the app store. Accept the terms and conditions for using it.

### [Homebrew](http://brew.sh/)

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
```

### Clone this repo into the root directory

```sh
mlaursen @ ~/
$ git init
$ git remote set-url origin git@github.com:mlaursen/dotfiles.git
$ git pull origin master
```

### Install programs and dependencies

```sh
mlaursen @ ~/
$ brew bundle
```

### Setting colorscheme to [solarized](http://ethanschoonover.com/solarized/files/solarized.zip)
Download the solarized colorscheme and update iterm2 to use it.

```sh
$mlaursen @ ~/
$ curl -O http://ethanschoonover.com/solarized/files/solarized.zip \
  && unzip solarized.zip \
  && open solarized/iterm2-colors-solarized/Solarized\ Dark.itermcolors \
  && rm -rf solarized solarized.zip
```

### Installing (neo)vim plugins

```bash
mlaursen @ ~/
# not sure if this is required anymore
$ pip3 install neovim

# install vim plugins, this will take awhile...
$ vim +PlugInstall +qall
```

### Initializing Linters and SASS

```sh
# optional
$ yarn global add eslint \
                  babel-eslint \
                  eslint-config-airbnb \
                  eslint-plugin-import@1.16.0 \
                  eslint-plugin-react \
                  eslint-plugin-import
$ gem install sass scss_lint
```

#### Create a PAC for vim-rhubarb
TO get some better GitHub vim support with [vim-fugitive](https://github.com/tpope/vim-fugitive) + [vim-rhubarb](https://github.com/tpope/vim-rhubarb),
you'll need to generate a personal access token (PAC) on [GitHub](https://github.com/settings/tokens/new) and then update the `~/.netrc` file:

```sh
echo 'machine api.github.com user mlaursen password <TOKEN>' >> ~/.netrc
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

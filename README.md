# dotfiles
A repo for my dotfiles on a MacBook.

## Getting Started
1. Install Xcode from the app store.
  - accept the terms and conditions for usin git
2. Install [homebrew](http://brew.sh/)
  - `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
3. Install all programs and stuffs
  - `brew bundle`
4. Set colors
  - Download [solarized](http://ethanschoonover.com/solarized/files/solarized.zip)
  - Extract zip and double click `iterm-2-colors-solarized/Solarized Dark.itermcolors`
5. Update iterm to load profiles from `~/iterm-profiles`
6. Open item and run:
  ```bash
  mlaursen @ ~/
  $ vim-packages init
  ```

### Initializing Linters and SASS

```bash
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

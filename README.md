# dotfiles

A repo for my dotfiles on a MacBook. This first time setup can be automated
with:

```sh
bash <(curl -s https://raw.githubusercontent.com/mlaursen/dotfiles/macbook/init.sh)
```

or if it has already been cloned:

```sh
./init.sh
```

## Random Optimizations

```bash
# Faster arrow keys in terminals
$ defaults write NSGlobalDomain KeyRepeat -int 1
$ defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Show Path bar
$ defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
$ defaults write com.apple.finder ShowStatusBar -bool true
```

## Create a PAC for vim-rhubarb

To get some better GitHub vim support with
[vim-fugitive](https://github.com/tpope/vim-fugitive) +
[vim-rhubarb](https://github.com/tpope/vim-rhubarb), you'll need to generate a
personal access token (PAC) on [GitHub](https://github.com/settings/tokens/new)
and then update the `~/.netrc` file:

```sh
echo 'machine api.github.com user mlaursen password <TOKEN>' >> ~/.netrc
```

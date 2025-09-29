# dotfiles

This repo contains my dotfiles.

```sh
bash <(curl -s https://raw.githubusercontent.com/mlaursen/dotfiles/master/init.sh)
```

## Manual Installation

### Download fonts and colorscheme

- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
  - [DejaVuSansMono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DejaVuSansMono.zip)
- [Nightfox colorscheme](https://github.com/EdenEast/nightfox.nvim)
  - [iterm](https://github.com/EdenEast/nightfox.nvim/blob/main/extra/nightfox/nightfox.itermcolors)
  - [Windows Terminal](https://github.com/EdenEast/nightfox.nvim/blob/main/extra/nightfox/windows_terminal.json)

### Setup Terminal

<details>
  <summary>Mac</summary>

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git
brew cask install iterm2
```

Open iterm2

```sh
open ~/Downloads/nightfox.itermcolors
rm ~/Downloads/nightfox.itermcolors
```

Update profile as needed to use font and colorscheme.

</details>

<details>
  <summary>Windows</summary>

- Install Terminal from the App Store
- Install Ubuntu from the App Store
- Start Terminal and create simple `mlaursen` user
- Open the settings (`<ctrl-,>`)
  - Open the `settings.json` file
    - Paste the contents of `windows_terminal.json` into the themes section
  - Update the `Ubuntu` appearance to use font and colorscheme
- Symlink `wslview` to `xdg-open` so that `gx` and `gX` work
  - `sudo ln -s $(which wslview) /usr/local/bin/xdg-open`

</details>

### Setup dotfiles

Create a git
[ssh key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux)
and add it to Github.

```sh
# Can use an empty  passphrase
ssh-keygen -t ed25519 -C "mlaursen03@gmail.com"

# Verify ssh agent exists
eval "$(ssh-agent -s)"

# add the keygen
ssh-add ~/.ssh/id_ed25519

# copy to clipboard
# MacOS
pbcopy < ~/.ssh/id_ed25519.pub

# WSL Ubuntu
sudo apt install xclip
xclip -selection clipboard -i < ~/.ssh/id_ed25519.pub
```

Add [new ssh key](https://github.com/settings/ssh/new).

Clone this repo and setup code directory:

```sh
git clone git@github.com:mlaursen/dotfiles.git ~/dotfiles
mkdir ~/code
```

Symlink dotfiles

```sh
mkdir ~/.config
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.dir_colors ~/.dir_colors
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.editorconfig ~/.editorconfig
ln -s ~/dotfiles/lazyvim/nvim ~/.config/nvim
```

Copy `.zshrc.local.template` to `.zshrc.local` and add any environment
variables:

```sh
cp ~/dotfiles/.zshrc.local.template ~/.zshrc.local
```

### Install packages

#### Mac

```sh
cd ~/dotfiles
brew bundle
```

#### Windows

Neovim will need to be installed from the
[latest stable release](https://github.com/neovim/neovim/releases/latest) for
Ubuntu/WSL.

```sh
curl -LO https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

# might need to install fuse
sudo add-apt-repository universe
sudo apt install libfuse2t64

# install other packages/dependencies (not sure of full list atm)
sudo apt install python3-pip ripgrep fd-find unzip
```

### Switch to zsh and setup [oh my zsh](https://ohmyz.sh/)

```sh
chsh -s /usr/zsh
```

> If the command above fails, run `chsh -l` to find the correct zsh path and run
> with that instead

Logout for the new shell to take effect. Then install oh-my-zsh:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.zshrc{,.bak}
mv ~/.zshrc{.pre-oh-my-zsh,}
```

Symlink my custom theme:

```sh
ln -s ~/dotfiles/mlaursen.zsh-theme ~/.oh-my-zsh/themes/mlaursen.zsh-theme
```

Install
[haskell stack](https://docs.haskellstack.org/en/stable/#how-to-install-stack):

```sh
curl -sSL https://get.haskellstack.org/ | sh
```

Setup [zsh-git-prompt](https://github.com/zsh-git-prompt/zsh-git-prompt):

```sh
git clone https://github.com/zsh-git-prompt/zsh-git-prompt ~/code/zsh-git-prompt
cd ~/code/zsh-git-prompt/haskell
stack setup
stack build && stack install
```

<details>
  <summary>If this fails on Apple Silicon M1 Chips</summary>

I got it to work by updating the `haskell/stack.yaml` file with:

```diff
diff --git a/haskell/stack.yaml b/haskell/stack.yaml
index 7c9ea71..b4b5a22 100644
--- a/haskell/stack.yaml
+++ b/haskell/stack.yaml
@@ -1,14 +1,18 @@
# For more information, see: https://github.com/commercialhaskell/stack/blob/release/doc/yaml_configuration.md

# Specifies the GHC version and set of packages available (e.g., lts-3.5, nightly-2015-09-21, ghc-7.10.2)
-resolver: lts-5.0
+resolver:
+  compiler: ghc-8.10.7

# Local packages, usually specified by relative directory name
packages:
- '.'

# Packages to be pulled from upstream that are not in the resolver (e.g., acme-missiles-0.3)
-extra-deps: []
+extra-deps:
+  - QuickCheck-2.14.2
+  - random-1.2.1.1
+  - splitmix-0.1.0.4

# Override default flag values for local packages and extra-deps
flags: {}
```

</details>

### Install node

Install [volta](volta.sh) to manage node and package managers

```sh
curl https://get.volta.sh | bash
source ~/.zshrc

volta install node
volta install pnpm
volta install yarn
```

### Setup neovim

```sh
ln -s ~/dotfiles/lazyvim/nvim ~/.config/nvim
# MacOS
pip3 install neovim

# If it failed
pip3 install neovim --user

# Ubuntu
sudo apt install python3-neovim

# if pip3 install hangs on WSL, comment out the export DISPLAY= and the next line in the .zshrc

# install rust (if not using homebrew)
curl https://sh.rustup.rs -sSf | sh

# install tree-sitter (WSL only.; Use homebrew for Mac)
cargo install tree-sitter-cli --locked

# Start nvim to start installing packages
nvim
```

### Setup GPG for signing commits

[Create a new GPG](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-new-gpg-key-to-your-github-account)

> Check out
> [Methods of Signing with GPG](https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e)
> and
> [Renew GPG Key](https://gist.github.com/krisleech/760213ed287ea9da85521c7c9aac1df0)
>
> ```sh
> gpg --list-secret-keys --keyid-format LONG
> gpg --edit-key KEY_ID
>
> # set a new expiration
> expire
> # optional - update trust
> trust
> save
> ```

<details>
  <summary>Mac</summary>

```sh
ln -s ~/dotfiles/install/mac/gpg.conf ~/.gnupg/gpg.conf
ln -s ~/dotfiles/install/mac/gpg-agent.conf ~/.gnupg/gpg-agent.conf
```

</details>

<details>
  <summary>Windows</summary>

- [Create a new GPG](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-new-gpg-key-to-your-github-account)
- Export the GPG key:
  `gpg --armor --export-secret-keys UUID_OF_GPG_KEY > private.cert`
- Copy the `private.cert` to Windows Download folder by navigating to
  `\\wsl$\Ubuntu\home\mlaursen`
- [Install Kleopatra](https://www.gpg4win.org/)
  - Uncheck everything except for the required one and Kleopatra
- Import the `private.cert` into Kleopatra and then certify the new
  `private.cert`
- Increase the passphrase duration
  - `Ctrl+Shift+,` -> `GnuPG System` -> `Private Keys` -> Update all caches to
    `28800`

```sh
# fo for the RSA one and 4096 bytes
gpg --full-generate-key

gpg --armor --export {UUID_OF_GPG_KEY} | xclip -sel clip
# Navigate to https://github.com/settings/gpg/new and paste

# not sure if the Kleopatra steps are required, but here's the private.cert
gpg --armor --export {UUID_OF_GPG_KEY} > private.cert

ln -s ~/dotfiles/install/windows/gpg-agent.conf ~/.gnupg/gpg-agent.conf
gpg-connect-agent reloadagent /bye
```

</details>

### (Windows): Add support for [Playwright/Cypress gui](https://wilcovanes.ch/articles/setting-up-the-cypress-gui-in-wsl2-ubuntu-for-windows-10/)

- Install [VcXsrv Windows X Server](https://sourceforge.net/projects/vcxsrv/)
- Update `.zshrc` to include:

  ```sh
  # set DISPLAY variable to the IP automatically assigned to WSL2
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

  # might need this as well to start dbus daemon
  # sudo /etc/init.d/dbus start &> /dev/null
  ```

- Start X Server (`xLaunch`)
  - use default options for display settings
  - disable access control in client startup settings
  - allow **both** private and public networks when the Windows security popup
    appears
  - save the config somewhere
  - pin the saved `xLaunch` config to the taskbar
- Whenever I want to use the gui
  - Right click the pin and click the config to start the server
  - Start up the terminal

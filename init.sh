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

dotfiles=(".zshrc" ".gitconfig" ".dir_colors" ".tmux.conf" ".editorconfig")

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

if [ ! -x "$(command -v stack)" ]; then
  echo ""
  echo "Installing haskell-stack"
  # sudo yum install stack -y
  curl -sSL https://get.haskellstack.org/ | sh
else
  echo "stack found... skipping installation"
fi

echo ""
if [[ -d "$VOLTA_HOME" ]]; then
  echo "Installing volta..."
  curl https://get.volta.sh | bash
  source ~/.zshrc
else
  echo "Volta installation found. Skipping..."
fi

echo ""
echo "Installing node..."
volta install node@18
volta install node@20

echo ""
echo "Installing pnpm"
volta install pnpm

echo ""
echo "Installing pnpm"
volta install pnpm

echo ""
echo "Installing yarn"
volta install yarn@1
volta install yarn

echo ""
echo "Adding $current_os specific functionality..."
if [[ "$current_os" = "Mac" ]]; then
  echo ""
  echo "Installing xcode additional tools..."
  xcode-select --install

  echo ""
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo ""
  echo "Adding quicker key repeat (reqires re-login)..."
  defaults write NSGlobalDomain KeyRepeat -int 1
  defaults write NSGlobalDomain InitialKeyRepeat -int 10

  echo ""
  echo "Installing dependencies..."
  cd ./install/mac
  brew bundle
  cd -

  echo ""
  echo "Initializing gpg settings..."
  mkdir "~/.gnupg"
  chmod 700 "~/.gnupg"
  ln -s "~/dotfiles/install/mac/gpg.conf" "~/.gnupg/gpg.conf"
  ln -s "~/dotfiles/install/mac/gpg-agent.conf" "~/.gnupg/gpg-agent.conf"
else
  echo ""
  echo "Initializing gpg settings..."
  mkdir "~/.gnupg"
  chmod 700 "~/.gnupg"
  ln -s "~/dotfiles/install/mac/gpg-agent.conf" "~/.gnupg/gpg-agent.conf"
fi

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

echo ""
echo "Initializing neovim..."
ln -s "$HOME/dotfiles/lazyvim/nvim" "~/.config/nvim"

if [[ "$current_os" = "Mac" ]]; then
  pip3 install neovim
else
  pip3 install neovim --user
fi

echo ""
echo "Initial setup complete!"
echo ""
echo "Update the default shell to be zsh: \`chsh -s /usr/zsh\` (requires logout)"
echo "If the command above fails, run \`chsh -l\` to find the zsh path"
echo ""
echo "Run 'nvim' to install remaining packages and get started"


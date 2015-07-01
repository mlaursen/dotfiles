# dotfiles
A repo for my dotfiles.

### .vimrc
This .vimrc is based off of https://amix.dk/vim/vimrc.html

I ended up changing the tabspaces from 4 to 2 and the new buffer to be `<leader>bn` instead of `<leader>q` since I have `<leader>q` as quick quit.

My .vimrc also has the plugins set up which use vundle. My plugins require vim with perl, python2.x, and ruby support.

To download the vim source code, install `hg` and run:

```bash
hg clone https://vim.googlecode.com/hg && cd vim && \
./configure --enable-rubyinterp --enable-perlinterp --enable-pythoninterp --enable-gui=no --enable-multibyte --prefix=/usr/share/vim/vim74

make && make install
```

Once vim has been fully installed, you can install vundle and install the plugins with:

```bash
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle && \
vim +PluginInstall +qall
```

Finally, you need to setup/install a few of the plugins.

CommandT:

```bash
d ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
```

YouCompleteMe

```bash
cd ~/.vim/bundle/YouCompleteMe
./install.sh
```

### .bashrc
This just has my usual aliases.

### .bash_profile


### .gitconfig


### Fedora VM
sudo dnf groupinstall "Development Tools"

> yum has been moved to `dnf` which requires some migrate thing I forgot to copy.

# dotfiles
A repo for my dotfiles.

### .vimrc
This .vimrc is based off of https://amix.dk/vim/vimrc.html

I ended up changing the tabspaces from 4 to 2 and the new buffer to be `<leader>bn` instead of `<leader>q` since I have `<leader>q` as quick quit.

My .vimrc also has the plugins set up which use vundle. My plugins require vim with perl, python2.x, and ruby support.

To download the vim source code, install `hg` and run:

```bash
hg clone https://vim.googlecode.com/hg vim
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-perlinterp \
            --enable-pythoninterp \
            --enable-gui=no \
            --enable-cscope \
            --prefix=/usr
make 
sudo make install
```

Once vim has been fully installed, you can install vundle and install the plugins with:

```bash
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle && \
vim +PluginInstall +qall
```

Finally, you need to setup/install a few of the plugins.

CommandT:

```bash
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
```

YouCompleteMe

```bash
cd ~/.vim/bundle/YouCompleteMe
./install.sh
```

tern_for_vim

```bash
cd ~/.vim/bundle/tern_for_vim
npm install
```

### .bashrc
This just has my usual aliases.

### .bash_profile
Specific login environment variables. Requires a re-login to work.


### .gitconfig


### .tern-project
An example .tern-project to add to a node javascript project to get code completion

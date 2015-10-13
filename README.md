# dotfiles
A repo for my dotfiles.

### .vimrc
This .vimrc is based off of https://amix.dk/vim/vimrc.html

I ended up changing the tabspaces from 4 to 2 and the new buffer to be `<leader>bn` instead of `<leader>q` since I have `<leader>q` as quick quit.

My .vimrc also has the plugins set up which use vundle. My plugins require vim with perl, python2.x, and ruby support.

```bash
$ git clone https://github.com/vim/vim.git
$ cd vim
$ ./configure --with-features=huge \
              --enable-multibyte \
              --enable-rubyinterp \
              --enable-perlinterp \
              --enable-pythoninterp \
              --enable-gui=no \
              --enable-cscope \
              --prefix=/usr
$ make 
$ sudo make install
```

Once vim has been fully installed, you can install vundle and install the plugins with:

```bash
$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle && \
$ vim +PluginInstall +qall
```

Finally, you need to setup/install a few of the plugins.

CommandT:

```bash
$ cd ~/.vim/bundle/command-t/ruby/command-t
$ ruby extconf.rb
$ make
```

YouCompleteMe

```bash
$ cd ~/.vim/bundle/YouCompleteMe
$ ./install.sh
```

tern_for_vim

```bash
$ cd ~/.vim/bundle/tern_for_vim
$ npm install
```

To get some of the other plugins to work install the following modules globally for npm

```bash
$ npm install -g eslint babel-eslint eslint-plugin-react tern babel-core gulp
```

### .bashrc
This just has my usual aliases.

### .bash_profile
Specific login environment variables. Requires a re-login to work.


### .gitconfig


### .tern-config
An global tern config file for neat tern stuff


### .eslintrc
An example eslint config

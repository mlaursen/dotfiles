# dotfiles
A repo for my dotfiles.

### Terminal

### Fonts
DejaVu Sans Mono is a pretty good font for the terminal. Installation is easy.

#### Colors
I like using `solarized`.

Windows: https://github.com/mavnn/mintty-colors-solarized

> Make sure that in the cygwin Terminal options, the Type is set to `xterm-256color`

Linux: https://github.com/Anthony25/gnome-terminal-colors-solarized

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

> Note: I currently have it set up to only include clojure plugins if the git base dir has a `project.clj` and
> the javascript plugins are only enabled if `package.json` exists in the git base dir. So you will need to run
> `vim +PluginInstall +qall` in both of those circumstances to install them. Or you can remove that check.

Finally, you need to setup/install a few of the plugins.

##### CommandT

```bash
$ cd ~/.vim/bundle/command-t/ruby/command-t
$ ruby extconf.rb
$ make
```

##### YouCompleteMe

```bash
$ cd ~/.vim/bundle/YouCompleteMe
$ ./install.sh
```

> If in cygwin, Remove the ferences of CYGWIN in _/YouCompleteMe/third_party/ycmd/cpp/BoostParts/boost/python/detail/wrap_python.hpp_
> ~Lines 85 and 86

##### tern_for_vim

To get some of the other plugins to work install the following modules globally for npm

```bash
$ npm install -g eslint babel-eslint eslint-plugin-react tern babel-core gulp
```

> This is optional if you want to install tern globally

```bash
$ cd ~/.vim/bundle/tern_for_vim
$ npm install
```

> Windows: To get tern to work in windows and cygwin, you need to update `let g:tern#command=` to be absolute
> path to your tern installation. So if you installed tern at `C:\code\.vim\bundle\tern_for_vim`, the line should be..
> 
> `let g:tern#command=['node', '/code/.vim/bundle/tern_for_vim/node_modules/tern/bin/tern', '--no-port-file']


##### scss_lint

```bash
$ gem install scss_lint
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

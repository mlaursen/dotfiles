if &compatible
  set nocompatible
endif

function! s:YouCompleteMe(hooktype, name)
  silent! !git submodule update --init --recursive && python3 ./install.py
endfunction

function! s:MarkdownComposer(hooktype, name)
  if has("nvim")
    silent! !cargo build --release
  else
    silent! !cargo build --release --no-default-features --features json-rpc
  endif
endfunction

set rtp+=/usr/local/opt/fzf

if exists('*minpac#init')
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " ==================================
  " Formatting/colors
  " ==================================
  call minpac#add('altercation/vim-colors-solarized')
  call minpac#add('editorconfig/editorconfig-vim')

  call minpac#add('leafgarland/typescript-vim')
  call minpac#add('cakebaker/scss-syntax.vim')
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('mxw/vim-jsx')

  " ==================================
  " Linters, validators, and autocomplete
  " ==================================
  call minpac#add('w0rp/ale')
  call minpac#add('prettier/vim-prettier', {'do': 'silent! !npm i'})

  call minpac#add('alvan/vim-closetag')
  call minpac#add('jiangmiao/auto-pairs') " auto close brackets and quotes

  call minpac#add('autozimu/LanguageClient-neovim', {
        \ 'do': 'silent! !bash install.sh',
        \ 'branch': 'next',
        \ })

  call minpac#add('Valloric/YouCompleteMe', {'do': function('s:YouCompleteMe')})
  call minpac#add('SirVer/ultisnips')
  call minpac#add('mlaursen/vim-react-snippets')

  " ==================================
  " File navigation
  " ==================================
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('scrooloose/nerdtree')

  call minpac#add('tpope/vim-fugitive')
  call minpac#add('albfan/nerdtree-git-plugin')

  " allows \bo to close all buffers except current focus
  call minpac#add('vim-scripts/BufOnly.vim')
  " really just so i can do \bd to close the current buffer
  call minpac#add('rbgrouleff/bclose.vim')

  " ==================================
  " Notes
  " ==================================
  call minpac#add('vimwiki/vimwiki')


  " ==================================
  " General helpers and status bars
  " ==================================
  call minpac#add('tmux-plugins/vim-tmux-focus-events') " makes autoread option work correctly for terminal vim
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-repeat') " mostly used so that vim-surround can be repeated
  call minpac#add('tpope/vim-commentary') " easy comments with `gc` or `gcc`
  call minpac#add('airblade/vim-rooter') " Auto lcd to git dir on BufEnter
  call minpac#add('matze/vim-move')

  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')
  call minpac#add('euclio/vim-markdown-composer', {'do': function('s:MarkdownComposer')})
endif

" Add simple helper commands to update and clean packages that'll load minpac on demand
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()

" ================================================================
" Plugin settings
" ================================================================

" Update linters so typescript isn't running both eslint and tslint which is super slow
let g:ale_linters = {
      \ 'scss': ['scsslint', 'sasslint'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['tslint', 'tsserver', 'typecheck'],
      \ }

let g:LanguageClient_serverCommands = {
      \ 'bash': ['bash-language-server', 'start'],
      \ 'css': ['css-languageserver', '--stdio'],
      \ 'scss': ['css-languageserver', '--stdio'],
      \ }
" let g:LanguageClient_serverCommands = {
"       \ 'bash': ['bash-language-server', 'start'],
"       \ 'css': ['css-languageserver', '--stdio'],
"       \ 'scss': ['css-languageserver', '--stdio'],
"       \ 'javascript': ['javascript-typescript-stdio'],
"       \ 'javascript.jsx': ['javascript-typescript-stdio'],
"       \ 'typescript': ['javascript-typescript-stdio'],
"       \ 'typescriptreact': ['javascript-typescript-stdio'],
"       \ }
" let g:LanguageClient_loggingLevel = 'ERROR' " or INFO, DEBUG, WARNING
let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
let g:LanguageClient_serverStderr = '/tmp/LanguageServer.log'
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 0 " want to use ale instead

" updates typescsript-vim to not attempt to indent since vim-jsx works much better
" let g:typescript_indent_disable = 1

" update key bindings for UltiSnips
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsListSnippets="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-s-right>"
let g:UltiSnipsJumpBackwardTrigger="<c-s-left>"
let g:UltiSnipsEditSplit="vertical"

" allow autocompletion for comments
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" only want completions with YCM to show in the menu even if there is only 1
set completeopt=menuone

" attempt to go to declaration or definition of item under cursor
nnoremap gd :YcmCompleter GoTo<cr>
" find all references and put into quicklist
nnoremap gr :YcmCompleter GoToReferences<cr>
" rename word under cursor
nnoremap <F2> :YcmCompleter RefactorRename <C-R><C-W>

" print the type only for typescript
autocmd FileType typescript nnoremap <buffer> <F1> :YcmCompleter GetType<cr>


" hide more stuff in NERDTree
let g:NERDTreeShowHidden=1

" Allow fzf search as \t
nmap <leader>t :FZF<cr>

" Update fzf.vim actions for bindings like command-t
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-t': 'tabedit',
      \ 'ctrl-v': 'vsplit',
      \ }
let g:fzf_layout = { 'down': '~40%' }

" update vim-move to use control instead of alt since mac is stupid
let g:move_key_modifier='C'

" allow jsx syntax in .js files
let g:jsx_ext_required=0

" Update closetag to also work on js/ts files
let g:closetag_filenames='*.html,*.js,*.jsx,*.ts,*.tsx'

" only start markdown previewer after :ComposerStart
let g:markdown_composer_autostart=0
let g:markdown_composer_external_renderer='pandoc -f gfm -t html'
autocmd FileType markdown nnoremap <buffer> <F12> :ComposerStart<cr>

" update airline to use solarized
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" go to previous and next matches when using <leader>g
nmap <F9> :cp<cr>
nmap <F10> :cn<cr>

" When linting, go to next and previous errors
nmap <leader>n :lnext<cr>
nmap <leader>p :lprev<cr>

" Use ag instead of ack
if executable('ag')
  let g:ackprg='ag --vimgrep'

  " Update fzf to ignore files that can't be opened by vim and to use the silver searcher
  let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore "*.(png|svg|jpe?g|pdf|ttf|woff2?|eot|otf|zip|tar|bz)" -g ""'
endif

" Use ag for grepping
nmap <leader>g :Ag<space>

" lazyily toggle nerdtree
nmap <leader>] :NERDTreeToggle<cr>

" For some reason it stopped setting tw correctly
au FileType gitcommit setlocal tw=72

au BufRead,BufNewFile .babelrc,.eslintrc set ft=json
au BufRead,BufNewFile *nginx.conf.* set ft=nginx

" open terminal with 10 lines always at bottom
command! -nargs=* T belowright split | resize 20 | terminal <args>
" open terminal always right
command! -nargs=* VT botright vsplit | terminal <args>
" allow esc to exit terminal mode
tnoremap <ESC> <C-\><C-n>

" ================================================================
" => General
" ================================================================
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\\"
let g:mapleader = "\\"

" Fast quitting
nmap <leader>q :lclose<cr>:q<cr>

autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" ================================================================
" => VIM user interface
" ================================================================

" Line Numbers
set nu

" Turn on the WiLd menu
set wildmenu

set cmdheight=2

" Always show the status bar and airline
set laststatus=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500



" ================================================================
" => Colors and Fonts
" ================================================================

" Enable syntax highlighting
syntax enable
set background=dark

if $TERM == "xterm-256color"
  set t_Co=256

  silent! colorscheme desert
  " let it fail quietly if it hasn't been installed yet
  silent! colorscheme solarized
else
  silent colorscheme desert
endif

" Update cursor after the changes to nvim
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0
set guicursor+=i-ci:block-Cursor/lCursor
set guicursor+=r-cr:hor20-Cursor/lCursor

" ================================================================
" => Files, backups and undo
" ================================================================

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


" ================================================================
" => Text, tab and indent related
" ================================================================

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set nowrap "Wrap lines



" ================================================================
" => Moving around, tabs, windows and buffers
" ================================================================

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

map <leader>b :Buffers<cr>
map <leader>bd :Bclose<cr>

" Close all buffers except current
map <leader>bo :BufOnly<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" ================================================================
" => Spell checking
" ================================================================

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=



" ================================================================
" => Helper functions
" ================================================================

function! FormatXml()
  execute("silent %!xmllint --format --recover - 2>/dev/null")
endfunction

function! FixJS()
  execute('silent !eslint --fix % 2>/dev/null')
  redraw!
endfunction

function! FormatJson()
  execute('silent %!python -m json.tool')
endfunction

command! XMLint exec ":silent %!xmllint --format --recover - 2>/dev/null"

command! FixJS call FixJS()
command! FormatJson call FormatJson()

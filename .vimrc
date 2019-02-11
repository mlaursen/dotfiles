if &compatible
  set nocompatible
endif

if has('macvim')
  set rtp+=/usr/local/opt/fzf
else
  set rtp+=~/.fzf
endif

function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " ==================================
  " Formatting/colors
  " ==================================
  call minpac#add('altercation/vim-colors-solarized')
  call minpac#add('editorconfig/editorconfig-vim')

  call minpac#add('leafgarland/typescript-vim')
  call minpac#add('hail2u/vim-css3-syntax') " updates vim's built-in css to support CSS3
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

  " call minpac#add('autozimu/LanguageClient-neovim', {
  "       \ 'do': function('s:LanguageClient'),
  "       \ 'branch': 'next',
  "       \ 'type': 'opt',
  "       \ })

  call minpac#add('Valloric/YouCompleteMe', {'do': function('s:YouCompleteMe')})
  call minpac#add('SirVer/ultisnips')
  call minpac#add('mlaursen/vim-react-snippets')
  call minpac#add('mlaursen/rmd-vim-snippets')

  " ==================================
  " File navigation
  " ==================================
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('scrooloose/nerdtree')

  call minpac#add('tpope/vim-fugitive')
  call minpac#add('Xuyuanp/nerdtree-git-plugin')

  " allows \bo to close all buffers except current focus
  call minpac#add('vim-scripts/BufOnly.vim')
  " really just so i can do \bd to close the current buffer
  call minpac#add('rbgrouleff/bclose.vim')

  " ==================================
  " Notes
  " ==================================
  call minpac#add('vimwiki/vimwiki', {'type': 'opt'})

  " ==================================
  " General helpers and status bars
  " ==================================
  " allow focus events for auto-reloading buffers as needed
  if has("nvim")
    " this one appears to work with nvim while vitality works with vim. vitality is not preferred since it
    " attempts to do cursor changes (yuck)
    call minpac#add('tmux-plugins/vim-tmux-focus-events')
  else
    call minpac#add('sjl/vitality.vim')
  endif
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-repeat') " mostly used so that vim-surround can be repeated
  call minpac#add('tpope/vim-commentary') " easy comments with `gc` or `gcc`
  call minpac#add('airblade/vim-rooter') " Auto lcd to git dir on BufEnter
  call minpac#add('matze/vim-move')

  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')
  call minpac#add('euclio/vim-markdown-composer', {
        \ 'do': function('s:MarkdownComposer'),
        \ 'type': 'opt',
        \ })
endfunction

" Add simple helper commands to update and clean packages that'll load minpac on demand
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackStatus source $MYVIMRC | call PackInit() | call minpac#status()

" ================================================================
" vim-airline
" ================================================================
" update airline to use solarized
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline#extensions#ale#enabled = 1

" Always show the status bar and airline
set laststatus=2
set cmdheight=2

" ================================================================
" ale
" ================================================================
" Update linters so typescript isn't running both eslint and tslint which is super slow
let g:ale_linters = {
      \ 'scss': ['scsslint', 'sasslint'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['tslint', 'tsserver', 'typecheck'],
      \ }

" When linting, go to next and previous errors
nmap <leader>n :lnext<cr>
nmap <leader>p :lprev<cr>

" ================================================================
" prettier
" ================================================================
" disable focusing quickfix window when there are errors
let g:prettier#quickfix_auto_focus = 0
let g:prettier#autoformat = 0

if expand("$USER") == "mlaursen"
  " I want to also enable it for markdown and scss on home laptop
  autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.md,*.scss Prettier
else
  autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx Prettier
endif

" ================================================================
" LanguageClient
" ================================================================
" set the correct language servers
let g:LanguageClient_serverCommands = {
      \ 'sh': ['bash-language-server', 'start'],
      \ 'css': ['css-languageserver', '--stdio'],
      \ 'scss': ['css-languageserver', '--stdio'],
      \ }
let g:LanguageClient_diagnosticsEnable = 0 " want to use ale instead

" css and scss will use the languageclient for autocompletions, so update the buffers to have some nice wrappers

" opens a picker for valid commands with the languageclient
autocmd FileType css,scss nnoremap <F5> :call LanguageClient_contextMenu()<CR>
autocmd FileType css,scss nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
autocmd FileType css,scss nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
autocmd FileType css,scss nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" ================================================================
" YouCompleteMe
" ================================================================
" only want completions with YCM to show in the menu even if there is only 1
set completeopt=menuone,longest
" A buffer becomes hidden when it is abandoned (used for refactors)
set hidden


" allow LanguageClient results in YouCompleteMe from css and scss files
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^', 're!^\s+', ': ' ],
    \   'scss': [ 're!^', 're!^\s+', ': ' ],
    \ }

" attempt to go to declaration or definition of item under cursor
autocmd FileType typescript,javascript,javascript.jsx nnoremap <buffer> gd :YcmCompleter GoTo<cr>

" find all references and put into quicklist
autocmd FileType typescript,javascript,javascript.jsx nnoremap <buffer> gr :YcmCompleter GoToReferences<cr>

" show current type
autocmd FileType typescript,javascript,javascript.jsx nnoremap <buffer> K :YcmCompleter GetType<cr>

" get the full error message for type errors. useful for complex types
autocmd FileType typescript nnoremap <buffer> fK :YcmShowDetailedDiagnostic<cr>

" attempt to fix an import or error in typescript
autocmd FileType typescript nnoremap <buffer> fi :YcmCompleter FixIt<cr>

" rename word under cursor and copy current word into renamer
autocmd FileType typescript,javascript,javascript.jsx nnoremap <buffer> <F2> :YcmCompleter RefactorRename <C-R><C-W>

autocmd FileType typescript,javascript,javascript.jsx nnoremap <buffer> <leader>I :YcmCompleter OrganizeImports<cr>

" ================================================================
" UltiSnips
" ================================================================
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsListSnippets="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-s-right>"
let g:UltiSnipsJumpBackwardTrigger="<c-s-left>"
let g:UltiSnipsEditSplit="vertical"

" ================================================================
" NERDTree
" ================================================================
" hide more stuff in NERDTree
let g:NERDTreeShowHidden=1

" lazyily toggle nerdtree
nmap <leader>] :NERDTreeToggle<cr>
nmap <leader>F :NERDTreeFind<cr>

" ================================================================
" FZF
" ================================================================
" Allow fzf search as \t
nmap <leader>t :FZF<cr>

" Update fzf.vim actions for bindings like command-t
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-t': 'tabedit',
      \ 'ctrl-v': 'vsplit',
      \ }
let g:fzf_layout = { 'down': '~40%' }

" ================================================================
" vim-move
" ================================================================
" update vim-move to use control instead of alt since mac is stupid
let g:move_key_modifier='C'

" ================================================================
" vitality (for focus events)
" ================================================================
let g:vitality_fix_cursor=0

" ================================================================
" vim-jsx
" ================================================================
" allow jsx syntax in .js files
let g:jsx_ext_required=0

" ================================================================
" vim-closetag
" ================================================================
" Update closetag to also work on js and html files, don't want ts since <> is used for type args
let g:closetag_filenames='*.html,*.js,*.jsx'

" ================================================================
" vim-markdown-composer
" ================================================================
" only start markdown previewer after :ComposerStart
let g:markdown_composer_autostart=0
let g:markdown_composer_external_renderer='pandoc -f gfm -t html'

function! MarkdownPreview()
  if !exists('*ComposerStart')
    " if vim-markdown-composer hasn't been added yet, add it and reload
    " the file before calling ComposerStart. Not sure why reloading the
    " file is required, but breaks if it isn't
    packadd vim-markdown-composer
    edit %
  endif

  ComposerStart
endfunction

command! MarkdownPreview call MarkdownPreview()
autocmd FileType markdown nnoremap <buffer> <F12> :MarkdownPreview<cr>

" ================================================================
" VimWIKI
" ================================================================
" I can never remember the way to open it, and I don't like using the <Leader>ww since
" I have <Leader>w set to quick write
command! Wiki packadd vimwiki | VimwikiIndex

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

let mapleader = "\\"
let g:mapleader = "\\"

nnoremap <leader>q :lclose<cr>:cclose<cr>:q<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>x :lclose<cr>:cclose<cr>:x<cr>:q<cr>

" change directory to folder of current file
nnoremap <leader>cd :cd %:p:h<cr>

" turn backup off since it's handled by git
set nobackup
set nowb
set noswapfile

" Make it so that if files are changed externally (ex: changing git branches) update the vim buffers automatically
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Make it so any .env files are correctly styled. Normally only worked with .env
autocmd BufNewFile,BufRead * if expand('%t') =~ '.env' | set filetype=sh | endif

if has("nvim")
  " open terminal with 20 lines always at bottom
  command! -nargs=* T belowright split | resize 20 | terminal <args>
  " open terminal always right
  command! -nargs=* VT botright vsplit | terminal <args>
  " allow esc to exit terminal mode
  tnoremap <ESC> <C-\><C-n>
endif

" For some reason it stopped setting tw correctly
au FileType gitcommit setlocal tw=72

au BufRead,BufNewFile .babelrc,.eslintrc set ft=json
au BufRead,BufNewFile *nginx.conf.* set ft=nginx

" Use ag instead of ack
if executable('ag')
  let g:ackprg='ag --vimgrep'

  " Use ag for grepping
  nmap <leader>g :Ag<space>

  " go to previous and next matches when using <leader>g
  nmap <F9> :cp<cr>
  nmap <F10> :cn<cr>
endif

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

" A buffer becomes hidden when it is abandoned (used for refactors)
set hidden

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

" I don't like line-wrapping
set nowrap
set lbr
set tw=500

" update tab behavior
set smartindent
set autoindent
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

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
  silent! colorscheme desert
  " let it fail quietly if it hasn't been installed yet
  silent! colorscheme solarized
endif

if has("nvim")
  " Update cursor after the changes to nvim
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0
  set guicursor+=i-ci:block-Cursor/lCursor
  set guicursor+=r-cr:hor20-Cursor/lCursor
else
  set guicursor=
endif

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
" => Utility functions/commands
" ================================================================

function! s:YouCompleteMe(hooktype, name)
  silent! !git submodule update --init --recursive && python3 ./install.py --ts-completer
endfunction

function! s:MarkdownComposer(hooktype, name)
  if has("nvim")
    silent! !cargo build --release
  else
    silent! !cargo build --release --no-default-features --features json-rpc
  endif
endfunction

function! s:LanguageClient(hooktype, name)
  silent! !bash install.sh
  call s:CheckLanguageClientServers()
endfunction

function! s:CheckLanguageClientServers()
  " https://langserver.org/
  let l:missing_packages = []
  let l:expected_executables = {
        \ 'bash-language-server': 'bash-language-server',
        \ 'javascript-typescript-stdio': 'javascript-typescript-langserver',
        \ 'css-languageserver': 'vscode-css-languageserver-bin',
        \ }

  for [name, install] in items(l:expected_executables)
    if !executable(name)
      call add(l:missing_packages, install)
    endif
  endfor

  if len(l:missing_packages)
    let l:command = "!npm install --global " . join(l:missing_packages, ' ')
    silent! execute l:command
  endif
endfunction

command! FormatJson exec ":silent %!python -m json.tool"

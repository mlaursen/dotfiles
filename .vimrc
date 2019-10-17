if &compatible
  set nocompatible
endif

if !empty(glob('/usr/local/opt/fzf'))
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

  call minpac#add('hail2u/vim-css3-syntax') " updates vim's built-in css to support CSS3
  call minpac#add('cakebaker/scss-syntax.vim')
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('HerringtonDarkholme/yats.vim', {'do': 'silent! !rm -rf UltiSnips'}) " don't want these snippets...
  call minpac#add('maxmellon/vim-jsx-pretty')

  " ==================================
  " Linters, validators, and autocomplete
  " ==================================
  call minpac#add('dense-analysis/ale')
  call minpac#add('prettier/vim-prettier', {'do': 'silent! !yarn install'})

  call minpac#add('alvan/vim-closetag')
  call minpac#add('jiangmiao/auto-pairs') " auto close brackets and quotes

  " if has('nvim')
  "   call minpac#add('Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'})
  " else
  "   call minpac#add('Shougo/deoplete.nvim')
  "   call minpac#add('roxma/nvim-yarp')
  "   call minpac#add('roxma/vim-hug-neovim-rpc')
  " endif
  call minpac#add('Valloric/YouCompleteMe', {'do': function('s:YouCompleteMe')})
  call minpac#add('SirVer/ultisnips')
  call minpac#add('mlaursen/vim-react-snippets')
  call minpac#add('mlaursen/rmd-vim-snippets')

  " ==================================
  " File navigation
  " ==================================
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('scrooloose/nerdtree', {'type': 'opt'})

  call minpac#add('tpope/vim-fugitive')
  call minpac#add('Xuyuanp/nerdtree-git-plugin', {'type': 'opt'})

  " allows \bo to close all buffers except current focus
  call minpac#add('vim-scripts/BufOnly.vim')

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
  call minpac#add('airblade/vim-rooter', {'type': 'opt'}) " Auto lcd to git dir on BufEnter
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
      \ 'scss': ['sasslint'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint', 'tsserver', 'typecheck'],
      \ }

let g:ale_fixers = {
      \ 'scss': ['prettier'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint'],
      \ }

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" let g:ale_fix_on_save = 1
" let g:ale_completion_enabled = 1
" let g:ale_completion_tsserver_autoimport = 1
" let g:deoplete#enable_at_startup = 1
" set omnifunc=ale#completion#OmniFunc
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" autocmd VimEnter * call deoplete#custom#option('sources', { '_': ['ale', 'foobar'] })

" nmap gd :ALEGoToDefinition<cr>
" nmap gD :ALEGoToDefinitionInTab<cr>
" nmap gr :ALEFindReferences<cr>
" nmap K :ALEHover<cr>
" nmap fK :ALEDetail<cr>

" nmap fr :ALERename<cr>
nmap fe :ALEFix eslint<cr>
nmap ff :ALEFix prettier<cr>

" updates the auto-completion menu to work with tab and shift tab only if visible
" inoremap <silent><expr> <Tab>
"       \ pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <silent><expr> <S-Tab> 
"       \ pumvisible() ? "\<C-p>" : "\<S-TAB>"

" When linting, go to next and previous errors
nmap <leader>n :lnext<cr>
nmap <leader>p :lprev<cr>

" ================================================================
" prettier
" ================================================================
" disable focusing quickfix window when there are errors
let g:prettier#quickfix_auto_focus = 0
let g:prettier#autoformat = 0

autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.md,*.scss Prettier

" ================================================================
" YouCompleteMe
" ================================================================
" only want completions with YCM to show in the menu even if there is only 1
set completeopt=menuone,longest

" attempt to go to declaration or definition of item under cursor
nmap gd :YcmCompleter GoTo<cr>

" find all references and put into quicklist
nmap gr :YcmCompleter GoToReferences<cr>

" show current type
nmap K :YcmCompleter GetType<cr>

" get the full error message for type errors. useful for complex types
nmap fK :YcmShowDetailedDiagnostic<cr>

" attempt to fix an import or error in typescript
nmap fi :YcmCompleter FixIt<cr>

" rename word under cursor and copy current word into renamer
nmap fr :YcmCompleter RefactorRename <C-R><C-W>

nmap fI :YcmCompleter OrganizeImports<cr>

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
nmap <leader>] :call CustomNERDTreeCommand('NERDTreeToggle')<cr>
nmap <leader>F :call CustomNERDTreeCommand('NERDTreeFind')<cr>

function! CustomNERDTreeCommand(command)
  if !exists('NERDTreeToggle')
    packadd nerdtree
    packadd nerdtree-git-plugin
  endif

  execute a:command
endfunction

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
let g:move_key_modifier = 'C'
let g:move_map_keys = 0
let g:move_auto_indent = 0

vmap <C-j> <Plug>MoveBlockDown
vmap <C-k> <Plug>MoveBlockUp

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
let g:closetag_filenames='*.html,*.js,*.jsx,*.tsx'
let g:closetag_regions = {
    \ 'typescript.tsx': 'tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

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
let g:vimwiki_list = [{
      \ 'path': '~/vimwiki/',
      \ 'syntax': 'markdown',
      \ 'ext': '.md'
      \ }]

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

" linux doesn't do this by default, so enable it just to be safe
hi SpellBad cterm=underline

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

" function! s:LanguageClient(hooktype, name)
"   silent! !bash install.sh
"   call s:CheckLanguageClientServers()
" endfunction

" function! s:CheckLanguageClientServers()
"   " https://langserver.org/
"   let l:missing_packages = []
"   let l:expected_executables = {
"         \ 'bash-language-server': 'bash-language-server',
"         \ 'javascript-typescript-stdio': 'javascript-typescript-langserver',
"         \ 'css-languageserver': 'vscode-css-languageserver-bin',
"         \ }

"   for [name, install] in items(l:expected_executables)
"     if !executable(name)
"       call add(l:missing_packages, install)
"     endif
"   endfor

"   if len(l:missing_packages)
"     let l:command = "!npm install --global " . join(l:missing_packages, ' ')
"     silent! execute l:command
"   endif
" endfunction

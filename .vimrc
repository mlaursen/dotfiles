""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Allow fzf in runtime path
set rtp+=~/.fzf

" Opens up the autocomplete help in the YouCompleteMe menu instead of a preview buffer
set completeopt=menuone

" update vim-move to use control instead of alt since mac is stupid
let g:move_key_modifier='C'

" update key bindings for UltiSnips
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsListSnippets="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-s-right>"
let g:UltiSnipsJumpBackwardTrigger="<c-s-left>"
let g:UltiSnipsEditSplit="vertical"

" hide more stuff in NERDTree
let g:NERDTreeShowHidden=1

" allow jsx syntax in .js files
let g:jsx_ext_required=0

" The Eclim completion will now work with YCM
let g:EclimCompletionMethod='omnifunc'

let g:tsuquyomi_disable_quickfix=1

let g:closetag_html_style=1
let g:closetag_filenames='*.html,*.xhtml,*.jsx,*.js,*.jsp,*.jsf,*.jspf'

let g:javascript_enable_domhtmlcss=1

let g:notes_directories = ['~/Documents/Notes']

let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" Update fzf.vim actions for bindings like command-t
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-t': 'tabedit',
      \ 'ctrl-v': 'vsplit',
      \ }


let g:fzf_layout = { 'down': '~40%' }

"Update fzf to ignore files that can't be opened by vim
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore "*.(png|svg|jpe?g|pdf|ttf|woff2?|eot|otf|zip|tar|bz)" -g ""'

"When linting, go to next and previous errors
nmap <leader>n :lnext<cr>
nmap <leader>p :lprev<cr>
nmap <F9> :cp<cr>
nmap <F10> :cn<cr>

"Use ag instead of ack
if executable('ag')
  let g:ackprg='ag --vimgrep'
endif

"Use ag for grepping
nmap <leader>g :Ag<space>

"Use tern stuff for javascript files
au Filetype javascript nmap <F1> :YcmCompleter GetType<CR>
au Filetype javascript nmap <F2> :YcmCompleter GetDoc<CR>
au Filetype javascript nmap <F3> :YcmCompleter GoTo<CR>
au Filetype javascript nmap <F4> :YcmCompleter RefactorRename<space>

"Java eclim stuff
au Filetype java nmap <F3> :JavaSearchContext<CR>
au Filetype java nmap <c-s-i> :JavaImport<cr>
au Filetype java nmap <c-s-o> :JavaImportOrganize<cr>
au Filetype java nmap <c-1> :JavaCorrect<cr>


nmap <leader>] :NERDTreeToggle<cr>


" Allow fzf search as \t
nmap <leader>t :FZF<cr>

" Linting and fixing
nmap <leader>f :FixJS<cr>

au BufRead,BufNewFile .babelrc,.eslintrc set ft=json
au BufRead,BufNewFile *nginx.conf.* set ft=nginx
" For some reason it stopped setting tw correctly
au FileType gitcommit setlocal tw=72

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :lclose<cr>:q<cr>
nmap <leader>wq :x<cr>
nmap <leader>Q :qall!<cr>

" Line Numbers
set nu


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable


set background=dark

if $TERM == "xterm-256color"
  set t_Co=256
  colorscheme solarized
else
  colorscheme desert
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Update cursor after the changes to nvim
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0
set guicursor+=i-ci:block-Cursor/lCursor
set guicursor+=r-cr:hor20-Cursor/lCursor


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

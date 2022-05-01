let s:plugged_autoload_prefix='~/.vim'
let s:plugged_install_dir='~/.vim/plugged'
if has('nvim')
  let s:plugged_autoload_prefix='~/.local/share/nvim/site'
  let s:plugged_install_dir='~/.local/share/nvim/plugged'
endif

let s:plugged_autoload_path=s:plugged_autoload_prefix . '/autoload/plug.vim'

if empty(glob(s:plugged_autoload_path))
  let s:command='!curl -fLo ' . s:plugged_autoload_path . ' --create-dirs '
  let s:command.='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  silent exec s:command

  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ================================================================
" => Initializing Plugins
" ================================================================
call plug#begin(s:plugged_install_dir)

" ==================================
" Formatting/colors
" ==================================
Plug 'lifepillar/vim-solarized8' " this one supports truecolors
" Plug 'altercation/vim-colors-solarized'
Plug 'editorconfig/editorconfig-vim'

Plug 'hail2u/vim-css3-syntax' " updates vim's built-in css to support CSS3
Plug 'cakebaker/scss-syntax.vim'
Plug 'pangloss/vim-javascript'

" I don't want the snippets provided by this package as I like my own vim-react-snippets
Plug 'HerringtonDarkholme/yats.vim', {'do': 'rm -rf UltiSnips'}
Plug 'maxmellon/vim-jsx-pretty'

" ==================================
" Linters, validators, and autocomplete
" ==================================
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'

Plug 'mlaursen/vim-react-snippets'
Plug 'mlaursen/rmd-vim-snippets'

" ==================================
" File navigation
" ==================================
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

" makes fzf work related to git root of buffer which is nice
Plug 'airblade/vim-rooter'
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': ['NERDTreeToggle', 'NERDTreeFind']}

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'

" allows \bo to close all buffers except current focus
Plug 'vim-scripts/BufOnly.vim'

" ==================================
" Notes
" ==================================
Plug 'vimwiki/vimwiki', {'on': ['VimwikiDiaryIndex', 'VimwikiMakeDiaryNote']}

" ==================================
" General helpers and status bars
" ==================================
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " mostly used so that vim-surround can be repeated
Plug 'tpope/vim-commentary' " easy comments with `gc` or `gcc`
Plug 'matze/vim-move'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" ================================================================
" vim-airline
" ================================================================
" update airline to use solarized
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" Always show the status bar and airline
set cmdheight=2

" ================================================================
" vim-javascript
" ================================================================

let g:javascript_plugin_jsdoc=1

" ================================================================
" coc.vim
" ================================================================

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" always show the sign column so the code doesn't shift whenever the error
" state goggles with coc.nvim. this isn't needed if line numbers are enabled
set signcolumn=yes

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

let g:coc_global_extensions=[
      \ 'coc-css',
      \ 'coc-pairs',
      \ 'coc-stylelintplus',
      \ 'coc-cssmodules',
      \ 'coc-docker',
      \ 'coc-eslint8',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-prettier',
      \ 'coc-tsserver',
      \ 'coc-yaml',
      \ 'coc-vimlsp',
      \ 'coc-webview',
      \ 'coc-markdown-preview-enhanced',
      \ 'coc-git',
      \ 'coc-spell-checker'
      \ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" quickly jump between diagnostics
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" goto definition
nmap <silent> gd <Plug>(coc-definition)
" goto type
nmap <silent> gK <Plug>(coc-type-definition)
" get references
nmap <silent> gr <Plug>(coc-references)

" format rename
nmap <silent> fr <Plug>(coc-rename)

" format file
nmap <silent> ff <Plug>(coc-format)


function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" fix-it -- show preview window of fixable things and choose fix
nmap <silent>fi <Plug>(coc-codeaction)
" fix current --  requires a region:
" - fcw - fix-current-word
" - fcl - fix-current-letter
" - fcap - fix-current-paragraph
nmap <silent>fc <Plug>(coc-codeaction-selected)
" fix current selection
vmap <silent>fc <Plug>(coc-codeaction-selected)

" fix eslint (also any other fixable things. Mostly used for React hook dependencies)
nmap <silent>fe <Plug>(coc-fix-current)

" fix eslint (all)
nmap <silent>fE :<C-u>CocCommand eslint.executeAutofix<cr>

" fix imports
nmap <silent>fI :<C-u>CocCommand tsserver.organizeImports<cr>

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)

" Run the Code Lens action on the current line.
nmap gl <Plug>(coc-codelens-action)

"  ================================================================
" UltiSnips
" ================================================================
let g:UltiSnipsExpandTrigger='<c-space>'

" ================================================================
" NERDTree
" ================================================================
" hide more stuff in NERDTree
let g:NERDTreeShowHidden=1

" lazily toggle nerdtree
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

" this allows the escape key to close the fzf window matching coc.nvim
if has("nvim")
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
endif

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
" vim-jsx
" ================================================================
" allow jsx syntax in .js files
let g:jsx_ext_required=0

" ================================================================
" VimWIKI
" ================================================================
let g:vimwiki_list = [{
      \ 'path': '~/vimwiki/',
      \ 'syntax': 'markdown',
      \ 'ext': '.md'
      \ }]

" ================================================================
" vim-rooter
" ================================================================
let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile']


" ================================================================
" => General
" ================================================================
let mapleader = "\\"
let g:mapleader = "\\"

" Make it so that if files are changed externally (ex: changing git branches) update the vim buffers automatically
if !has("nvim")
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if !bufexists("[Command Line]") | checktime | endif
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
endif

" Make it so any .env files are correctly styled. Normally only worked with .env
autocmd BufNewFile,BufRead * if expand('%t') =~ '\.env' | set filetype=sh | endif

" For some reason it stopped setting tw correctly
au FileType gitcommit setlocal tw=72

au BufRead,BufNewFile .babelrc,.eslintrc set ft=json
au BufRead,BufNewFile *nginx.conf.* set ft=nginx

" update scss files for SassDoc comments
au FileType scss set comments^=:///

" Use ag instead of ack
if executable('ag')
  " Use ag for grepping
  let g:ackprg='ag --vimgrep'

  " grep visually selected text
  vmap <leader>g y:Ag<space><C-R>"<cr>
  nmap <leader>g :Ag<space>

  " go to previous and next matches when using <leader>g
  nmap <F9> :cp<cr>
  nmap <F10> :cn<cr>
endif

" ================================================================
" => VIM user interface
" ================================================================

" Ignore case when searching, but become case-sensitive if there is a capital
set ignorecase
set smartcase

" Don't redraw while executing macros (good performance config)
set lazyredraw

" update tab behavior
set nowrap

" ================================================================
" => Colors and Fonts
" ================================================================

if has("termguicolors")
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
let g:solarized_old_cursor_style=1

set background=dark

silent! colorscheme desert

" let it fail quietly if it hasn't been installed yet
silent! colorscheme solarized8

if has("nvim")
  " Update cursor after the changes to nvim
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0
  set guicursor+=i-ci:block-Cursor/lCursor
  set guicursor+=r-cr:hor20-Cursor/lCursor
else
  set guicursor=
endif

" ================================================================
" => Moving around, tabs, windows and buffers
" ================================================================
map <leader>bb :Buffers<cr>

" Close all buffers except current
map <leader>bo :BufOnly<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" ================================================================
" => Spell checking
" ================================================================
" always enforce spell checking in text files
autocmd BufRead,BufNewFile *.txt,*.md,COMMIT_EDITMSG setlocal spell

" toggle spell checking for current file only
map <leader>ss :setlocal spell!<cr>

" linux doesn't do this by default, so enable it just to be safe
hi SpellBad cterm=underline

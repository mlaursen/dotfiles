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

Plug 'jparise/vim-graphql'
Plug 'hashivim/vim-terraform'

" ==================================
" Linters, validators, and autocomplete
" ==================================
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'

Plug 'mlaursen/vim-react-snippets'
Plug 'mlaursen/mlaursen-vim-snippets'

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
      \ 'coc-eslint',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-prettier',
      \ 'coc-tsserver',
      \ 'coc-yaml',
      \ 'coc-vimlsp',
      \ 'coc-spell-checker',
      \ 'coc-webview',
      \ 'coc-markdown-preview-enhanced',
      \ 'coc-snippets'
      \ ]

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-o> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-o> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" quickly jump between diagnostics
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" goto definition
nmap <silent> gd <Plug>(coc-definition)
" goto type
nmap <silent> gK <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
" get references
nmap <silent> gr <Plug>(coc-references)

" format rename
nmap <silent> fr <Plug>(coc-rename)

" format file
nmap <silent> ff <Plug>(coc-format)

" show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
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
nmap <silent>fI :<C-u>CocCommand editor.action.organizeImport<cr>

" Formatting selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

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
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

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

"  ================================================================
" UltiSnips
" ================================================================
let g:UltiSnipsExpandTrigger='<c-space>'
let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME."/code/react-md/UltiSnips"]

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
let g:rooter_patterns = ['.git']
let g:rooter_buftypes = ['']


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
au BufRead,BufNewFile *.mdx set ft=markdown.mdx

" update scss files for SassDoc comments
au FileType scss set comments^=:///

" I use this to format comments to 80 characters
map <leader>sf :setlocal tw=80<cr>

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
" toggle spell checking for current file only
map <leader>ss :setlocal spell!<cr>

" linux doesn't do this by default, so enable it just to be safe
hi SpellBad cterm=underline

if has("unix")
  let lines = readfile("/proc/version")
  if lines[0] =~ "Microsoft"
    let g:clipboard = {
      \   'name': 'WslClipboard',
      \   'copy': {
      \      '+': 'clip.exe',
      \      '*': 'clip.exe',
      \    },
      \   'paste': {
      \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      \   },
      \   'cache_enabled': 0,
      \ }
  endif
endif
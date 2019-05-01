" ========== General VIM config
syntax on
set clipboard=unnamedplus
set nocompatible
set omnifunc=syntaxcomplete#Complete
set encoding=utf-8
set number
set laststatus=2
set nowrap
set scrolloff=5                  " Keep padding lines above and below cursor
set mouse=a                      " Enable mouse usage (all modes)
set number                       " show line numbers
set showcmd                      " show command in bottom bar
set cursorline                   " highlight current line
set autoindent                   " copy indent on new line
set nosmartindent                " disable not very smart indent, rely on plugins
set wildmenu                     " visual autocomplete for command menu
set lazyredraw                   " redraw only when we need to.
set showmatch                    " highlight matching [{()}]
set ignorecase                   " case insensitive
set diffopt+=vertical            " Prefer vertical windows split when diffing
set wildmode=longest,list,full
set wildmenu
set fillchars+=stl:\ ,stlnc:\ " Space.
set t_Co=256
set formatoptions-=t
set tags+=tags;$HOME             " Look for a tags file up until one is found

" Return to last edit position when opening files
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

" ========== VUNDLE
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" ========== PLUGINS
Plugin 'VundleVim/Vundle.vim' 		         " Vundle, the plugin manager

Plugin 'Shougo/neocomplete'                " Improved auto-completion
Plugin 'Shougo/vimproc.vim'                " Interactive command execution
Plugin 'Valloric/YouCompleteMe'            " Extended auto-completion for most languages
Plugin 'Xuyuanp/nerdtree-git-plugin'       " Git status in The Nerd Tree
Plugin 'ctrlpvim/ctrlp.vim'                " Quick search across files
Plugin 'editorconfig/editorconfig-vim'     " Parse & Comprehend .editorconfig
Plugin 'ervandew/supertab'                 " Auto-completion with Tab
Plugin 'godlygeek/tabular'                 " Easy table formatting
Plugin 'scrooloose/nerdtree'               " Tree explorer
Plugin 'shime/vim-livedown'                " Markdown utility
Plugin 'w0rp/ale'                          " Asynchronous Syntax Checker / Linter
Plugin 'tpope/vim-fugitive'                " Interactive Git Integration
Plugin 'vim-scripts/AnsiEsc.vim'           " Show ANSI colors instead of escaped chars

Plugin 'nbouscal/vim-stylish-haskell'      " Code formatting for Haskell on save
Plugin 'neovimhaskell/haskell-vim'	       " Indent & Highlights for Haskell
Plugin 'othree/yajs.vim'                   " Indent & Highlights for JavaScript
Plugin 'ElmCast/elm-vim'                   " Indent & Highlights for Elm
Plugin 'LnL7/vim-nix'                      " Indent & Highlights for Nix
Plugin 'purescript-contrib/purescript-vim' " Indent & Highlights for PureScript

call vundle#end()
filetype plugin indent on


" ==== STATUS LINE
function! Mode()
    redraw
    let l:mode = mode()
    if     mode ==# "n"  | exec 'hi User1 guifg=#000000 guibg=NONE    gui=NONE ctermfg=15  ctermbg=0  cterm=NONE' | return "NRM"
    elseif mode ==# "i"  | exec 'hi User1 guifg=#ffffff guibg=#ff0000 gui=bold ctermfg=15  ctermbg=9  cterm=bold' | return "INS"
    elseif mode ==# "R"  | exec 'hi User1 guifg=#ffff00 guibg=#5b7fbb gui=bold ctermfg=190 ctermbg=67 cterm=bold' | return "REP"
    elseif mode ==# "v"  | exec 'hi User1 guifg=#ffffff guibg=#810085 gui=NONE ctermfg=15  ctermbg=53 cterm=NONE' | return "VIS"
    elseif mode ==# "V"  | exec 'hi User1 guifg=#ffffff guibg=#810085 gui=NONE ctermfg=15  ctermbg=53 cterm=NONE' | return "V-L"
    elseif mode ==# "" | exec 'hi User1 guifg=#ffffff guibg=#810085 gui=NONE ctermfg=15  ctermbg=53 cterm=NONE' | return "V-B"
    else                 | return l:mode
    endif
endfunc

function! SetStatusLine()
  let &stl=""
  let &stl.="%1*\ %{Mode()} %0*"
  let &stl.=" %<%F"
  let &stl.=" %([%R%M]%)"
  let &stl.=" %= "
  let &stl.="%(%{(&ro!=0?'(readonly)':'')} |%)"
  let &stl.=" LN %-.l/%-.L"
  let &stl.=" COL %-3.c"
  let &stl.="%(%6* %{&modified ? 'modified':''} %)"
endfunction

call SetStatusLine()


" ===== PLUGIN:ALE

function! GetHLintOptions()
  let l:opts = '-X TypeApplications'
  let l:hlintfile = findfile('HLint.hs', system('git rev-parse --show-toplevel')[:-2])

  if empty(l:hlintfile)
    let l:hlintfile = findfile('.hlint.yaml', system('git rev-parse --show-toplevel')[:-2])
  endif

  if !empty(l:hlintfile)
    let l:opts .= ' -h '
    let l:opts .= hlintfile
  endif

  return opts
endfunction

let g:ale_sign_warning = "!"
let g:ale_sign_error = "✗"
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_quickfix = 1
let g:ale_haskell_hlint_options = GetHLintOptions()
let g:ale_use_global_executables = 1
let g:ale_linters = {
\ 'haskell': ['hlint'],
\ 'elm': ['make']
\}
nmap <silent> <C-e> <Plug>(ale_next_wrap)
nmap <silent> <C-d> <Plug>(ale_previous_wrap)
nmap <silent> <C-i> <Plug>(ale_detail)


" ===== PLUGIN:YOUCOMPLETEME
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_semantic_triggers = {'elm' : ['.'], 'haskell' : ['.'], 'javascript': ['.']}
let g:ycm_python_binary_path = 'python'
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" ===== PLUGIN:HASKELL-VIM
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_indent_disable = 1          " to disable 'smart' indentation


" ===== PLUGIN:ELM-VIM
let g:elm_format_autosave = 1


" ===== PLUGIN:NERDTREE
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" close vim if the only window opened is a NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" ===== PLUGIN:TABULAR
let g:haskell_tabular = 1

vmap t= :Tabularize /=<CR>
vmap t; :Tabularize /::<CR>
vmap t- :Tabularize /-><CR>
vmap tt :Tabularize /\|<CR>
vmap ti :Tabularize /\C[A-Z].*<CR>
vmap ta :Tabularize /(.*\\| as.*\\| hiding.*<CR>


" ===== PLUGIN:CTRL-P
map <C-p> :CtrlP()<CR>
noremap <leader>b<space> :CtrlPBuffer<cr>
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard', '.worktree']


" ===== TABS & SPACES
set expandtab                    " tabs are spaces
set tabstop=2                    " number of visual spaces per TAB
set softtabstop=2                " number of spaces in tab when editing
set backspace=2                  " Allow backspace on everything in insert mode
set shiftwidth=2
set textwidth=0
set wrapmargin=0


" default config when not specified with .editorconfig
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,markdown} set filetype=markdown
autocmd BufNewFile,BufRead *.i18n set filetype=cucumber
" autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,markdown} set textwidth=95
" autocmd BufNewFile,BufRead *.{tex} set textwidth=90
autocmd BufNewFile,BufRead *.{go} set shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.js set tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.{hs} set formatprg=stylish-haskell
autocmd BufNewFile,BufRead *.{ejs} set shiftwidth=2 tabstop=2 softtabstop=2

function! <SID>StripTrailingWhitespaces()
    let _s=@/
    let l=line(".")
    let c=col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

let blacklist = ['markdown'] "don't strip trailing whitespaces on markdown, they have meaning
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :call <SID>StripTrailingWhitespaces()

" ========== SEARCH & REPLACE
set smartcase                    " case sensitive when starting with Capital letter
set incsearch                    " search as characters are entered
set hlsearch                     " highlight matches


" ========== FOLDING
set foldenable                   " enable folding
set foldlevelstart=10            " open most folds by default
set foldnestmax=3                " 3 nested fold max
set foldmethod=indent            " fold based on indent level


" ========== BINDINGS
" navigation between tabs
nnoremap <silent> <C-Left> :tabprevious<CR>
nnoremap <silent> <C-Right> :tabnext<CR>
nnoremap <silent> <C-S-Left> :tabfirst<CR>
nnoremap <silent> <C-S-Right> :tablast<CR>


" ========== COLOR SCHEME
colorscheme github
hi StatusLine ctermbg=205 ctermfg=15
hi VertSplit  ctermbg=205 ctermfg=15
hi HorizSplit ctermbg=205 ctermfg=15


" ========== VARIOUS REMAPPING

" Open tags in a vertical split rather than horizontal one
nnoremap <C-\> :execute "pop"<CR>

" force redraw
map <silent> <leader>r :redraw!<CR>

" avoid paste when clicking on wheel
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>


" ========== EXTRA COMMANDS
command -range=% JSON execute "<line1>,<line2>!python -m json.tool"
command -nargs=+ Grap execute "!git grep -n <args>"

" ========== General VIM config
syntax on
set encoding=utf-8
set nocompatible
set clipboard=unnamedplus
set hidden
set number
set laststatus=2
set nowrap
set updatetime=500                                   " Reduce update time of swap files
set scrolloff=5                                      " Keep padding lines above and below cursor
set mouse=a                                          " Enable mouse usage (all modes)
set number                                           " show line numbers
set showcmd                                          " show command in bottom bar
set cursorline                                       " highlight current line
set autoindent                                       " copy indent on new line
set nosmartindent                                    " disable not very smart indent, rely on plugins
set wildmenu                                         " visual autocomplete for command menu
set nolazyredraw                                     " redraw only when we need to.
set showmatch                                        " highlight matching [{()}]
set ignorecase                                       " case insensitive
set diffopt+=vertical                                " Prefer vertical windows split when diffing
set wildmode=longest,list,full
set wildmenu
set fillchars+=stl:\ ,stlnc:\ " Space.
set t_Co=256
set formatoptions-=t
set guifont="Roboto Mono 10"
set tags+=tags;../tags;$HOME                         " Look for a tags file up until one is found
set modeline
set signcolumn=yes
set splitbelow
set exrc                                             " Allow project-specific .vimrc
set secure                                           " Only run :autocmd on file owned by me
set completeopt=menu,menuone,popup,noselect,noinsert " Show documentation in popups
set smartcase                                        " case sensitive when starting with Capital letter
set incsearch                                        " search as characters are entered
set hlsearch                                         " highlight matches

" Return to last edit position when opening files
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

" force redraw on CTRL-r
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

" ===== PLUGIN:COC

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nmap <silent> <C-e> <Plug>(coc-diagnostic-next)
nmap <silent> <C-S-e> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-d> <Plug>(coc-codeaction)
nmap <silent> gd <Plug>(coc-definition)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Automatically format on save
autocmd BufWritePre *.{hs} silent call CocAction('format')

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" ==== BINDINGS
" navigation between tabs
nnoremap <silent> <C-Left> :tabprevious<CR>
nnoremap <silent> <C-Right> :tabnext<CR>
nnoremap <silent> <C-S-Left> :tabfirst<CR>
nnoremap <silent> <C-S-Right> :tablast<CR>


" ==== COLOR SCHEME
colorscheme github
hi StatusLine ctermbg=205 ctermfg=15
hi VertSplit  ctermbg=205 ctermfg=15
hi HorizSplit ctermbg=205 ctermfg=15


" ===== STATUS LINE
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


" ===== TABS & SPACES
set foldenable                                       " enable folding
set foldlevelstart=10                                " open most folds by default
set foldnestmax=3                                    " 3 nested fold max
set foldmethod=indent                                " fold based on indent level
set expandtab                                        " tabs are spaces
set tabstop=2                                        " number of visual spaces per TAB
set softtabstop=2                                    " number of spaces in tab when editing
set backspace=2                                      " Allow backspace on everything in insert mode
set shiftwidth=2
set textwidth=0

" default config when not specified with .editorconfig
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,markdown} set filetype=markdown wrap linebreak list listchars=eol:⏎ spell
autocmd BufNewFile,BufRead *.{tex} set filetype=tex wrap linebreak list listchars=eol:⏎ spell

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


" ===== EXTRA COMMANDS
command -range=% JSON execute "<line1>,<line2>!python -m json.tool"
command MarkdownPreview execute "call Vim_Markdown_Preview()"


" ===== VUNDLE
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim' 		         " Vundle, the plugin manager
Plugin 'ctrlpvim/ctrlp.vim'                " Quick search across files
Plugin 'godlygeek/tabular'                 " Easy table formatting
Plugin 'tpope/vim-fugitive'                " Git bindings in ViM
Plugin 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Plugin 'dense-analysis/ale'                " Asynchronous Syntax Checker / Linter
" Plugin 'ervandew/supertab'                 " Use <Tab> for completion
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'soywod/unfog.vim'                  " Time tracker + TODO list, require unfog CLI
Plugin 'editorconfig/editorconfig-vim'     " Parse & Comprehend .editorconfig
Plugin 'neovimhaskell/haskell-vim'	       " Indent & Highlights for Haskell
Plugin 'othree/yajs.vim'                   " Indent & Highlights for JavaScript
Plugin 'ElmCast/elm-vim'                   " Indent & Highlights for Elm
Plugin 'LnL7/vim-nix'                      " Indent & Highlights for Nix

call vundle#end()
filetype plugin indent on


" ===== PLUGIN:SUPERTAB
let g:SuperTabDefaultCompletionType = "<c-n>"


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

let g:ale_sign_warning = "⚠️"
let g:ale_sign_error = "✗"
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_quickfix = 1
let g:ale_haskell_hlint_options = GetHLintOptions()
let g:ale_use_global_executables = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\ 'haskell': ['stylish-haskell'],
\ 'javascript': ['prettier'],
\}
let g:ale_linters = {}
" nmap <silent> <C-e> <Plug>(ale_next_wrap)
" nmap <silent> <C-d> <Plug>(ale_previous_wrap)
" nmap <silent> <C-i> <Plug>(ale_detail)


" ===== PLUGIN:MARKDOWN-PREVIEW
nmap <C-k> <Plug>MarkdownPreview


" ===== PLUGIN:HASKELL-VIM
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_indent_disable = 1          " to disable 'smart' indentation

" Automatically run hasktags on save when editing Haskell files.
autocmd BufWritePost *.hs :silent exec "!git hasktags &"

" Automatically run hpack on save when editing a 'package.yaml' files.
autocmd BufWritePost package.yaml call Hpack()
function Hpack()
  let err = system('hpack ' . expand('%'))
  if v:shell_error
    echo err
  endif
endfunction


" ===== PLUGIN:ELM-VIM
let g:elm_format_autosave = 1


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
let g:ctrlp_user_command = ['.git' , 'cd %s && git ls-files -co --exclude-standard']

"#############################################################################
"                           VUNDLE CONFIGURATION

set nocompatible              " be iMproved, required
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
"
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'https://github.com/shime/vim-livedown.git'
Plugin 'https://github.com/vim-scripts/LanguageTool'
Plugin 'https://github.com/calincru/qml.vim'
Plugin 'https://github.com/fatih/vim-go'
Plugin 'https://github.com/Valloric/YouCompleteMe'
Plugin 'https://github.com/nsf/gocode'
Plugin 'https://github.com/scrooloose/syntastic'
Plugin 'https://github.com/ElmCast/elm-vim'
Plugin 'isRuslan/vim-es6'

let g:languagetool_jar='$HOME/.LanguageTool-3.0/languagetool-commandline.jar'
let g:syntastic_fortran_compiler_options='-I $FORTRAN_PATH -c'
let g:syntastic_fortran_cflags='-lnetcdff'
let g:languagetool_lang='en'

let g:ycm_semantic_triggers = {'elm' : ['.']}

let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_args = '--fix'
let g:syntastic_check_on_wq = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_error_symbol = "✗"
let g:syntastic_cucumber_cucumber_args = '-q'
let g:syntastic_ignore_files= ['.feature$']

let g:go_fmt_fail_silently = 1

let g:elm_format_autosave = 1
let g:elm_make_output_file = "elm.js"
let g:elm_detailed_complete = 1

call vundle#end()            " required
filetype plugin indent on    " required

" Golang linter
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
"autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"
" SHOW A VERTICAL RULER
highlight Overlength ctermbg=yellow ctermfg=white guibg=#f39c12
match Overlength /\%101v.\+/

" Command for markdown preview
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,markdown} set filetype=markdown
autocmd BufRead,BufNewFile *.i18n set filetype=cucumber
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,markdown} set textwidth=95
autocmd BufNewFile,BufRead *.{tex} set textwidth=90
autocmd BufNewFile,BufRead *.{sass} set shiftwidth=2 tabstop=2 softtabstop=2

" #############################################################################
"                            MY PERSONAL CONFIGURATION
"
" let mapleader=","                " leader is comma
"
" #############################################################################
"                                  COLOR
"
colorscheme badwolf              " awesome colorscheme
syntax enable                    " enable syntax processing
"
"
" #############################################################################
"                               SPACES and TABS

set tabstop=4                    " number of visual spaces per TAB
set softtabstop=4                " number of spaces in tab when editing
set expandtab                    " tabs are spaces
set backspace=2                  " Allow backspace on everything in insert mode
set shiftwidth=4
set textwidth=100

function! <SID>StripTrailingWhitespaces()
    let _s=@/
    let l=line(".")
    let c=col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

let blacklist = ['markdown']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :call <SID>StripTrailingWhitespaces()

" #############################################################################
"                                  UI CONFIG

set mouse=a                      " Enable mouse usage (all modes)
set number                       " show line numbers
set showcmd                      " show command in bottom bar
set cursorline                   " highlight current line
set autoindent                   " copy indent on new line
filetype indent on               " load filetype-specific indent files
set wildmenu                     " visual autocomplete for command menu
set lazyredraw                   " redraw only when we need to.
set showmatch                    " highlight matching [{()}]
set ignorecase                   " case insensitive

" avoid paste when clicking on wheel
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>
" #############################################################################
"                                  SEARCHING

set incsearch                    " search as characters are entered
set hlsearch                     " highlight matches
" turn off search highlight with [,<space>]
" nnoremap <leader><space> :nohlsearch<CR>

" #############################################################################
"                                  FOLDING
"
set foldenable                   " enable folding
set foldlevelstart=10            " open most folds by default
set foldnestmax=3                " 3 nested fold max
" space open/closes folds
set foldmethod=indent            " fold based on indent level

" #############################################################################
"                                  MOVEMENT
"
" move vertically by visual line
" nnoremap j gj
" nnoremap k gk
" jk is escape
" inoremap jk <esc>
"

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :next<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>


" #############################################################################
"                                  COMMANDS
"
command -range=% JSON execute "<line1>,<line2>!python -m json.tool"


" #############################################################################
"                                  NAVIGATION
"
set wildmode=longest,list,full
set wildmenu

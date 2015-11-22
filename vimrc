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
Plugin 'https://github.com/walm/jshint.vim'

let g:languagetool_jar='$HOME/.LanguageTool-3.0/languagetool-commandline.jar'
let g:languagetool_lang='en'
let g:jshintconfig='$HOME/.jshint/config.json'

call vundle#end()            " required
filetype plugin indent on    " required
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
highlight Overlength ctermbg=red ctermfg=white guibg=#592929
match Overlength /\%101v.\+/

" Command for markdown preview
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,markdown} set filetype=markdown
autocmd BufRead,BufNewFile *.i18n set filetype=cucumber
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,tex,markdown} set textwidth=95

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

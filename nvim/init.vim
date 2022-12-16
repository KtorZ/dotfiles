call plug#begin()

Plug 'ctrlpvim/ctrlp.vim'                       " Quick fuzz-search across files
Plug 'tpope/vim-fugitive'                       " Git bindings in ViM
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP client
Plug 'editorconfig/editorconfig-vim'            " Parse & follow .editorconfig
Plug 'neovimhaskell/haskell-vim'	        " Indent & Highlights for Haskell
Plug 'othree/yajs.vim'                          " Indent & Highlights for JavaScript
Plug 'ElmCast/elm-vim'                          " Indent & Highlights for Elm
Plug 'LnL7/vim-nix'                             " Indent & Highlights for Nix
Plug 'CardanoSolutions/aiken-vim'               " Indent & Highlights for Aiken
Plug 'vim-airline/vim-airline'   		" Opinionated airline
Plug 'godlygeek/tabular' 			" Tabularize text
Plug 'powerman/vim-plugin-AnsiEsc' 		" Interpret Ansi escaped characters in files (colors, bold, etc.)
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

call plug#end()

colorscheme elflord

set number                               " Show line numbers on the left side.
set signcolumn=number                    " Always show the signcolumn, otherwise it would shift when diagnostic appear
set updatetime=300                       " Reduce updatetime for better user experience
set shortmess+=c                         " Don't pass messages to |ins-completion-menu|.
set tags+=tags;../tags;$HOME             " Look for a tags file up until one is found
set scrolloff=5                          " Keep padding lines above and below cursor
set mouse=nv 				 " Allow usage of mouse in normal (n) and visual (v) modes
set clipboard+=unnamedplus  		 " Use the system clipboard by default
set exrc 				 " Enable per-project .nvimrc
set cursorline 				 " Highlight the current line the cursor is at
set cursorcolumn 			 " Highlight the current column the cursor is at
set cursorlineopt=number  		 " Subtle highlight, only in the left col numbers
lang en_US.UTF-8

" Change the color of the vertical ruler to something more subtle
highlight ColorColumn  ctermbg=16
highlight CursorColumn ctermbg=233

" Return to last edit position when opening files
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

" Navigate through diagnostic reports via CTRL+E / CTRL+SHIFT-E
nnoremap <silent> <C-e> <Plug>(coc-diagnostic-next)
nnoremap <silent> <C-E> <Plug>(coc-diagnostic-next)
nnoremap <silent><nowait> <space>e :<C-u>CocList diagnostics<cr>

" Trigger code action menu via CTRL+D
nnoremap <silent> <C-d> <Plug>(coc-codeaction)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
let g:airline#extensions#coc#enabled = 1

" Trim trailing whitespaces
function! <SID>StripTrailingWhitespaces()
    let _s=@/
    let l=line(".")
    let c=col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

let blacklist = []
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :call <SID>StripTrailingWhitespaces()

autocmd BufWritePost *.ak silent call CocAction('format')

" Only list files listed by git on CTRL+P
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Navigation between tabs
nnoremap <silent> <C-Left> :tabprevious<CR>
nnoremap <silent> <C-Right> :tabnext<CR>
nnoremap <silent> <C-S-Left> :tabfirst<CR>
nnoremap <silent> <C-S-Right> :tablast<CR>

" ==== RUST

" Automatically run calculate tags on save
autocmd BufWritePost *.rs :silent exec '!ctags -a -f $(git rev-parse --show-toplevel)/tags %'

" Run a Rust program
command! -nargs=0 CargoRun :call CocActionAsync('runCommand', 'rust-analyzer.run')

" ==== HASKELL

" Automatically format on save
autocmd BufWritePre *.{hs} silent call CocAction('format')

" Automatically run hasktags on save
autocmd BufWritePost *.hs :silent exec '!git hasktags &'

" Automatically run hpack when saving 'package.yaml'
autocmd BufWritePost package.yaml call Hpack()
function Hpack()
    let err = system('hpack ' . expand('%'))
    if v:shell_error
        echo err
    endif
endfunction

" ==== MARKDOWN

" Preview markdown on Ctrl-k
nmap <C-k> <Plug>MarkdownPreview

" ==== TABULARIZE

vmap tt :Tabularize /\|<CR>

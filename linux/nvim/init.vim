inoremap <silent> <esc> <esc>`^
nnoremap ; :

set splitbelow
set splitright

call plug#begin('~/.local/share/nvim/plugged')
Plug 'brooth/far.vim'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'derekwyatt/vim-scala'
Plug 'rust-lang/rust.vim'
call plug#end()


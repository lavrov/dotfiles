inoremap <silent> <esc> <esc>`^
nnoremap ; :

nnoremap <silent> ,cc :CargoBuild<CR>
nnoremap <silent> ,ct :CargoTest<CR>

set splitbelow
set splitright

call plug#begin('~/.local/share/nvim/plugged')
Plug 'brooth/far.vim'
Plug 'kien/ctrlp.vim'
Plug 'derekwyatt/vim-scala'
Plug 'rust-lang/rust.vim'
Plug 'timonv/vim-cargo'
Plug 'tpope/vim-surround'
call plug#end()


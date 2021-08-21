set path+=**

" Nice menu when typing ':find *.js'
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

call plug#begin(stdpath('config') . '/plugged')
" Telescope specific
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" My colors
Plug 'gruvbox-community/gruvbox'

" vimitor history
Plug 'mbbill/undotree'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'

" Neovim Tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" prettier
Plug 'sbdchd/neoformat'

" auto closing ( [ {
Plug 'jiangmiao/auto-pairs'

" Conqueror of completion
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

"   list of CoC extensions needed
"let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']

" plugins for highlighting and indenting to jsx and tsx files
"Plug 'yuezk/vim-js'
"Plug 'HerringtonDarkholme/yats.vim'
"Plug 'maxmellon/vim-jsx-pretty'

call plug#end()

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

let mapleader = " "

nnoremap <leader>pv :Ex<CR>

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d

inoremap <C-c> <esc>

" Undotree
nnoremap <F5> :UndotreeToggle<CR>
if has("persistent_undo")
    let target_path = expand('~/.dotfiles/nvim/.config/nvim/undodir')

    " create the directory and any parent directories
    " if the location does not exist
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup THE_CYBORG
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

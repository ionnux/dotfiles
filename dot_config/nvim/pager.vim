
packadd hop.nvim
" packadd rose-pine.nvim
lua require'hop'.setup()
nnoremap <silent>s :HopChar1<cr>
vnoremap <silent>s <cmd> lua require'hop'.hint_char1()<cr>
nnoremap <silent>gl :HopLine<cr>
vnoremap <silent>gl <cmd> lua require'hop'.hint_lines()<cr>

" highlight on yank
au TextYankPost * lua vim.highlight.on_yank { timeout = 300, higroup = Search }

colorscheme tokyonight
let g:tokyonight_style = "storm"
" colorscheme rose-pine
" let g:rose_pine_variant = 'moon'

set nonumber
set ignorecase
set smartcase
set cursorline
set nolist
set showtabline=0
set foldcolumn=0
set laststatus=0
set noshowmode 
set noruler
set noshowcmd
set shortmess+=F
set clipboard+=unnamedplus

autocmd TermOpen * normal G
map q :qa!<cr>


packadd hop.nvim
" packadd rose-pine.nvim
" lua require'hop'.setup()
nnoremap <silent>s :HopChar1AC<cr>
nnoremap <silent>S :HopChar1BC<cr>
vnoremap <silent>s <cmd> lua require'hop'.hint_char1()<cr>
nnoremap <silent>gl :HopLineAC<cr>
nnoremap <silent>gL :HopLineBC<cr>
vnoremap <silent>gl <cmd> lua require'hop'.hint_lines()<cr>

colorscheme rose-pine
" colorscheme tokyonight
let g:rose_pine_variant = 'moon'
" let g:tokyonight_style = "storm"

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

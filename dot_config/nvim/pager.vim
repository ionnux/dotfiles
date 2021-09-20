
packadd hop.nvim
packadd tokyonight.nvim
" lua require'hop'.setup()
nnoremap <silent>s :HopChar1AC<cr>
nnoremap <silent>S :HopChar1BC<cr>
vnoremap <silent>s <cmd> lua require'hop'.hint_char1()<cr>
nnoremap <silent>gl :HopLineAC<cr>
nnoremap <silent>gL :HopLineBC<cr>
vnoremap <silent>gl <cmd> lua require'hop'.hint_lines()<cr>

colorscheme tokyonight
let g:tokyonight_style = "night"

set nonumber
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


packadd hop.nvim
lua require'hop'.setup()
nnoremap s :HopChar1AC<cr>
nnoremap S :HopChar1BC<cr>
vnoremap s <cmd> lua require'hop'.hint_char1()<cr>
nnoremap gl :HopLineAC<cr>
nnoremap gL :HopLineBC<cr>
vnoremap gl <cmd> lua require'hop'.hint_lines()<cr>


set nonumber
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

silent write! /tmp/kitty_scrollback_buffer | te echo -n \"$(cat /tmp/kitty_scrollback_buffer)\" && sleep 1000 

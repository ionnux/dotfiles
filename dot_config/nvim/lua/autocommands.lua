-- automatically clear search highlight once leaving the commandline
vim.cmd [[
augroup IncSearchHighlight
  autocmd!
  autocmd CmdlineEnter [/\\?] :set hlsearch
  autocmd CmdlineLeave [/\\?] :set nohlsearch
augroup END
]]

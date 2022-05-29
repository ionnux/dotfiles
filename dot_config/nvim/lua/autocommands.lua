-- automatically clear search highlight once leaving the commandline
vim.cmd([[
augroup IncSearchHighlight
  autocmd!
  autocmd CmdlineEnter [/\\?] :set hlsearch
  autocmd CmdlineLeave [/\\?] :set nohlsearch
augroup END
]])

-- windows to close with "q"
vim.cmd([[autocmd FileType help,startuptime,qf,lspinfo nnoremap <buffer><silent> q :close<CR>]])
vim.cmd([[autocmd FileType man nnoremap <buffer><silent> q :quit<CR>]])

-- set filetypes
vim.cmd([[autocmd BufRead,BufNewFile *.rasi setfiletype css]])
vim.cmd([[autocmd BufRead,BufNewFile *.drift setfiletype sql]])
vim.cmd([[autocmd BufRead,BufNewFile *.ex setfiletype elixir]])

-- Highlight on yank
vim.cmd("au TextYankPost * lua vim.highlight.on_yank { timeout = 300, higroup = Search }")

-- go to last loc when opening a buffer
-- vim.cmd([[
--   autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
-- ]])

-- show cursor line only in active window
vim.cmd([[
augroup cursorline
  autocmd!
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline
augroup END
]])

-- auto toggle number and relativenumber
vim.cmd([[
"show line number
augroup numbertoggle
    autocmd!
    set number
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd BufEnter __FLUTTER_DEV_LOG__ setlocal nonumber norelativenumber
augroup END

augroup RelativeNumbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]])

-- chezmoi apply
vim.cmd([[
augroup chezmoiApply
    autocmd!
    autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %
augroup END
 ]])

vim.cmd([[
 augroup elixir
    autocmd!
    "autocmd InsertLeave *.exs,*.ex :lua vim.lsp.buf.formatting()
    autocmd BufWritePre *.exs,*.ex :lua vim.lsp.buf.formatting()
augroup END
 ]])

local indent = 2

vim.g.mapleader = " "
vim.api.nvim_set_keymap( "n", "<space>", "<Nop>", { noremap = true } )
-- vim.g.maplocalleader = ","
vim.opt.autowrite = true -- enable auto write
-- vim.opt.clipboard = "unnamedplus" -- sync with system clipboard
vim.opt.conceallevel = 2 -- Hide * markup for bold and italic
vim.opt.concealcursor = "n" -- Hide * markup for bold and italic
vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
vim.opt.cursorline = false -- Enable highlighting of the current line
vim.opt.expandtab = true -- Use spaces instead of tabs
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- TreeSitter folding
-- vim.opt.foldmethod = "expr" -- TreeSitter folding
-- vim.opt.foldlevel = 6
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.hidden = true -- Enable modified buffers in background
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = "split" -- preview incremental substitute
vim.opt.joinspaces = false -- No double spaces with join after a dot
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.mouse = "a" -- enable mouse mode
-- vim.opt.number = true -- Print line number
-- vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
-- vim.opt.relativenumber = true -- Relative line numbers
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = indent -- Size of an indent
vim.opt.showmode = false -- dont show mode since we have a statusline
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.tabstop = indent -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.undofile = true
vim.opt.undodir = [[/home/og_saaz/.nvim/undo]]
vim.opt.undolevels = 10000
vim.opt.updatetime = 200 -- save swap file and trigger CursorHold
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.wrap = true -- Disable line wrap
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.o.shortmess = "ToOlxfitn"

-- don't load the plugins below
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- Use proper syntax highlighting in code blocks
local fences = {
  "lua",
  -- "vim",
  "json",
  "typescript",
  "javascript",
  "js=javascript",
  "ts=typescript",
  "shell=sh",
  "python",
  "sh",
  "console=sh",
}
vim.g.markdown_fenced_languages = fences

-- plasticboy/vim-markdown
vim.g.vim_markdown_folding_level = 10
vim.g.vim_markdown_fenced_languages = fences
vim.g.vim_markdown_folding_style_pythonic = 1
vim.g.vim_markdown_conceal_code_blocks = 0
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_strikethrough = 1

vim.cmd( [[autocmd FileType markdown nnoremap gO <cmd>Toc<cr>]] )
vim.cmd( [[autocmd FileType markdown setlocal spell]] )

-- Check if we need to reload the file when it changed
vim.cmd( "au FocusGained * :checktime" )

-- number and relativenumber settings
vim.cmd(
  [[
"show line number
augroup numbertoggle
    autocmd!
    set number
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

augroup RelativeNumbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]]
 )

-- show cursor line only in active window
-- vim.cmd(
--   [[
--   autocmd InsertLeave,WinEnter * set cursorline
--   autocmd InsertEnter,WinLeave * set nocursorline
-- ]]
--  )

-- go to last loc when opening a buffer
vim.cmd(
  [[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
]]
 )

-- Highlight on yank
vim.cmd(
  "au TextYankPost * lua vim.highlight.on_yank { timeout = 300, higroup = search }"
 )

-- ftdetect
-- vim.cmd( [[autocmd BufRead,BufNewFile *.fish setfiletype fish]] )
-- vim.cmd( [[autocmd BufRead,BufNewFile *.nix setfiletype nix]] )

-- windows to close with "q"
vim.cmd(
  [[autocmd FileType help,startuptime,qf,lspinfo nnoremap <buffer><silent> q :close<CR>]]
 )
vim.cmd( [[autocmd FileType man nnoremap <buffer><silent> q :quit<CR>]] )

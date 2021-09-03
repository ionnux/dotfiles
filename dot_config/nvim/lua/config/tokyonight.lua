vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_day_brightness = 0.1
vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_variables = true
vim.g.tokyonight_transparent = false
-- vim.g.tokyonight_lualine_bold = 1
vim.g.tokyonight_hide_inactive_statusline = true
-- vim.g.tokyonight_sidebars = {"NvimTree"}
vim.g.tokyonight_transparent_sidebar = false
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_lualine_bold = true

vim.cmd [[colorscheme tokyonight]]
vim.cmd( "hi CursorLineNr guibg=None" )
vim.cmd( "hi normalFloat guibg=None" )
vim.cmd( "hi pmenu guibg=None" )
vim.cmd( "highlight StatusLine guibg=#1f2335" )

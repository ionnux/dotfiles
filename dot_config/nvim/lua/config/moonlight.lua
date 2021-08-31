vim.g.moonlight_italic_comments = true
vim.g.moonlight_italic_keywords = true
vim.g.moonlight_italic_functions = true
vim.g.moonlight_italic_variables = true
vim.g.moonlight_contrast = true
vim.g.moonlight_borders = true
vim.g.moonlight_disable_background = true

-- load the colorscheme
require('moonlight').set()
vim.cmd("highlight StatusLine guibg=None")

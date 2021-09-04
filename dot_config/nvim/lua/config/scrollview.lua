vim.g.scrollview_current_only = 1
vim.g.scrollview_excluded_filetypes = { 'NvimTree' }
vim.g.scrollview_column = 1
local colors = require( "colors" )
vim.cmd( 'highlight ScrollView guibg=' .. colors.grey )

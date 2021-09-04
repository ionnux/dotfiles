vim.g.scrollview_current_only = 1
vim.g.scrollview_excluded_filetypes = { 'NvimTree' }
vim.g.scrollview_column = 1
vim.cmd(
  [[
let colors = luaeval('require("colors")')
exe 'highlight ScrollView guibg=' . colors.blue
]]
 )

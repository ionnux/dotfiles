vim.g.tokyonight_style = 'storm'
-- vim.g.tokyonight_day_brightness = 0.1
vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_variables = true
vim.g.tokyonight_transparent = false
-- vim.g.tokyonight_lualine_bold = 1
vim.g.tokyonight_hide_inactive_statusline = false
vim.g.tokyonight_sidebars = { 'NvimTree', 'Mundo', 'MundoDiff' }
vim.g.tokyonight_transparent_sidebar = false
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_dark_float = false
vim.g.tokyonight_lualine_bold = true

vim.cmd([[colorscheme tokyonight]])
-- vim.cmd( "hi CursorLineNr guibg=None" )
-- vim.cmd( "hi normalFloat guibg=None" )
-- vim.cmd( "hi pmenu guibg=None" )
-- vim.cmd( "highlight StatusLine guibg=None" )
-- local theme_colors = require( "colors" )
-- vim.cmd( "highlight MatchParen guibg=" .. theme_colors.red ) vim.cmd( "highlight MatchParen guifg=" .. theme_colors.black )

local colors = {
  none = 'NONE',
  bg_dark = '#1f2335',
  bg = '#24283b',
  bg_highlight = '#292e42',
  terminal_black = '#414868',
  fg = '#c0caf5',
  fg_dark = '#a9b1d6',
  fg_gutter = '#3b4261',
  dark3 = '#545c7e',
  comment = '#565f89',
  dark5 = '#737aa2',
  blue0 = '#3d59a1',
  blue = '#7aa2f7',
  cyan = '#7dcfff',
  blue1 = '#2ac3de',
  blue2 = '#0db9d7',
  blue5 = '#89ddff',
  blue6 = '#B4F9F8',
  blue7 = '#394b70',
  magenta = '#bb9af7',
  magenta2 = '#ff007c',
  purple = '#9d7cd8',
  orange = '#ff9e64',
  yellow = '#e0af68',
  green = '#9ece6a',
  green1 = '#73daca',
  green2 = '#41a6b5',
  teal = '#1abc9c',
  red = '#f7768e',
  red1 = '#db4b4b',
  git = { change = '#6183bb', add = '#449dab', delete = '#914c54', conflict = '#bb7a61' },
  gitSigns = { add = '#164846', change = '#394b70', delete = '#823c41' },
}

-- gitsigns
vim.cmd('highlight GitSignsAdd guifg=' .. colors.green2)
vim.cmd('highlight GitSignsChange guifg=' .. colors.blue)
vim.cmd('highlight GitSignsDelete guifg=' .. colors.red)

-- lsp
-- border settings
vim.cmd(' highlight NormalFloat guibg=' .. colors.none .. ' guifg=' .. colors.dark5)
vim.cmd(' highlight FloatBorder guibg=' .. colors.none .. ' guifg=' .. colors.fg_gutter)

-- cmp
vim.cmd(' highlight CmpItemKind guifg=' .. colors.cyan)
vim.cmd(' highlight CmpItemAbbrMatch guifg=' .. colors.cyan)
vim.cmd(' highlight CmpItemAbbrMatchFuzzy guifg=' .. colors.cyan)
vim.cmd(' highlight CmpDocumentation guifg=' .. colors.cyan)

-- telescope
vim.cmd('highlight TelescopePromptBorder guifg=' .. colors.magenta)
vim.cmd('highlight TelescopePreviewBorder guifg=' .. colors.cyan)
vim.cmd('highlight TelescopeResultsBorder guifg=' .. colors.teal)

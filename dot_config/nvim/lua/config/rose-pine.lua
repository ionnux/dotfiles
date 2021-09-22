-- Set variant
-- Defaults to 'dawn' if vim background is light
-- @usage 'base' | 'moon' | 'dawn' | 'rose-pine[-moon][-dawn]'
vim.g.rose_pine_variant = 'base'

-- Disable italics
vim.g.rose_pine_disable_italics = false

-- Use terminal background
vim.g.rose_pine_disable_background = false
-- Set colorscheme after options
vim.cmd( 'colorscheme rose-pine' )

local colors = {
  base = '#191724',
  surface = '#1f1d2e',
  overlay = '#26233a',
  inactive = '#555169',
  subtle = '#6e6a86',
  text = '#e0def4',
  love = '#eb6f92',
  gold = '#f6c177',
  rose = '#ebbcba',
  pine = '#31748f',
  foam = '#9ccfd8',
  iris = '#c4a7e7',
}

-- undercurl
vim.cmd( "highlight LspDiagnosticsUnderlineError guibg=bg gui=undercurl guisp=" .. colors.love )
vim.cmd( "highlight LspDiagnosticsUnderlineWarning guibg=bg gui=undercurl guisp=" .. colors.gold )
vim.cmd( "highlight LspDiagnosticsUnderlineInformation guibg=bg gui=undercurl guisp=" .. colors.foam )
vim.cmd( "highlight LspDiagnosticsUnderlineHint guibg=bg gui=undercurl guisp=" .. colors.iris )

-- lspDiagnostics
vim.cmd( "highlight LspDiagnosticsVirtualTextError guifg=" .. colors.love )
vim.cmd( "highlight LspDiagnosticsVirtualTextWarning guifg=" .. colors.gold )
vim.cmd( "highlight LspDiagnosticsVirtualTextInformation guifg=" .. colors.foam )
vim.cmd( "highlight LspDiagnosticsVirtualTextHint guifg=" .. colors.iris )

-- MatchParen
vim.cmd( "highlight MatchParen term=underline cterm=underline gui=underline" )
vim.cmd( "highlight TelescopePromptBorder guifg=" .. colors.rose )
vim.cmd( "highlight TelescopePreviewBorder guifg=" .. colors.pine )
vim.cmd( "highlight TelescopeResultsBorder guifg=" .. colors.iris )

-- scrollview
-- vim.cmd( "highlight ScrollView guibg=" .. colors.gold )

-- dashboard
vim.cmd( "highlight DashboardHeader guifg=" .. colors.rose )
vim.cmd( "highlight DashboardFooter gui=bold guifg=" .. colors.rose )
vim.cmd( "highlight DashboardCenter gui=bold guifg=" .. colors.foam )
vim.cmd( "highlight DashboardShortCut gui=bold guifg=" .. colors.iris )

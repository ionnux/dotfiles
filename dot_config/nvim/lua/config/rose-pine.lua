-- Set variant
-- Defaults to 'dawn' if vim background is light
-- @usage 'base' | 'moon' | 'dawn' | 'rose-pine[-moon][-dawn]'
vim.g.rose_pine_variant = "moon"

-- Disable italics
vim.g.rose_pine_disable_italics = false

vim.g.rose_pine_bold_vertical_split_line = true

-- Use terminal background
vim.g.rose_pine_disable_background = false
-- Set colorscheme after options
vim.cmd("colorscheme rose-pine")

local palette = {
	base = "#191724",
	surface = "#1f1d2e",
	overlay = "#26233a",
	inactive = "#555169",
	subtle = "#6e6a86",
	text = "#e0def4",
	love = "#eb6f92",
	gold = "#f6c177",
	rose = "#ebbcba",
	pine = "#31748f",
	foam = "#9ccfd8",
	iris = "#c4a7e7",
	highlight = "#2a2837",
	highlight_inactive = "#211f2d",
	highlight_overlay = "#3a384a",
	none = "NONE",
}

if vim.g.rose_pine_variant == "dawn" or vim.g.rose_pine_variant == "rose-pine-dawn" then
	palette = {
		base = "#faf4ed",
		surface = "#fffaf3",
		overlay = "#f2e9de",
		inactive = "#9893a5",
		subtle = "#6e6a86",
		text = "#575279",
		love = "#b4637a",
		gold = "#ea9d34",
		rose = "#d7827e",
		pine = "#286983",
		foam = "#56949f",
		iris = "#907aa9",
		highlight = "#eee9e6",
		highlight_inactive = "#f2ede9",
		highlight_overlay = "#e4dfde",
	}
elseif vim.g.rose_pine_variant == "moon" or vim.g.rose_pine_variant == "rose-pine-moon" then
	palette = {
		base = "#232136",
		surface = "#2a273f",
		overlay = "#393552",
		inactive = "#59546d",
		subtle = "#817c9c",
		text = "#e0def4",
		love = "#eb6f92",
		gold = "#f6c177",
		rose = "#ea9a97",
		pine = "#3e8fb0",
		foam = "#9ccfd8",
		iris = "#c4a7e7",
		highlight = "#312f44",
		highlight_inactive = "#2a283d",
		highlight_overlay = "#3f3c53",
	}
end

-- undercurl
vim.cmd("highlight LspDiagnosticsUnderlineError guibg=bg gui=undercurl guisp=" .. palette.love)
vim.cmd("highlight LspDiagnosticsUnderlineWarning guibg=bg gui=undercurl guisp=" .. palette.gold)
vim.cmd("highlight LspDiagnosticsUnderlineInformation guibg=bg gui=undercurl guisp=" .. palette.foam)
vim.cmd("highlight LspDiagnosticsUnderlineHint guibg=bg gui=undercurl guisp=" .. palette.iris)

-- lspDiagnostics
vim.cmd("highlight LspDiagnosticsVirtualTextError guifg=" .. palette.love)
vim.cmd("highlight LspDiagnosticsVirtualTextWarning guifg=" .. palette.gold)
vim.cmd("highlight LspDiagnosticsVirtualTextInformation guifg=" .. palette.foam)
vim.cmd("highlight LspDiagnosticsVirtualTextHint guifg=" .. palette.iris)

-- MatchParen
vim.cmd("highlight MatchParen term=underline cterm=underline gui=underline,bold guifg=" .. palette.text)

-- visual
-- vim.cmd( "hi Visual gui=bold " )

-- eob_lines
vim.cmd("highlight EndOfBuffer guibg=" .. palette.base .. " guifg=" .. palette.base)

-- telescope
vim.cmd("highlight TelescopePromptBorder guifg=" .. palette.rose)
vim.cmd("highlight TelescopePreviewBorder guifg=" .. palette.pine)
vim.cmd("highlight TelescopeResultsBorder guifg=" .. palette.iris)

-- scrollview
-- vim.cmd( "highlight ScrollView guibg=" .. palette.gold )

-- dashboard
vim.cmd("highlight DashboardHeader guifg=" .. palette.rose)
vim.cmd("highlight DashboardFooter gui=bold guifg=" .. palette.rose)
vim.cmd("highlight DashboardCenter gui=bold guifg=" .. palette.foam)
vim.cmd("highlight DashboardShortCut gui=bold guifg=" .. palette.iris)

-- neogit
vim.cmd("hi NeogitNotificationInfo guifg=" .. palette.foam)
vim.cmd("hi NeogitNotificationWarning guifg=" .. palette.gold)
vim.cmd("hi NeogitNotificationError guifg=" .. palette.love)
vim.cmd("hi def NeogitDiffContextHighlight guibg=" .. palette.surface .. " guifg=" .. palette.text)
vim.cmd("highlight NeogitStagedchanges gui=bold,italic guifg=" .. palette.gold)
vim.cmd("highlight NeogitUnstagedchanges gui=bold,italic guifg=" .. palette.gold)
-- vim.cmd("highlight NeogitStagedchangesRegion guifg=" .. palette.foam)

-- vim.cmd[[
-- hi def NeogitDiffAddHighlight guibg=#404040 guifg=#859900
-- hi def NeogitDiffDeleteHighlight guibg=#404040 guifg=#dc322f
-- hi def NeogitDiffContextHighlight guibg=#333333 guifg=#b2b2b2
-- hi def NeogitHunkHeader guifg=#cccccc guibg=#404040
-- hi def NeogitHunkHeaderHighlight guifg=#cccccc guibg=#4d4d4d
-- ]]

-- lspsaga
vim.cmd("highlight LspSagaCodeActionBorder guifg=" .. palette.pine)
vim.cmd("highlight LspSagaCodeActionContent guifg=" .. palette.subtle)
vim.cmd("highlight LspSagaCodeActionTitle gui=bold guifg=" .. palette.iris)
vim.cmd("highlight LspSagaCodeActionTruncateLine gui=bold guifg=" .. palette.pine)

vim.cmd("highlight LspSagaDiagnosticBorder guifg=" .. palette.pine)
vim.cmd("highlight LspSagaDiagnosticHeader guifg=" .. palette.iris)
vim.cmd("highlight LspSagaDiagnosticTruncateLine guifg=" .. palette.pine)

-- lsp
-- border settings
vim.cmd(" highlight NormalFloat guibg=" .. palette.base .. " guifg=" .. palette.subtle)
vim.cmd(" highlight FloatBorder guibg=" .. palette.base .. " guifg=" .. palette.subtle)

--indent blankline
vim.cmd(" highlight IndentBlanklineChar guifg=" .. palette.inactive)

vim.g.material_style = "palenight"
require("material").setup({

	contrast = true, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
	borders = true, -- Enable borders between verticaly split windows

	italics = {
		comments = true, -- Enable italic comments
		keywords = true, -- Enable italic keywords
		functions = true, -- Enable italic functions
		strings = true, -- Enable italic strings
		variables = true, -- Enable italic variables
	},

	contrast_windows = { -- Specify which windows get the contrasted (darker) background
		"terminal", -- Darker terminal background
		"packer", -- Darker packer background
		"qf", -- Darker qf list background
		"NvimTree",
	},

	text_contrast = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = true, -- Enable higher contrast text for darker style
	},

	disable = {
		background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = true, -- Hide the end-of-buffer lines
	},

	-- custom_highlights = {} -- Overwrite highlights with your own
})

vim.cmd([[colorscheme material]])
-- Lua:
vim.cmd("hi CursorLineNr guibg=None")
vim.cmd("hi normalFloat guibg=None")
vim.cmd("hi pmenu guibg=None")
vim.cmd("highlight StatusLine guibg=None")

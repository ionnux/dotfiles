local nightfox = require("nightfox")

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
	fox = "nightfox", -- Which fox style should be applied
	transparent = false, -- Disable setting the background color
	-- alt_nc = false, -- Non current window bg to alt color see `hl-NormalNC`
	terminal_colors = true, -- Configure the colors used when opening :terminal
	styles = {
		comments = "italic", -- Style that is applied to comments: see `highlight-args` for options
		functions = "italic,bold", -- Style that is applied to functions: see `highlight-args` for options
		keywords = "bold", -- Style that is applied to keywords: see `highlight-args` for options
		strings = "italic", -- Style that is applied to strings: see `highlight-args` for options
		variables = "italic", -- Style that is applied to variables: see `highlight-args` for options
	},
	inverse = {
		match_paren = true, -- Enable/Disable inverse highlighting for match parens
		visual = false, -- Enable/Disable inverse highlighting for visual selection
		search = false, -- Enable/Disable inverse highlights for search highlights
	},
	colors = {}, -- Override default colors
	hlgroups = {}, -- Override highlight groups
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()

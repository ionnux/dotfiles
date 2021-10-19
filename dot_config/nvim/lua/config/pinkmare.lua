vim.cmd("colorscheme pinkmare")

local colors = {
	bg0 = "#202330",
	bg1 = "#472541",
	bg2 = "#472541",
	bg3 = "#472541",
	bg4 = "#2d2f42",
	bg_red = "#f2448b",
	bg_green = "#333b2f",
	bg_blue = "#203a41",
	fg = "#FAE8B6",
	red = "#FF38A2",
	orange = "#ffb347",
	yellow = "#ffc85b",
	green = "#9cd162",
	cyan = "#87c095",
	blue = "#eba4ac",
	purple = "#d9bcef",
	grey = "#444444",
	light_grey = "#6D7A72",
	gold = "#fff0f5",
	none = "NONE",
}

-- gitsigns
vim.cmd("highlight GitSignsAdd guifg=" .. colors.purple .. " guibg=" .. colors.none)
vim.cmd("highlight GitSignsChange guifg=" .. colors.cyan .. " guibg=" .. colors.none)
vim.cmd("highlight GitSignsDelete guifg=" .. colors.red .. " guibg=" .. colors.none)

-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
	show_end_of_line = true,
	space_char_blankline = " ",
	use_treesitter = true,
	show_trailing_blankline_indent = false,
	show_current_context = false,

	char = "¦",
	buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = {
		"help",
		"startify",
		"dashboard",
		"terminal",
		"TelescopePrompt",
		"TelescopeResults",
		"packer",
		"neogitstatus",
		"NvimTree",
		"Trouble",
		"man",
		"log",
		"flutterToolsOutline",
	},

	context_patterns = {
		"class",
		"return",
		"function",
		"method",
		"^if",
		"^while",
		"jsx_element",
		"^for",
		"^object",
		"^table",
		"block",
		"arguments",
		"if_statement",
		"else_clause",
		"jsx_element",
		"jsx_self_closing_element",
		"try_statement",
		"catch_clause",
		"import_statement",
		"operation_type",
	},
})

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
-- vim.wo.colorcolumn = "99999"

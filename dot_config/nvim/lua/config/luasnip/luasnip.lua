local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.setup({
	history = true,
	-- updateevents = 'InsertLeave',
	updateevents = "InsertLeave",
	enable_autosnippets = true,
	region_check_events = "CursorHold",
	delete_check_events = "TextChanged",
	store_selection_keys = "<Tab>",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { " Choice", "Error" } },
			},
		},
		[types.insertNode] = {
			active = {
				virt_text = { { "● ", "Comment" } },
			},
		},
	},
})

vim.api.nvim_set_keymap("i", "<c-j>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("i", "<c-k>", "<Plug>luasnip-prev-choice", {})
require("luasnip.loaders.from_vscode").load({ paths = "./snippets" })

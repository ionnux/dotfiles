local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.setup({
	history = false,
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

-- activate ChoiceNode popup
require("config.luasnip.choice_node_popup")
-- activate vscode placeholder
require("config.luasnip.vscode_placeholder")

vim.api.nvim_set_keymap("i", "<c-n>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("i", "<c-p>", "<Plug>luasnip-prev-choice", {})
require("luasnip.loaders.from_vscode").load({ paths = "./snippets" })

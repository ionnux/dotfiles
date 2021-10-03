require("persistence").setup({
	dir = vim.fn.expand(vim.fn.stdpath("config") .. "/sessions/"), -- directory where session files are saved
	options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving

	-- restore the session for the current directory
	vim.api.nvim_set_keymap(
		"n",
		"<leader>qs",
		[[<cmd>lua require("persistence").load()<cr>]],
		{ noremap = true, silent = true }
	),

	-- restore the last session
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ql",
		[[<cmd>lua require("persistence").load({ last = true })<cr>]],
		{ noremap = true, silent = true }
	),

	-- stop Persistence => session won't be saved on exit
	vim.api.nvim_set_keymap(
		"n",
		"<leader>qd",
		[[<cmd>lua require("persistence").stop()<cr>]],
		{ noremap = true, silent = true }
	),
})

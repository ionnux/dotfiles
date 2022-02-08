require("formatter").setup({
	logging = false,
	filetype = {
		dart = {
			-- dart format
			function()
				return { exe = "dart format", args = { "--fix" }, stdin = true }
			end,
		},

		sh = {
			function()
				return { exe = "beautysh", stdin = false }
			end,
		},

		zsh = {
			function()
				return { exe = "beautysh", stdin = false }
			end,
		},

		lua = {
			function()
				return {
					exe = "stylua",
					stdin = false,
				}
			end,
		},

		-- elixir = {
		-- 	function()
		-- 		return { exe = "mix format", stdin = false }
		-- 	end,
		-- },
	},
})

-- format on save
vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.dart,*.lua,*.sh,*zshrc FormatWrite
augroup END
]],
	true
)

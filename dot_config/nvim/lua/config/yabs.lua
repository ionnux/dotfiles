require("yabs"):setup({
	languages = {
		elixir = {
			tasks = {
				run = {
					command = "elixir %",
					type = "shell", -- The type of command (can be `vim`, `lua`, or `shell`, default `shell`)
				},
			},
		},
	},
	tasks = { -- Same values as `language.tasks`, but global
		build = {
			command = "echo building project...",
			output = "consolation",
		},
		run = {
			command = "echo running project...",
			output = "echo",
		},
		optional = {
			command = "echo runs on condition",
			-- You can specify a condition which determines whether to enable a
			-- specific task
			-- It should be a function that returns boolean,
			-- not a boolean directly
			-- Here we use a helper from yabs that returns such function
			-- to check if the files exists
			condition = require("yabs.conditions").file_exists("filename.txt"),
		},
	},
	opts = { -- Same values as `language.opts`
		output_types = {
			quickfix = {
				open_on_run = "always",
			},
		},
	},
})

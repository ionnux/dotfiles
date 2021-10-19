local trouble = require("trouble.providers.telescope")
local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		mappings = {
			-- i = { ["<c-t>"] = trouble.open_with_trouble, ["<esc>"] = actions.close },
			-- n = { ["<c-t>"] = trouble.open_with_trouble },
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		scroll_strategy = "cycle",
		dynamic_preview_title = true,
		layout_strategy = "flex",
		layout_config = {
			horizontal = { mirror = false, preview_width = 0.45 },
			vertical = { mirror = false },
			width = 0.9,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "/home/og_saaz/%.config/nvim/.*" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		winblend = 0,
		border = {},
		-- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		color_devicons = true,
		use_less = true,
		path_display = function(opts, path)
			return string.gsub(path, "/home/og_saaz", "~")
		end,
		-- path_display = "smart",

		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	},
	pickers = {
		lsp_code_actions = {
			-- theme = "get_custom",
			layout_config = {
				width = 65,
				height = 25,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
		frecency = { show_scores = false },
	},
})

-- local themes = require("telescope.themes")
-- function themes.get_custom(opts)
-- 	opts = opts or {}

-- 	local theme_opts = {
-- 		theme = "vertical",

-- 		results_title = false,
-- 		preview_title = "Preview",

-- 		sorting_strategy = "ascending",
-- 		layout_strategy = "cursor",
-- 		layout_config = {
-- 			preview_cutoff = 1, -- Preview should always show (unless previewer = false)

-- 			width = function(_, max_columns, _)
-- 				return math.min(max_columns, 80)
-- 			end,

-- 			height = function(_, _, max_lines)
-- 				return math.min(max_lines, 15)
-- 			end,
-- 		},

-- 		border = true,
-- 		borderchars = {
-- 			prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
-- 			results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
-- 			preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
-- 		},
-- 	}
-- 	if opts.layout_config and opts.layout_config.prompt_position == "bottom" then
-- 		theme_opts.borderchars = {
-- 			prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
-- 			results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
-- 			preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
-- 		}
-- 	end

-- 	return vim.tbl_deep_extend("force", theme_opts, opts)
-- end

require("telescope").load_extension("fzf")
require("telescope").load_extension("projects")
require("telescope").load_extension("frecency")

-- mappings
local wk = require("which-key")
wk.register({
	["<leader>t"] = {
		name = "Telescope", -- optional group name
		f = { "<cmd>Telescope find_files<cr>", "Telescope: Find File" }, -- create a binding with label
		r = { "<cmd>Telescope frecency<cr>", "Telescope: Recent Files using Frecency" }, -- additional options for creating the keymap
		o = { "<cmd>Telescope oldfiles<cr>", "Telescope:  Previously Opened Files" }, -- additional options for creating the keymap
		p = { "<cmd>Telescope projects theme=get_dropdown<cr>", "Telescope: Projects" },
		P = {
			function()
				require("telescope").extensions.packer.plugins(opts)
			end,
			"Telescope: Packer",
		},
		b = { "<cmd>Telescope buffers<cr>", "Telescope: Buffers" },
		h = { "<cmd>Telescope help_tags<cr>", "Telescope: Help Tags" },
	},
	-- ["<leader>c"] = {
	-- 	name = "Telescope Code Action",
	-- 	a = { "<cmd>Telescope lsp_code_actions<cr>", "Telescope: Code Actions" },
	-- },
})

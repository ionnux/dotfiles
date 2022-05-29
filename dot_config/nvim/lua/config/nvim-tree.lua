vim.api.nvim_set_keymap("n", "<leader>nn", ":NvimTreeToggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>nf", ":NvimTreeFocus<cr>", { noremap = true, silent = true })

-- vim.cmd([[ NvimTreeFolderIcon guibg=red]])
local tree_cb = require("nvim-tree.config").nvim_tree_callback
-- default mappings
local list = {
	{ key = { "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb("edit") },
	{ key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
	{ key = "<C-v>", cb = tree_cb("vsplit") },
	{ key = "<C-s>", cb = tree_cb("split") },
	{ key = "<C-t>", cb = tree_cb("tabnew") },
	{ key = "<", cb = tree_cb("prev_sibling") },
	{ key = ">", cb = tree_cb("next_sibling") },
	{ key = "P", cb = tree_cb("parent_node") },
	{ key = "<BS>", cb = tree_cb("close_node") },
	{ key = "<S-CR>", cb = tree_cb("close_node") },
	{ key = "<Tab>", cb = tree_cb("preview") },
	{ key = "K", cb = tree_cb("first_sibling") },
	{ key = "J", cb = tree_cb("last_sibling") },
	{ key = "I", cb = tree_cb("toggle_ignored") },
	{ key = "H", cb = tree_cb("toggle_dotfiles") },
	{ key = "R", cb = tree_cb("refresh") },
	{ key = "a", cb = tree_cb("create") },
	{ key = "d", cb = tree_cb("remove") },
	{ key = "r", cb = tree_cb("rename") },
	{ key = "<C-r>", cb = tree_cb("full_rename") },
	{ key = "x", cb = tree_cb("cut") },
	{ key = "c", cb = tree_cb("copy") },
	{ key = "p", cb = tree_cb("paste") },
	{ key = "y", cb = tree_cb("copy_name") },
	{ key = "Y", cb = tree_cb("copy_path") },
	{ key = "gy", cb = tree_cb("copy_absolute_path") },
	{ key = "[c", cb = tree_cb("prev_git_item") },
	{ key = "]c", cb = tree_cb("next_git_item") },
	{ key = "-", cb = tree_cb("dir_up") },
	{ key = "s", cb = tree_cb("system_open") },
	{ key = "q", cb = tree_cb("close") },
	{ key = "g?", cb = tree_cb("toggle_help") },
}

require("nvim-tree").setup({
	-- disables netrw completely
	disable_netrw = true,
	-- hijack netrw window on startup
	hijack_netrw = true,
	-- open the tree when running this setup function
	open_on_setup = false,
	-- will not open on setup if the filetype is in this list
	ignore_ft_on_setup = { "startify", "dashboard" },
	-- closes neovim automatically when the tree is the last **WINDOW** in the view
	auto_close = true,
	-- opens the tree when changing/opening a new tab if the tree wasn't previously opened
	open_on_tab = false,
	-- hijack the cursor in the tree to put it at the start of the filename
	hijack_cursor = true,
	-- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
	update_cwd = true,
	-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
	update_focused_file = {
		-- enables the feature
		enable = true,
		-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
		-- only relevant when `update_focused_file.enable` is true
		update_cwd = true,
		-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
		-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
		ignore_list = {},
	},

	-- hijacks new directory buffers when they are opened.
	update_to_buf_dir = {
		-- enable the feature
		enable = true,
		-- allow to open the tree if it was previously closed
		auto_open = true,
	},

	-- configuration options for the system open command (`s` in the tree by default)
	system_open = {
		-- the command to run this, leaving nil should work in most cases
		cmd = "",
		-- the command arguments as a list
		args = {},
	},

	-- show lsp diagnostics in the signcolumn
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	filters = {
		dotfiles = false,
		custom = {},
		exclude = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 35,
		height = 30,
		hide_root_folder = false,
		preserve_window_proportions = false,
		side = "left",
		auto_resize = true,
		mappings = {
			custom_only = false,
			list = list,
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	auto_reload_on_write = true,
	create_in_closed_folder = false,
	hijack_unnamed_buffer_when_opening = false,
	ignore_buffer_on_setup = false,
	open_on_setup_file = false,
	sort_by = "name",
	reload_on_bufenter = false,
	respect_buf_cwd = false,
	renderer = {
		add_trailing = false,
		group_empty = false,
		highlight_git = true,
		highlight_opened_files = "none",
		root_folder_modifier = ":~",
		indent_markers = {
			enable = false,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
	},
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
		open_file = {
			quit_on_open = true,
			resize_window = true,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
	live_filter = {
		prefix = "[FILTER]: ",
		always_show_folders = true,
	},
	log = {
		enable = false,
		truncate = false,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			diagnostics = false,
			git = false,
			profile = false,
		},
	},
})

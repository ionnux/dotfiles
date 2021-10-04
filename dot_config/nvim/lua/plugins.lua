return require("packer").startup(function(use)
	-- packer
	use("wbthomason/packer.nvim")

	-- impatient nvim
	-- use {
	-- 'lewis6991/impatient.nvim',
	-- rocks = 'mpack',
	-- config = function()
	-- end,
	-- }

	-- nvim-cmp
	use({
		"hrsh7th/nvim-cmp",
		disable = false,
		event = "InsertEnter",
		wants = { "vim-vsnip", "LuaSnip", "nvim-autopairs" },
		config = function()
			require("config.cmp")
		end,
		requires = {
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "hrsh7th/cmp-vsnip", after = { "nvim-cmp", "vim-vsnip" } },
			{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
			{ "hrsh7th/cmp-calc", after = "nvim-cmp" },
			{ "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } },
		},
	})

	-- coq_nvim
	use({ "ms-jpq/coq_nvim", branch = "coq", disable = true }) -- main one
	use({ "ms-jpq/coq.artifacts", branch = "artifacts", disable = true }) -- 9000+ Snippets

	-- friendly snippet (collection)
	use({ "rafamadriz/friendly-snippets", opt = true })

	-- LuaSnip
	use({ "L3MON4D3/LuaSnip", opt = true, wants = "friendly-snippets" })

	-- vim-vsnip
	use({
		"hrsh7th/vim-vsnip",
		opt = true,
		wants = {
			"vim-vsnip-integ",
			"flutter-snippets",
			"awesome-flutter-snippets",
			"bloc_snippets",
			"friendly-snippets",
		},
		requires = {
			{ "hrsh7th/vim-vsnip-integ", opt = true },
			{ "Nash0x7E2/awesome-flutter-snippets", opt = true },
			{ "Alexisvt/flutter-snippets", opt = true },
			{ "~/.nvim/local_plugins/bloc_snippets", opt = true }, -- local plugin
		},
	})

	-- nvim autopairs
	use({
		"windwp/nvim-autopairs",
		-- disable = true,
		event = "InsertEnter",
		config = function()
			require("config.nvim-autopairs")
		end,
	})

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("config.telescope")
		end,
		cmd = { "Telescope" },
		-- keys = { "<leader>fp", "<leader>ff", "<leader>fb", "<leader>fh", "<leader>fr" },
		event = { "bufEnter" },
		wants = {
			"trouble.nvim",
			"plenary.nvim",
			"project.nvim",
			"telescope-fzf-native.nvim",
			"telescope-frecency.nvim",
			"telescope-packer.nvim",
		},
		-- after = { "project.nvim", "telescope-fzf-native.nvim", "plenary.nvim"},
		requires = {
			-- "nvim-telescope/telescope-z.nvim",
			-- "nvim-lua/popup.nvim",
			{
				"ahmedkhalf/project.nvim",
				config = function()
					require("config.project")
				end,
				opt = true,
			},
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
			{ "nvim-telescope/telescope-frecency.nvim", requires = { "tami5/sqlite.lua" }, opt = true },
			{ "nvim-telescope/telescope-packer.nvim", opt = true },
		},
	})

	-- nvim-tree
	use({
		"kyazdani42/nvim-tree.lua",
		keys = { "<leader>nn", "<leader>nf" },
		cmd = { "NvimTreeToogle", "NvimTreeFocus" },
		wants = { "nvim-web-devicons" },
		config = function()
			require("config.nvim-tree")
		end,
	})

	-- plenary
	use({ "nvim-lua/plenary.nvim", opt = true })

	-- toggleterm
	use({
		"akinsho/nvim-toggleterm.lua",
		-- keys = "<leader>tt",
		config = function()
			require("config.toggleterm")
		end,
	})

	-- chezmoi.vim (vimrc)
	use({ "alker0/chezmoi.vim" })

	-- tokyonight
	use({
		"folke/tokyonight.nvim",
		disable = true,
		-- event = "bufEnter",
		-- wants = "nvim-treesitter",
		config = function()
			require("config.tokyonight")
		end,
	})

	-- rose-pine
	use({
		"rose-pine/neovim",
		-- disable = true,
		config = function()
			require("config.rose-pine")
		end,
	})

	-- nebulous
	use({
		"Yagua/nebulous.nvim",
		disable = true,
		event = "bufEnter",
		after = "nvim-treesitter",
		config = function()
			require("config.nebulous")
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	})

	-- material
	use({
		"marko-cerovac/material.nvim",
		disable = true,
		after = "nvim-treesitter",
		config = function()
			require("config.material")
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	})

	-- nightfly
	use({
		"bluz71/vim-nightfly-guicolors",
		disable = true, -- event = "bufEnter",
		after = "nvim-treesitter",
		config = function()
			require("config.nightfly")
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	})

	-- moonlight
	use({
		"shaunsingh/moonlight.nvim",
		disable = true, -- event = "bufEnter",
		after = "nvim-treesitter",
		config = function()
			require("config.moonlight")
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	})

	-- blue-moon
	use({
		"kyazdani42/blue-moon",
		disable = true,
		config = function()
			vim.cmd("colorscheme blue-moon")
			vim.cmd("highlight Normal guibg=None")
		end,
	})

	-- gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		wants = "plenary.nvim",
		config = function()
			require("config.gitsigns")
		end,
	})

	-- neogit
	use({
		"TimUntersberger/neogit",
		event = "BufReadPost",
		wants = "plenary.nvim",
		config = function()
			require("config.neogit")
		end,
	})

	-- hop
	use({
		"phaazon/hop.nvim", -- disable = true,
		keys = { "s", "S", "gl", "gL", { "v", "s" }, { "v", "gl" } },
		cmd = { "HopLineAC", "HopLineBC", "HopChar1AC", "HopChar1BC" },
		config = function()
			require("config.hop")
		end,
	})

	-- lightspeed
	use({
		"ggandor/lightspeed.nvim", -- disable = true,
		config = function()
			require("config.lightspeed")
		end,
	})

	-- diffview
	use({
		"sindrets/diffview.nvim",
		event = "BufEnter",
		config = function()
			require("config.diffview")
		end,
	})

	-- indent-blankline
	use({
		"lukas-reineke/indent-blankline.nvim",
		disable = true, -- event = "BufEnter",
		-- wants = "tokyonight.nvim",
		config = function()
			require("config.blankline")
		end,
	})

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate", -- event = "BufRead",
		-- wants = {
		--   "playground",
		--   "nvim-treesitter-textobjects",
		--   "nvim-treesitter-refactor",
		--   "nvim-ts-context-commentstring",
		--   "nvim-ts-rainbow",
		-- },
		requires = {
			{ "nvim-treesitter/playground" },
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
			{ "nvim-treesitter/nvim-treesitter-refactor" },
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{
				"romgrk/nvim-treesitter-context",
				config = function()
					vim.cmd("hi TreesitterContext guibg=#292e42")
				end,
			},
			{ "p00f/nvim-ts-rainbow" },
		},
		config = function()
			require("config.treesitter")
		end,
	})

	-- zen-mode
	use({
		"folke/zen-mode.nvim",
		keys = "<leader>zz", -- wants = "twilight.nvim",
		config = function()
			require("config.zen-mode")
		end,
	})

	-- twilight
	use({
		"folke/twilight.nvim",
		disable = true,
		keys = "<leader>zt",
		wants = "nvim-treesitter",
		config = function()
			require("config.twilight")
		end,
	})

	-- nvim_context_vt
	use({ "haringsrob/nvim_context_vt", after = "nvim-treesitter" })

	-- galaxyline
	use({
		"NTBBloodbath/galaxyline.nvim",
		event = "bufEnter", -- disable = true,
		wants = { "nvim-web-devicons" },
		config = function()
			require("galaxyline.my_theme")
		end,
	})

	-- feline
	use({
		"famiu/feline.nvim",
		disable = true,
		config = function()
			require("config.feline")
		end,
	})

	-- nvim-web-devicons
	use({ "kyazdani42/nvim-web-devicons" })

	-- buffer-line
	use({
		"akinsho/nvim-bufferline.lua",
		event = "BufReadPre",
		wants = { "nvim-web-devicons" },
		config = function()
			require("config.bufferline")
		end,
	})

	-- bufdelete
	use("famiu/bufdelete.nvim")

	-- bufresize
	use({
		"kwkarlwang/bufresize.nvim",
		disable = true,
		config = function()
			local opts = { noremap = true, silent = true }
			require("bufresize").setup({
				register = {
					keys = {
						{ "n", "<C-w><", "<C-w><", opts },
						{ "n", "<C-w>>", "<C-w>>", opts },
						{ "n", "<C-w>+", "<C-w>+", opts },
						{ "n", "<C-w>-", "<C-w>-", opts },
						{ "n", "<C-w>_", "<C-w>_", opts },
						{ "n", "<C-w>=", "<C-w>=", opts },
						{ "n", "<C-w>|", "<C-w>|", opts },
					},
					trigger_events = { "BufWinEnter", "WinEnter" },
				},
				resize = { keys = {}, trigger_events = { "VimResized" } },
			})
		end,
	})

	-- dashboard
	use({
		"glepnir/dashboard-nvim", -- disable = true,
		disable = true,
		event = "VimEnter",
		after = "telescope.nvim",
		config = function()
			require("config.dashboard")
		end,
		requires = "nvim-telescope/telescope.nvim",
	})

	-- firenvim
	use({
		"glacambre/firenvim",
		disable = true,
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})

	-- neoscroll
	use({
		"karb94/neoscroll.nvim",
		disable = true,
		keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
		config = function()
			require("config.neoscroll")
		end,
	})

	-- which-key
	use({
		"folke/which-key.nvim", -- disable = true,
		-- disable = true,
		-- event = "VimEnter",
		config = function()
			require("config.which-key")
		end,
	})

	-- scrollview
	use({
		"dstein64/nvim-scrollview",
		event = "bufRead",
		config = function()
			require("config.scrollview")
		end,
	})

	-- nvim-comment
	use({
		"terrortylor/nvim-comment",
		disable = true,
		keys = { { "n", "gcc" }, { "v", "gc" }, { "o", "gc" } },
		wants = { "nvim-treesitter" },
		config = function()
			require("config.nvim-comment")
		end,
	})

	-- kommentary
	use({ "b3nj5m1n/kommentary", disable = true })

	-- vim-commentary (vimscript)
	use("tpope/vim-commentary")

	-- flutter-tools
	use({
		"akinsho/flutter-tools.nvim",
		ft = { "flutter", "dart" },
		wants = "plenary.nvim",
		config = function()
			require("config.flutter-tools")
		end,
	})

	-- lspsaga
	use({
		"tami5/lspsaga.nvim",
		event = "bufRead",
		disable = true,
		wants = { "nvim-lspconfig" },
		config = function()
			require("config.lspsaga")
		end,
	})

	-- lsp signagure
	use({
		"ray-x/lsp_signature.nvim",
		event = "bufRead",
		config = function()
			require("config.lsp-signature")
		end,
	})

	-- nvim colorizer
	use({
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("config.colorizer")
		end,
	})

	-- trouble
	use({
		"folke/trouble.nvim", -- keys = {
		--   "<leader>xx",
		--   "<leader>xw",
		--   "<leader>xd",
		--   "<leader>xl",
		--   "<leader>xq",
		--   "gR",
		--   "gD",
		-- },
		-- event = "BufEnter",
		wants = "nvim-web-devicons",
		config = function()
			require("config.trouble")
		end,
	})

	-- formatter
	use({
		"mhartington/formatter.nvim",
		cmd = { "Format", "FormatWrite" },
		ft = { "dart", "lua" },
		config = function()
			require("config.formatter")
		end,
	})

	-- persistence
	-- Lua
	use({
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		keys = { "<leader>qs", "<leader>ql", "<leader>qd" },
		module = "persistence",
		config = function()
			require("config.persistence")
		end,
	})

	-- lspconfig
	use({
		"neovim/nvim-lspconfig", -- event = "BufReadPre",
		requires = { "kabouzeid/nvim-lspinstall", "onsails/lspkind-nvim", { "folke/lua-dev.nvim" } },
		config = function()
			require("config.lsp")
		end,
	})

	use({
		"kosayoda/nvim-lightbulb",
		config = function()
			require("config.nvim-lightbulb")
		end,
	})

	-- vim unimpaired (vimscript)
	use({ "tpope/vim-unimpaired", event = "bufEnter" })
	use({ "tpope/vim-surround", event = "bufRead" })

	-- vim repeat (vimscript)
	use({ "tpope/vim-repeat", event = "bufEnter" })

	-- vim-mundo (vimscript)
	use({
		"simnalamburt/vim-mundo",
		keys = "<leader>vm",
		config = function()
			vim.g.mundo_preview_bottom = 1
			vim.api.nvim_set_keymap("n", "<leader>vm", ":MundoToggle<cr>", { noremap = true, silent = true })
		end,
	})

	-- vim-maximizer (vimscript)
	use({
		"szw/vim-maximizer",
		keys = { "<leader>m", { "v", "<leader>m" } },
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>m", ":MaximizerToggle!<cr>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("v", "<leader>m", ":MaximizerToggle!<cr>gv", { noremap = true, silent = true })
		end,
	})

	-- target vim (vimscript)
	use({ "wellle/targets.vim" })
end),
	vim.cmd([[
augroup Plugin 
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup END
]]),
		-- mappings
	-- packer mappings
require("which-key").register({
		["<leader>p"] = {
			name = "+Packer",
			s = { "<cmd>PackerSync<cr>", "Packer: Sync" },
			S = { "<cmd>PackerStatus<cr>", "Packer: Status" },
			c = { "<cmd>PackerClean<cr>", "Packer: Clean" },
		},
	})

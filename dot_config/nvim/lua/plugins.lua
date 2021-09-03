return require( 'packer' ).startup(
         function( use )
    -- packer
    use 'wbthomason/packer.nvim'

    -- nvim-cmp
    use(
      {
        "hrsh7th/nvim-cmp",
        disable = false,
        event = "InsertEnter",
        wants = { "vim-vsnip", "LuaSnip", "nvim-autopairs" },
        config = function()
          require( "config.cmp" )
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
      }
     )

    -- coq_nvim
    use { 'ms-jpq/coq_nvim', branch = 'coq', disable = true } -- main one
    use { 'ms-jpq/coq.artifacts', branch = 'artifacts', disable = true } -- 9000+ Snippets

    -- friendly snippet (collection)
    use( { "rafamadriz/friendly-snippets", opt = true } )

    -- LuaSnip
    use( { "L3MON4D3/LuaSnip", opt = true, wants = "friendly-snippets" } )

    -- vim-vsnip
    use(
      {
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
          { "Neevash/awesome-flutter-snippets", opt = true },
          { "Alexisvt/flutter-snippets", opt = true },
          { "~/.nvim/local_plugins/bloc_snippets", opt = true }, -- local plugin
        },
      }
     )

    -- nvim autopairs
    use(
      {
        "windwp/nvim-autopairs",
        event = "VimEnter",
        config = function()
          require( "config.nvim-autopairs" )
        end,
      }
     )

    -- telescope
    use(
      {
        "nvim-telescope/telescope.nvim",
        config = function()
          require( "config.telescope" )
        end,
        cmd = { "Telescope" },
        keys = {
          "<leader>fp",
          "<leader>ff",
          "<leader>fg",
          "<leader>fb",
          "<leader>fh",
          "<leader>fr",
        },
        wants = {
          "trouble.nvim",
          "plenary.nvim",
          "project.nvim",
          "telescope-fzf-native.nvim",
        },
        -- after = { "project.nvim", "telescope-fzf-native.nvim", "plenary.nvim"},
        requires = {
          -- "nvim-telescope/telescope-z.nvim",
          -- "nvim-lua/popup.nvim",
          {
            "ahmedkhalf/project.nvim",
            config = function()
              require( "config.project" )
            end,
            opt = true,
          },
          { "nvim-telescope/telescope-fzf-native.nvim", run = "make",
            opt = true },
        },
      }
     )

    -- nvim-tree
    use(
      {
        "kyazdani42/nvim-tree.lua",
        keys = { "<leader>nn", "<leader>nf" },
        cmd = { "NvimTreeToogle", "NvimTreeFocus" },
        wants = { "nvim-web-devicons" },
        config = function()
          require( "config.nvim-tree" )
        end,
      }
     )

    -- plenary
    use( { "nvim-lua/plenary.nvim", opt = true } )

    -- toggleterm
    use(
      {
        "akinsho/nvim-toggleterm.lua",
        keys = "<leader>tt",
        config = function()
          require( "config.toggleterm" )
        end,
      }
     )

    -- tokyonight
    use(
      {
        'folke/tokyonight.nvim',
        disable = false,
        event = "bufEnter",
        wants = "nvim-treesitter",
        config = function()
          require( 'config.tokyonight' )
        end,
      }
     )

    -- nebulous
    use(
      {
        "Yagua/nebulous.nvim",
        disable = true,
        event = "bufEnter",
        after = "nvim-treesitter",
        config = function()
          require( "config.nebulous" )
        end,
        requires = "nvim-treesitter/nvim-treesitter",
        -- gitsigns
      }
     )

    -- material
    use(
      {
        "marko-cerovac/material.nvim",
        disable = true,
        event = "bufEnter",
        after = "nvim-treesitter",
        config = function()
          require( "config.material" )
        end,
        requires = "nvim-treesitter/nvim-treesitter",
        -- gitsigns
      }
     )

    -- nightfly
    use(
      {
        "bluz71/vim-nightfly-guicolors",
        disable = true,
        event = "bufEnter",
        after = "nvim-treesitter",
        config = function()
          require( "config.nightfly" )
        end,
        requires = "nvim-treesitter/nvim-treesitter",
        -- gitsigns
      }
     )

    -- moonlight
    use(
      {
        "shaunsingh/moonlight.nvim",
        disable = true,
        event = "bufEnter",
        after = "nvim-treesitter",
        config = function()
          require( "config.moonlight" )
        end,
        requires = "nvim-treesitter/nvim-treesitter",
        -- gitsigns
      }
     )

    -- gitsigns
    use(
      {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        wants = "plenary.nvim",
        config = function()
          require( "config.gitsigns" )
        end,
      }
     )

    -- hop
    use(
      {
        "phaazon/hop.nvim",
        keys = { "s", "S", "gl", "gL", { "v", "s" }, { "v", "gl" } },
        cmd = { "HopLineAC", "HopLineBC", "HopChar1AC", "HopChar1BC" },
        config = function()
          require( "config.hop" )
        end,
      }
     )

    -- diffview
    use(
      {
        "sindrets/diffview.nvim",
        cmd = {
          "DiffviewOpen",
          "DiffviewClose",
          "DiffviewToggleFiles",
          "DiffviewFocusFiles",
        },
        config = function()
          require( "config.diffview" )
        end,
      }
     )

    -- indent-blankline
    use(
      {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
          require( "config.blankline" )
        end,
      }
     )

    -- treesitter
    use(
      {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        event = "BufRead",
        wants = {
          "playground",
          "nvim-treesitter-textobjects",
          "nvim-treesitter-refactor",
          "nvim-ts-context-commentstring",
          "nvim-ts-rainbow",
        },
        requires = {
          { "nvim-treesitter/playground", opt = true },
          { "nvim-treesitter/nvim-treesitter-textobjects", opt = true },
          { "nvim-treesitter/nvim-treesitter-refactor", opt = true },
          { "JoosepAlviste/nvim-ts-context-commentstring", opt = true },
          { "p00f/nvim-ts-rainbow", opt = true },
        },
        config = function()
          require( 'config.treesitter' )
        end,
      }
     )

    -- zen-mode
    use(
      {
        "folke/zen-mode.nvim",
        keys = "<leader>zz",
        -- wants = "twilight.nvim",
        config = function()
          require( "config.zen-mode" )
        end,
      }
     )

    -- twilight
    use(
      {
        "folke/twilight.nvim",
        disable = true,
        keys = "<leader>zt",
        wants = "nvim-treesitter",
        config = function()
          require( "config.twilight" )
        end,

      }
     )

    -- nvim_context_vt
    use( { "haringsrob/nvim_context_vt", after = "nvim-treesitter" } )

    -- galaxyline
    use(
      {
        "glepnir/galaxyline.nvim",
        branch = 'main',
        event = "bufEnter",
        config = function()
          require( "galaxyline.my_theme" )
        end,
        wants = { "nvim-web-devicons" },
      }
     )

    -- nvim-web-devicons
    use( { "kyazdani42/nvim-web-devicons", opt = true } )

    -- buffer-line
    use(
      {
        "akinsho/nvim-bufferline.lua",
        event = "BufReadPre",
        wants = { "nvim-web-devicons" },
        config = function()
          require( "config.bufferline" )
        end,
      }
     )

    -- dashboard
    use(
      {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        after = "telescope.nvim",
        config = function()
          require( "config.dashboard" )
        end,
        requires = "nvim-telescope/telescope.nvim",
      }
     )

    -- neoscroll
    use(
      {
        "karb94/neoscroll.nvim",
        keys = {
          '<C-u>',
          '<C-d>',
          '<C-b>',
          '<C-f>',
          '<C-y>',
          '<C-e>',
          'zt',
          'zz',
          'zb',
        },
        config = function()
          require( "config.neoscroll" )
        end,
      }
     )

    -- which-key
    use(
      {
        "folke/which-key.nvim",
        event = "VimEnter",
        config = function()
          require( "config.which-key" )
        end,
      }
     )

    -- scrollview
    use(
      {
        "dstein64/nvim-scrollview",
        event = "bufRead",
        config = function()
          require( "config.scrollview" )
        end,
      }
     )

    -- nvim-comment
    use(
      {
        "terrortylor/nvim-comment",
        keys = { { 'n', 'gcc' }, { 'v', 'gc' }, { 'o', 'gc' } },
        config = function()
          require( "config.nvim-comment" )
        end,
      }
     )

    -- flutter-tools
    use(
      {
        "akinsho/flutter-tools.nvim",
        ft = { "flutter", "dart" },
        wants = "plenary.nvim",
        config = function()
          require( "config.flutter-tools" )
        end,
      }
     )

    -- lspsaga
    use(
      {
        "jasonrhansen/lspsaga.nvim",
        branch = "finder-preview-fixes",
        event = "bufRead",
        wants = { "nvim-lspconfig" },
        config = function()
          require( "config.lspsaga" )
        end,
      }
     )

    -- lsp signagure
    use(
      {
        "ray-x/lsp_signature.nvim",
        event = "bufRead",
        config = function()
          require( "config.lsp-signature" )
        end,
      }
     )

    -- nvim colorizer
    use(
      {
        "norcalli/nvim-colorizer.lua",
        event = "bufRead",
        config = function()
          require( "config.colorizer" )
        end,
      }
     )

    -- trouble
    use(
      {
        "folke/trouble.nvim",
        keys = {
          "<leader>xx",
          "<leader>xw",
          "<leader>xd",
          "<leader>xl",
          "<leader>xq",
          "gR",
          "gD",
        },
        event = "BufReadPre",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
          require( "config.trouble" )
        end,
      }
     )

    -- formatter
    use(
      {
        "mhartington/formatter.nvim",
        cmd = { "Format", "FormatWrite" },
        ft = { "dart", "lua" },
        config = function()
          require( "config.formatter" )
        end,
      }
     )

    -- persistence
    -- Lua
    use(
      {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        keys = { "<leader>qs", "<leader>ql", "<leader>qd" },
        module = "persistence",
        config = function()
          require( "config.persistence" )
        end,
      }
     )

    -- lspconfig
    use(
      {
        "neovim/nvim-lspconfig",
        -- event = "BufReadPre",
        wants = "lua-dev.nvim",
        requires = {
          "kabouzeid/nvim-lspinstall",
          "onsails/lspkind-nvim",
          { "folke/lua-dev.nvim", opt = true },
        },
        config = function()
          require( "config.lsp" )
        end,
      }
     )

    -- vim unimpaired (vimscript)
    use( { "tpope/vim-unimpaired", event = "bufEnter" } )
    use( { "tpope/vim-surround", event = "bufRead" } )

    -- vim repeat (vimscript)
    use( { "tpope/vim-repeat", event = "bufEnter" } )

    -- vim-mundo (vimscript)
    use(
      {
        "simnalamburt/vim-mundo",
        keys = "<leader>vm",
        config = function()
          vim.g.mundo_preview_bottom = 1
          vim.api.nvim_set_keymap(
            "n", "<leader>vm", ":MundoToggle<cr>",
            { noremap = true, silent = true }
           )
        end,
      }
     )

    -- vim-maximizer (vimscript)
    use(
      {
        "szw/vim-maximizer",
        keys = { "<leader>m", { "v", "<leader>m" } },
        config = function()
          vim.api.nvim_set_keymap(
            "n", "<leader>m", ":MaximizerToggle!<cr>",
            { noremap = true, silent = true }
           )
          vim.api.nvim_set_keymap(
            "v", "<leader>m", ":MaximizerToggle!<cr>gv",
            { noremap = true, silent = true }
           )
        end,
      }
     )

  end

        ), vim.cmd(
         [[
augroup Plugin 
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup END
]]
        ), -- mappings
vim.api.nvim_set_keymap(
         "n", "<leader>ps", ":PackerSync<cr>", { noremap = true, silent = true }
        ), vim.api.nvim_set_keymap(
         "n", "<leader>pS", ":PackerStatus<cr>",
         { noremap = true, silent = true }
        )

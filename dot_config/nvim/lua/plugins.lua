return require('packer').startup(
function(use)
  -- packer
  use 'wbthomason/packer.nvim'

  -- nvim-compe
  use({
    "hrsh7th/nvim-cmp",
    -- event = "InsertEnter",
    config = function()
      require("config.cmp")
    end,
    after = {"vim-vsnip", "LuaSnip"},
    requires = {
      {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        -- event = "bufRead",
      --   -- wants = "friendly-snippets",
      --   -- config = function()
      --   --   require("config.snippets")
      --   -- end,
      },
    {
        "hrsh7th/vim-vsnip",
        event = "InsertEnter",
        -- event = "bufRead",
        requires = {
            {"hrsh7th/vim-vsnip-integ", event = "bufRead"},
            {"Neevash/awesome-flutter-snippets", event = "bufRead"},
            {"Alexisvt/flutter-snippets", event = "bufRead"},
        },
    },
    { "hrsh7th/cmp-buffer", after = "nvim-cmp", },
    { "hrsh7th/cmp-path", after = "nvim-cmp", },
    { "hrsh7th/cmp-vsnip", after = "nvim-cmp", },
    { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp", },
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", },
    { "hrsh7th/cmp-calc", after = "nvim-cmp", },
    { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp", },

    },
  })

  -- telescope
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope")
    end,
    cmd = { "Telescope" },
    keys = { "<leader>fp", "<leader>ff", "<leader>fg", "<leader>fb", "<leader>fh", "<leader>fr"},
    after = { "project.nvim", "telescope-fzf-native.nvim"},
    requires = {
      -- "nvim-telescope/telescope-z.nvim",
      -- "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      {"ahmedkhalf/project.nvim", config = function() require("config.project") end},
      {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
    },
  })

-- toggleterm
  use({
    "akinsho/nvim-toggleterm.lua",
    keys = "<leader>tt",
    config = function()
      require("config.toggleterm")
    end,
  })

  -- tokyonight
  use ({
    'folke/tokyonight.nvim',
    disable = true,
    event = "bufEnter",
    after = "nvim-treesitter",
    config = function ()
        require('config.tokyonight')
    end,
    requires = "nvim-treesitter/nvim-treesitter",
})

  -- nebulous
    use({
        "Yagua/nebulous.nvim",
        disable = true,
        event = "bufEnter",
        after = "nvim-treesitter",
        config = function ()
            require("config.nebulous")
        end,
        requires = "nvim-treesitter/nvim-treesitter",
        -- gitsigns
    })

  -- nightfly
    use({
        "bluz71/vim-nightfly-guicolors",
        disable = true,
        event = "bufEnter",
        after = "nvim-treesitter",
        config = function ()
            require("config.nightfly")
        end,
        requires = "nvim-treesitter/nvim-treesitter",
        -- gitsigns
    })

-- moonlight
  use({
      "shaunsingh/moonlight.nvim",
      disable = false,
      event = "bufEnter",
      after = "nvim-treesitter",
      config = function ()
          require("config.moonlight")
      end,
      requires = "nvim-treesitter/nvim-treesitter",
      -- gitsigns
  })


  -- gitsigns
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns")
    end,
  })

  -- hop
  use({
    "phaazon/hop.nvim",
    keys = {"s", "S", "gl", "gL", { "v", "s" }, {"v", "gl"}},
    cmd = { "HopLineAC", "HopLineBC", "HopChar1AC", "HopChar1BC" },
    config = function()
      require("config.hop")
    end,
  })

  --diffview
  use({
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      require("config.diffview")
    end,
  })

  -- indent-blankline
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("config.blankline")
    end,
  })

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    --event = "BufReadPre",
    --after = {
        --"playground",
        --"nvim-treesitter-textobjects",
        --"nvim-treesitter-refactor",
        --"nvim-ts-context-commentstring",
        --"nvim-ts-rainbow"
    --},
    -- opt = true,
    -- event = "BufRead",
    requires = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-refactor",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "p00f/nvim-ts-rainbow",
    },
    config = function()
        require('config.treesitter')
    end,
  })

  -- galaxyline
  use ({
  "glepnir/galaxyline.nvim",
  branch = 'main',
  config = function()
      require("galaxyline.my_theme")
  end,
  requires = {"kyazdani42/nvim-web-devicons", opt = true}
  })

  -- buffer-line
  use ({
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      config = function ()
          require("config.bufferline")
      end
  })

  -- dashboard
  use ({
      "glepnir/dashboard-nvim",
      event = "VimEnter",
      after = "telescope.nvim",
      config = function ()
          require("config.dashboard")
      end,
      requires = "nvim-telescope/telescope.nvim",
  })

  -- neoscroll
  use ({
      "karb94/neoscroll.nvim",
      keys = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
      config = function ()
          require("config.neoscroll")
      end
  })

  -- registers
  use ({
    "tversteeg/registers.nvim",
    config = function()
        require("config.registers")
    end,
    keys = { { 'n', '"' }, { 'v', '"' }, { 'i', '<c-r>' } },
  })

  -- scrollview
  use ({
      "dstein64/nvim-scrollview",
      event = "bufRead",
      config = function()
          require("config.scrollview")
      end,
  })

  -- nvim-comment
  use ({
      "terrortylor/nvim-comment",
      keys = { { 'n', 'gcc' }, { 'v', 'gc' }, { 'o', 'gc' } },
      config = function()
          require("config.nvim-comment")
      end,
  })

  -- flutter-tools
  use({
      "akinsho/flutter-tools.nvim",
      ft = { "flutter", "dart" },
      config = function()
          require("config.flutter-tools")
      end,
  })

  -- lspsaga
  use({
      "jasonrhansen/lspsaga.nvim",
      branch = "finder-preview-fixes",
      after = { "nvim-lspconfig" },
      config = function()
          require("config.lspsaga")
      end,
  })

  -- lspconfig
  use({
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    requires = { "kabouzeid/nvim-lspinstall" },
    config = function()
      require("config.lsp")
    end,
  })

end),

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

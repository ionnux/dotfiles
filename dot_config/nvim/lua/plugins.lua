
return require('packer').startup(
function(use)
  -- packer
  use 'wbthomason/packer.nvim'

  -- nvim-compe
  use({
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("config.compe")
    end,
    requires = {
      {
        "L3MON4D3/LuaSnip",
        -- wants = "friendly-snippets",
        -- config = function()
        --   require("config.snippets")
        -- end,
      },
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
    -- wants = {
    --   "plenary.nvim",
    --   "popup.nvim",
    --   "telescope-z.nvim",
    --   -- "telescope-frecency.nvim",
    --   "telescope-fzy-native.nvim",
    --   "telescope-project.nvim",
    --   "trouble.nvim",
    --   "telescope-symbols.nvim",
    -- },
    requires = {
      -- "nvim-telescope/telescope-z.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      {"ahmedkhalf/project.nvim", config = function() require("config.project") end},
      "nvim-telescope/telescope-fzy-native.nvim",
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
    event = "VimEnter",
    config = function ()
        require('config.tokyonight')
    end,
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
    keys = {"s", "S", "gl", "gL"},
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
    -- opt = true,
    -- event = "BufRead",
    requires = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-refactor",
      "RRethy/nvim-treesitter-textsubjects",
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
      event = "BufRead",
      requires = { "neovim/nvim-lspconfig" },
      config = function()
          require("config.lspsaga")
      end,
  })

  use({
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require("config.lsp")
    end,
  })

end),

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

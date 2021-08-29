
return require('packer').startup(
function(use)
  use 'wbthomason/packer.nvim'

  -- nvim-compe
  use({
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    opt = true,
    config = function()
      require("config.compe")
    end,
    wants = { "LuaSnip" },
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
    opt = true,
    config = function()
      require("config.telescope")
    end,
    cmd = { "Telescope" },
    module = "telescope",
    keys = { "<leader><space>", "<leader>fz", "<leader>pp" },
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
      "nvim-telescope/telescope-project.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      -- { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sql.nvim" }
    },
  })

-- toggleterm
  use({
    "akinsho/nvim-toggleterm.lua",
    opt = true,
    keys = "<leader>tt",
    config = function()
      require("config.toggleterm")
    end,
  })

  -- tokyonight
  use ({
    'folke/tokyonight.nvim',
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


end),

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

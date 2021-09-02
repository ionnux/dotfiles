return require('packer').startup(
function(use)
  -- packer
  use 'wbthomason/packer.nvim'

  -- nvim-compe
  use({
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("config.cmp")
    end,
    --after = {"vim-vsnip", "LuaSnip"},
    requires = {
    { "hrsh7th/cmp-buffer", after = "nvim-cmp", },
    { "hrsh7th/cmp-path", after = "nvim-cmp", },
    { "hrsh7th/cmp-vsnip", after = "nvim-cmp", },
    { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp", },
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", },
    { "hrsh7th/cmp-calc", after = "nvim-cmp", },
    { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp", },

    },
  })

  -- LuaSnip
  use ({
      "L3MON4D3/LuaSnip",
      after = "nvim-cmp",
  })

  -- vim-vsnip
  use ({
    "hrsh7th/vim-vsnip",
    after = "nvim-cmp",
    requires = {
        {"hrsh7th/vim-vsnip-integ", after = "vim-vsnip"},
        { "hrsh7th/cmp-vsnip", after = {"nvim-cmp", "vim-vsnip"}, },
        {"Neevash/awesome-flutter-snippets", after = "vim-vsnip"},
        {"Alexisvt/flutter-snippets", after = "vim-vsnip"},
        {"~/.nvim/local_plugins/bloc_snippets", after = "vim-vsnip"} -- local plugin
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
    after = { "project.nvim", "telescope-fzf-native.nvim", "trouble.nvim", "plenary.nvim"},
    requires = {
      -- "nvim-telescope/telescope-z.nvim",
      -- "nvim-lua/popup.nvim",
      {"nvim-lua/plenary.nvim"},
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
    disable = false,
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

  -- material
    use({
        "marko-cerovac/material.nvim",
        disable = true,
        event = "bufEnter",
        after = "nvim-treesitter",
        config = function ()
            require("config.material")
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
      disable = true,
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
  event = "bufEnter",
  config = function()
      require("galaxyline.my_theme")
  end,
  requires = {"kyazdani42/nvim-web-devicons"}
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

 use {
  "folke/trouble.nvim",
  keys = { "<leader>xx", "<leader>xw", "<leader>xd", "<leader>xl", "<leader>xq", "gR", "gD" },
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("config.trouble")
  end
}

  -- lspconfig
  use({
    "neovim/nvim-lspconfig",
    -- event = "VimEnter",
    requires = { "kabouzeid/nvim-lspinstall" },
    config = function()
      require("config.lsp")
    end,
  })

end),

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

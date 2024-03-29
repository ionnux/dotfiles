return require('packer').startup(function(use)
  -- packer
  use('wbthomason/packer.nvim')

  -- nvim-cmp
  use({
    'hrsh7th/nvim-cmp',
    config = function()
      require('config.cmp')
    end,
    after = { 'nvim-autopairs', 'LuaSnip', 'lspkind-nvim' },
    requires = {
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'mtoohey31/cmp-fish', ft = 'fish', after = 'nvim-cmp' },
      { 'onsails/lspkind-nvim' },
    },
  })

  -- Use <Tab> to escape from pairs such as ""|''|() etc.
  -- use({
  --   'abecodes/tabout.nvim',
  --   wants = { 'nvim-treesitter' },
  --   -- after = { 'nvim-cmp' },
  --   config = function()
  --     require('config.tabout')
  --   end,
  -- })

  -- LuaSnip
  use({
    'L3MON4D3/LuaSnip',
    tag = 'v<CurrentMajor>.*',
    config = function()
      require('config.luasnip')
    end,
    requires = { 'rafamadriz/friendly-snippets', opts = true },
  })

  -- vim-vsnip
  use({
    'hrsh7th/vim-vsnip',
    opt = true,
    disable = true,
    wants = {
      'vim-vsnip-integ',
      'flutter-snippets',
      'awesome-flutter-snippets',
      'bloc_snippets',
      'friendly-snippets',
    },
    requires = {
      { 'hrsh7th/vim-vsnip-integ', opt = true },
      { 'Nash0x7E2/awesome-flutter-snippets', opt = true },
      { 'Alexisvt/flutter-snippets', opt = true },
      { '~/.nvim/local_plugins/bloc_snippets', opt = true }, -- local plugin
    },
  })

  -- nvim autopairs
  use({
    'windwp/nvim-autopairs',
    config = function()
      require('config.nvim-autopairs')
    end,
  })

  -- telescope
  use({
    'nvim-telescope/telescope.nvim',
    config = function()
      require('config.telescope')
    end,
    cmd = { 'Telescope' },
    -- keys = { "<leader>fp", "<leader>ff", "<leader>fb", "<leader>fh", "<leader>fr" },
    event = { 'bufEnter' },
    wants = {
      'trouble.nvim',
      'project.nvim',
      'telescope-fzf-native.nvim',
      'telescope-frecency.nvim',
      'telescope-packer.nvim',
    },
    -- after = { "project.nvim", "telescope-fzf-native.nvim", "plenary.nvim"},
    requires = {
      -- "nvim-telescope/telescope-z.nvim",
      -- "nvim-lua/popup.nvim",
      {
        'ahmedkhalf/project.nvim',
        config = function()
          require('config.project')
        end,
        opt = true,
      },
      { 'nvim-telescope/telescope-frecency.nvim', requires = { 'tami5/sqlite.lua' }, opt = true },
      { 'nvim-telescope/telescope-packer.nvim', opt = true },
    },
  })

  use({
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  })

  -- nvim-tree
  use({
    'kyazdani42/nvim-tree.lua',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opts = true }, -- optional, for file icons
    },
    tag = 'nightly',
    config = function()
      require('config.nvim-tree')
    end,
  })

  -- plenary
  use({ 'nvim-lua/plenary.nvim' })

  -- toggleterm
  use({
    'akinsho/nvim-toggleterm.lua',
    -- keys = "<leader>tt",
    config = function()
      require('config.toggleterm')
    end,
  })

  -- chezmoi.vim (vimrc)
  use({ 'alker0/chezmoi.vim' })

  -- tokyonight
  use({
    'folke/tokyonight.nvim',
    -- disable = true,
    -- event = "bufEnter",
    -- wants = "nvim-treesitter",
    config = function()
      require('config.tokyonight')
    end,
  })

  -- nightfox
  use({
    'EdenEast/nightfox.nvim',
    disable = true,
    config = function()
      require('config.nightfox')
    end,
  })

  -- pinkmare
  use({
    'matsuuu/pinkmare',
    disable = true,
    config = function()
      require('config.pinkmare')
    end,
  })

  -- rose-pine
  use({
    'rose-pine/neovim',
    disable = true,
    config = function()
      require('config.rose-pine')
    end,
  })

  -- nebulous
  use({
    'Yagua/nebulous.nvim',
    disable = true,
    event = 'bufEnter',
    after = 'nvim-treesitter',
    config = function()
      require('config.nebulous')
    end,
    requires = 'nvim-treesitter/nvim-treesitter',
  })

  -- material
  use({
    'marko-cerovac/material.nvim',
    disable = true,
    after = 'nvim-treesitter',
    config = function()
      require('config.material')
    end,
    requires = 'nvim-treesitter/nvim-treesitter',
  })

  -- nightfly
  use({
    'bluz71/vim-nightfly-guicolors',
    disable = true, -- event = "bufEnter",
    after = 'nvim-treesitter',
    config = function()
      require('config.nightfly')
    end,
    requires = 'nvim-treesitter/nvim-treesitter',
  })

  -- moonlight
  use({
    'shaunsingh/moonlight.nvim',
    disable = true, -- event = "bufEnter",
    after = 'nvim-treesitter',
    config = function()
      require('config.moonlight')
    end,
    requires = 'nvim-treesitter/nvim-treesitter',
  })

  -- blue-moon
  use({
    'kyazdani42/blue-moon',
    disable = true,
    config = function()
      vim.cmd('colorscheme blue-moon')
      vim.cmd('highlight Normal guibg=None')
    end,
  })

  -- gitsigns
  use({
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = function()
      require('config.gitsigns')
    end,
  })

  -- neogit
  use({
    'TimUntersberger/neogit',
    event = 'BufReadPost',
    config = function()
      require('config.neogit')
    end,
  })

  -- hop
  use({
    'phaazon/hop.nvim', -- disable = true,
    keys = { 's', 'S', 'gl', 'gL', { 'v', 's' }, { 'v', 'gl' } },
    cmd = { 'HopLineAC', 'HopLineBC', 'HopChar1AC', 'HopChar1BC' },
    config = function()
      require('config.hop')
    end,
  })

  -- lightspeed
  use({
    'ggandor/lightspeed.nvim', -- disable = true,
    disable = true,
    config = function()
      require('config.lightspeed')
    end,
  })

  -- diffview
  use({
    'sindrets/diffview.nvim',
    event = 'BufEnter',
    config = function()
      require('config.diffview')
    end,
  })

  -- indent-blankline
  use({
    'lukas-reineke/indent-blankline.nvim',
    -- disable = true,
    -- event = "BufEnter",
    -- wants = "tokyonight.nvim",
    config = function()
      require('config.blankline')
    end,
  })

  -- treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      { 'nvim-treesitter/playground', after = 'nvim-treesitter' },
      { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
      { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
      { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' },
      { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
    },
    config = function()
      require('config.treesitter')
    end,
  })

  -- zen-mode
  use({
    'folke/zen-mode.nvim',
    keys = '<leader>zz', -- wants = "twilight.nvim",
    config = function()
      require('config.zen-mode')
    end,
  })

  -- twilight
  use({
    'folke/twilight.nvim',
    disable = true,
    keys = '<leader>zt',
    wants = 'nvim-treesitter',
    config = function()
      require('config.twilight')
    end,
  })

  -- nvim_context_vt
  use({
    'haringsrob/nvim_context_vt',
    after = 'nvim-treesitter',
    disable = true,
  })

  -- galaxyline
  use({
    'NTBBloodbath/galaxyline.nvim',
    disable = true,
    -- event = "bufEnter", -- disable = true,
    wants = { 'nvim-web-devicons' },
    config = function()
      require('galaxyline.my_theme')
    end,
  })

  -- feline
  use({
    'famiu/feline.nvim',
    disable = true,
    config = function()
      require('config.feline')
    end,
  })

  -- nvim-web-devicons
  use({ 'kyazdani42/nvim-web-devicons' })

  -- buffer-line
  use({
    'akinsho/nvim-bufferline.lua',
    event = 'BufReadPre',
    wants = { 'nvim-web-devicons' },
    config = function()
      require('config.bufferline')
    end,
  })

  -- bufdelete
  use({
    'famiu/bufdelete.nvim',
    event = 'BufReadPre',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>bd', [[:Bdelete<cr>]], { noremap = true, silent = true })
    end,
  })

  -- bufresize
  use({
    'kwkarlwang/bufresize.nvim',
    -- disable = true,
    config = function()
      local opts = { noremap = true, silent = true }
      require('bufresize').setup({
        register = {
          -- keys = {
          -- 	{ "n", "<C-w><", "<C-w><", opts },
          -- 	{ "n", "<C-w>>", "<C-w>>", opts },
          -- 	{ "n", "<C-w>+", "<C-w>+", opts },
          -- 	{ "n", "<C-w>-", "<C-w>-", opts },
          -- 	{ "n", "<C-w>_", "<C-w>_", opts },
          -- 	{ "n", "<C-w>=", "<C-w>=", opts },
          -- 	{ "n", "<C-w>|", "<C-w>|", opts },
          -- },
          trigger_events = { 'BufWinEnter', 'WinEnter' },
        },
        resize = { keys = {}, trigger_events = { 'VimResized' } },
      })
    end,
  })

  -- dashboard
  use({
    'glepnir/dashboard-nvim', -- disable = true,
    disable = true,
    event = 'VimEnter',
    after = 'telescope.nvim',
    config = function()
      --
      require('config.dashboard')
    end,
    requires = 'nvim-telescope/telescope.nvim',
  })

  -- startup-nvim
  use({
    'startup-nvim/startup.nvim',
    disable = true,
    requires = 'nvim-telescope/telescope.nvim',
    config = function()
      require('startup').setup(require('config.startup-nvim'))
      -- require("startup").setup()
    end,
  })

  -- alpha nvim
  use({
    'goolord/alpha-nvim',
    disable = true,
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('config.alpha-nvim').opts)
    end,
  })

  -- startify
  use({
    'mhinz/vim-startify',
    config = function()
      require('config.startify')
    end,
  })

  -- firenvim
  use({
    'glacambre/firenvim',
    disable = true,
    run = function()
      vim.fn['firenvim#install'](0)
    end,
  })

  -- neoscroll
  use({
    'karb94/neoscroll.nvim',
    -- disable = true,
    keys = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
    config = function()
      require('config.neoscroll')
    end,
  })

  -- yabs
  use({
    'pianocomposer321/yabs.nvim',
    config = function()
      require('config.yabs')
    end,
  })

  -- which-key
  use({
    'folke/which-key.nvim', -- disable = true,
    -- disable = true,
    -- event = "VimEnter",
    config = function()
      require('config.which-key')
    end,
  })

  -- scrollview
  use({
    'dstein64/nvim-scrollview',
    event = 'bufRead',
    config = function()
      require('config.scrollview')
    end,
  })

  -- kommentary
  use({ 'b3nj5m1n/kommentary', disable = true })

  -- vim-commentary (vimscript)
  use({ 'tpope/vim-commentary', disable = true })

  -- comment nvim
  use({
    'numToStr/comment.nvim',
    config = function()
      require('config.comment')
    end,
  })

  -- flutter-tools
  use({
    'akinsho/flutter-tools.nvim',
    disable = true,
    ft = { 'flutter', 'dart' },
    config = function()
      require('config.flutter-tools')
    end,
  })

  -- sqls.nvim
  use({
    'nanotee/sqls.nvim',
    disable = true,
    config = function()
      require('sqls').setup({
        picker = 'telescope',
      })
    end,
    requires = 'nvim-telescope/telescope.nvim',
  })

  -- vim-dadbod (vimscript)
  use({
    'tpope/vim-dadbod',
    disable = true,
  })

  -- lspsaga
  use({
    'tami5/lspsaga.nvim',
    event = 'bufRead',
    disable = true,
    wants = { 'nvim-lspconfig' },
    config = function()
      require('config.lspsaga')
    end,
  })

  -- nvim-code-action-menu
  use({
    'weilbith/nvim-code-action-menu',
    -- cmd = "CodeActionMenu",
    disabled = true,
    config = function() end,
  })

  use({
    'windwp/lsp-fastaction.nvim',
    config = function()
      require('config.fastaction')
    end,
  })

  -- lsp signagure
  use({
    'ray-x/lsp_signature.nvim',
    event = 'bufRead',
    disable = true,
    config = function()
      require('config.lsp-signature')
    end,
  })

  -- nvim colorizer
  use({
    'norcalli/nvim-colorizer.lua',
    event = 'BufReadPre',
    config = function()
      require('config.colorizer')
    end,
  })

  -- trouble
  use({
    'folke/trouble.nvim', -- keys = {
    --   "<leader>xx",
    --   "<leader>xw",
    --   "<leader>xd",
    --   "<leader>xl",
    --   "<leader>xq",
    --   "gR",
    --   "gD",
    -- },
    -- event = "BufEnter",
    wants = 'nvim-web-devicons',
    config = function()
      require('config.trouble')
    end,
  })

  -- todo-comments
  use({
    'folke/todo-comments.nvim',
    config = function()
      require('config.todo')
    end,
  })

  -- formatter
  use({
    'mhartington/formatter.nvim',
    cmd = { 'Format', 'FormatWrite' },
    ft = { 'dart', 'lua' },
    config = function()
      require('config.formatter')
    end,
  })

  -- persistence
  -- Lua
  use({
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    keys = { '<leader>qs', '<leader>ql', '<leader>qd' },
    module = 'persistence',
    config = function()
      require('config.persistence')
    end,
  })

  -- lspconfig
  use({
    'neovim/nvim-lspconfig',
    -- requires = { 'onsails/lspkind-nvim' },
    after = { 'cmp-nvim-lsp', 'mason-lspconfig.nvim' },
    config = function()
      require('config.lsp')
    end,
  })

  use({
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  })

  use({
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup()
    end,
    after = 'mason.nvim',
  })

  use({
    'kosayoda/nvim-lightbulb',
    config = function()
      require('config.nvim-lightbulb')
    end,
  })

  -- vim unimpaired (vimscript)
  use({ 'tpope/vim-unimpaired', event = 'bufEnter' })
  use({ 'tpope/vim-surround', event = 'bufRead' })

  -- vim repeat (vimscript)
  use({ 'tpope/vim-repeat', event = 'bufEnter' })

  -- vim-mundo (vimscript)
  use({
    'simnalamburt/vim-mundo',
    keys = '<leader>vm',
    config = function()
      vim.g.mundo_width = 30
      -- vim.g.mundo_preview_statusline = 0
      -- vim.g.mundo_tree_statusline = 0
      -- vim.g.mundo_auto_preview = 0
      vim.g.mundo_preview_bottom = 1
      vim.g.mundo_preview_height = 15
      vim.api.nvim_set_keymap('n', '<leader>vm', ':MundoToggle<cr>', { noremap = true, silent = true })
    end,
  })

  use({
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = '<leader>u',
    -- setup = function()
    --   require("which-key").register({
    --     ["<leader>u"] = "undotree: toggle",
    --   })
    -- end,
    config = function()
      vim.g.undotree_SplitWidth = 40
      vim.g.undotree_WindowLayout = 2
      -- vim.g.undotree_TreeNodeShape = "◉" -- Alternative: '◦'
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_TreeNodeShape = '*'
      vim.g.undotree_DiffpanelHeight = 10
      vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<cr>', { desc = 'undotree: toggle' })
    end,
  })

  -- vim-maximizer (vimscript)
  use({
    'szw/vim-maximizer',
    keys = { '<leader>m', { 'v', '<leader>m' } },
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>m', ':MaximizerToggle!<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<leader>m', ':MaximizerToggle!<cr>gv', { noremap = true, silent = true })
    end,
  })

  use({
    'beauwilliams/focus.nvim',
    disable = true,
    config = function()
      require('focus').setup()
    end,
  })

  -- fidget nvim
  use({
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end,
  })

  -- target vim (vimscript)
  use({ 'wellle/targets.vim', disable = true })
end),
    -- autocommands
vim.cmd([[
augroup Plugin 
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup END
]]),
    -- mappings
  -- packer mappings
require('which-key').register({
    ['<leader>p'] = {
      name = '+Packer',
      s = { '<cmd>PackerSync<cr>', 'Packer: Sync' },
      S = { '<cmd>PackerStatus<cr>', 'Packer: Status' },
      c = { '<cmd>PackerClean<cr>', 'Packer: Clean' },
    },
  })

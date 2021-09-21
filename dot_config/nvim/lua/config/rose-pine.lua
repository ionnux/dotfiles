-- Set variant
-- Defaults to 'dawn' if vim background is light
-- @usage 'base' | 'moon' | 'dawn' | 'rose-pine[-moon][-dawn]'
vim.g.rose_pine_variant = 'moon'

-- Disable italics
vim.g.rose_pine_disable_italics = false

-- Use terminal background
vim.g.rose_pine_disable_background = false

-- Set colorscheme after options
vim.cmd( 'colorscheme rose-pine' )

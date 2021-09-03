local trouble = require( "trouble.providers.telescope" )
require( 'telescope' ).load_extension( 'projects' )

require( 'telescope' ).setup {
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
        },
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "flex",
        layout_config = {
            horizontal = { mirror = false, preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.9,
        },
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = { "/home/og_saaz/%.config/nvim/.*" },
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        color_devicons = true,
        use_less = true,
        path_display = function( opts, path )
            return string.gsub( path, "/home/og_saaz", "~" )
        end,

        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
    },
}
require( 'telescope' ).load_extension( 'fzf' )

vim.api.nvim_set_keymap(
    'n', '<leader>fp', [[<cmd>:Telescope projects theme=get_dropdown<cr><esc>]],
    { noremap = true, silent = true }
 )
vim.api.nvim_set_keymap(
    'n', '<leader>ff',
    [[<cmd>lua require('telescope.builtin').find_files()<cr>]],
    { noremap = true, silent = true }
 )
vim.api.nvim_set_keymap(
    'n', '<leader>fg',
    [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],
    { noremap = true, silent = true }
 )
vim.api.nvim_set_keymap(
    'n', '<leader>fb',
    [[<cmd>lua require('telescope.builtin').buffers()<cr><esc>]],
    { noremap = true, silent = true }
 )
vim.api.nvim_set_keymap(
    'n', '<leader>fh',
    [[<cmd>lua require('telescope.builtin').help_tags()<cr>]],
    { noremap = true, silent = true }
 )
vim.api.nvim_set_keymap(
    'n', '<leader>fr', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]],
    { noremap = true, silent = true }
 )

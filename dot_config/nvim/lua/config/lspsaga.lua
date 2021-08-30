local saga = require 'lspsaga'
saga.init_lsp_saga {
  use_saga_diagnostic_sign = true,
  error_sign = '',
  warn_sign = '',
  --hint_sign = '',
  hint_sign = '',
  infor_sign = '',
  dianostic_header_icon = '   ',
  code_action_icon = ' ',
  code_action_prompt = {
    enable = true,
    sign = false,
    sign_priority = 20,
    virtual_text = true,
  },
  finder_definition_icon = '  ',
  finder_reference_icon = '  ',
  max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
  finder_action_keys = {
    open = 'o', vsplit = 'v',split = 's',quit = 'q',scroll_down = '<C-j>', scroll_up = '<C-k>' -- quit can be a table
  },
  code_action_keys = {
    quit = 'q',exec = '<CR>'
  },
  rename_action_keys = {
    quit = '<C-c>',exec = '<CR>'  -- quit can be a table
  },
  definition_preview_icon = '  ',
  --"single" "double" "round" "plus" "bold"
  border_style = "single",
  rename_prompt_prefix = '➤',
}

vim.api.nvim_set_keymap('n', '<leader>gd', ':Lspsaga lsp_finder<cr>', { noremap = true, silent = true })

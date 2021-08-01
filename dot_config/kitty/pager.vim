call plug#begin('~/.nvim/plugged')
Plug 'ggandor/lightspeed.nvim' "motion plugin written in lua
Plug 'dstein64/nvim-scrollview' "scrollbar plugin
call plug#end()

"lightspeed settings
lua <<EOF
  require'lightspeed'.setup {
    jump_to_first_match = true,
    jump_on_partial_input_safety_timeout = 400,
    -- This can get _really_ slow if the window has a lot of content,
    -- turn it on only if your machine can always cope with it.
    highlight_unique_chars = false,
    grey_out_search_area = true,
    match_only_the_start_of_same_char_seqs = true,
    limit_ft_matches = 5,
    full_inclusive_prefix_key = '<c-x>',
    -- By default, the values of these will be decided at runtime,
    -- based on `jump_to_first_match`.
    labels = nil,
    cycle_group_fwd_key = nil,
    cycle_group_bwd_key = nil,
  }
    function repeat_ft(reverse)
      local ls = require'lightspeed'
      ls.ft['instant-repeat?'] = true
      ls.ft:to(reverse, ls.ft['prev-t-like?'])
    end
    vim.api.nvim_set_keymap('n', ';', '<cmd>lua repeat_ft(false)<cr>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('x', ';', '<cmd>lua repeat_ft(false)<cr>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', ',', '<cmd>lua repeat_ft(true)<cr>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('x', ',', '<cmd>lua repeat_ft(true)<cr>',
                            {noremap = true, silent = true})
EOF

set number
set relativenumber
set nolist
set showtabline=0
set foldcolumn=0
set laststatus=0
set noshowmode 
set noruler
set noshowcmd
set shortmess+=F
set clipboard+=unnamedplus

autocmd TermOpen * normal G
map q :qa!<cr>

silent write! /tmp/kitty_scrollback_buffer | te echo -n \"$(cat /tmp/kitty_scrollback_buffer)\" && sleep 1000 

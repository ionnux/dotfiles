-- Lua
local cb = require'diffview.config'.diffview_callback

require'diffview'.setup {
  diff_binaries = false, -- Show diffs for binaries
  use_icons = true, -- Requires nvim-web-devicons
  file_panel = {
    position = "left", -- One of 'left', 'right', 'top', 'bottom'
    width = 35, -- Only applies when position is 'left' or 'right'
    height = 10, -- Only applies when position is 'top' or 'bottom'
  },
  file_history_panel = {
    position = "bottom",
    width = 35,
    height = 10,
    log_options = {
      max_count = 256, -- Limit the number of commits
      follow = false, -- Follow renames (only for single file)
      all = false, -- Include all refs under 'refs/' including HEAD
      merges = false, -- List only merge commits
      no_merges = false, -- List no merge commits
      reverse = false, -- List commits in reverse order
    },
  },
  key_bindings = {
    disable_defaults = false, -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"] = cb( "select_next_entry" ),
      ["<s-tab>"] = cb( "select_prev_entry" ),
      ["gf"] = cb( "goto_file" ),
      ["<C-w><C-f>"] = cb( "goto_file_split" ),
      ["<C-w>gf"] = cb( "goto_file_tab" ),
      ["<leader>e"] = cb( "focus_files" ),
      ["<leader>b"] = cb( "toggle_files" ),
    },
    file_panel = {
      ["j"] = cb( "next_entry" ),
      ["<down>"] = cb( "next_entry" ),
      ["k"] = cb( "prev_entry" ),
      ["<up>"] = cb( "prev_entry" ),
      ["<cr>"] = cb( "select_entry" ),
      ["o"] = cb( "select_entry" ),
      ["<2-LeftMouse>"] = cb( "select_entry" ),
      ["-"] = cb( "toggle_stage_entry" ),
      ["S"] = cb( "stage_all" ),
      ["U"] = cb( "unstage_all" ),
      ["X"] = cb( "restore_entry" ),
      ["R"] = cb( "refresh_files" ),
      ["<tab>"] = cb( "select_next_entry" ),
      ["<s-tab>"] = cb( "select_prev_entry" ),
      ["gf"] = cb( "goto_file" ),
      ["<C-w><C-f>"] = cb( "goto_file_split" ),
      ["<C-w>gf"] = cb( "goto_file_tab" ),
      ["i"] = cb( "listing_style" ),
      ["f"] = cb( "toggle_flatten_dirs" ),
      ["<leader>e"] = cb( "focus_files" ),
      ["<leader>b"] = cb( "toggle_files" ),
    },
    file_history_panel = {
      ["g!"] = cb( "options" ),
      ["<C-d>"] = cb( "open_in_diffview" ),
      ["zR"] = cb( "open_all_folds" ),
      ["zM"] = cb( "close_all_folds" ),
      ["j"] = cb( "next_entry" ),
      ["<down>"] = cb( "next_entry" ),
      ["k"] = cb( "prev_entry" ),
      ["<up>"] = cb( "prev_entry" ),
      ["<cr>"] = cb( "select_entry" ),
      ["o"] = cb( "select_entry" ),
      ["<2-LeftMouse>"] = cb( "select_entry" ),
      ["<tab>"] = cb( "select_next_entry" ),
      ["<s-tab>"] = cb( "select_prev_entry" ),
      ["gf"] = cb( "goto_file" ),
      ["<C-w><C-f>"] = cb( "goto_file_split" ),
      ["<C-w>gf"] = cb( "goto_file_tab" ),
      ["<leader>e"] = cb( "focus_files" ),
      ["<leader>b"] = cb( "toggle_files" ),
    },
    option_panel = { ["<tab>"] = cb( "select" ), ["q"] = cb( "close" ) },
  },
}

local wk = require( "which-key" )
wk.register(
  {
    ["<leader>g"] = {
      name = "Git",
      d = {
        name = "Diffview",
        o = { "<cmd>DiffviewOpen<cr>", "Diffview Open" },
        c = { "<cmd>DiffviewClose<cr>", "Diffview Close" },
        h = { "<cmd>DiffviewFileHistory<cr>", "Diffview FileHistory" },
        f = { "<cmd>DiffviewToggleFiles<cr>", "Diffview ToggleFiles" },
      },
    },
  }
 )

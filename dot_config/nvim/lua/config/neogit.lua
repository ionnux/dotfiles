local neogit = require( "neogit" )

neogit.setup {
  disable_signs = false,
  disable_context_highlighting = true,
  disable_commit_confirmation = false,
  auto_refresh = true,
  disable_builtin_notifications = false,
  commit_popup = { kind = "split" },
  -- customize displayed signs
  signs = {
    -- { CLOSED, OPENED }
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
  },
  integrations = {
    -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
    -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
    --
    -- Requires you to have `sindrets/diffview.nvim` installed.
    -- use {
    --   'TimUntersberger/neogit',
    --   requires = {
    --     'nvim-lua/plenary.nvim',
    --     'sindrets/diffview.nvim'
    --   }
    -- }
    --
    diffview = true,
  },
  -- override/add mappings
  mappings = {
    -- modify status buffer mappings
    status = {
      ["q"] = "Close",
      ["1"] = "Depth1",
      ["2"] = "Depth2",
      ["3"] = "Depth3",
      ["4"] = "Depth4",
      [" "] = "Toggle",
      ["x"] = "Discard",
      ["s"] = "Stage",
      ["S"] = "StageUnstaged",
      ["<c-s>"] = "StageAll",
      ["u"] = "Unstage",
      ["U"] = "UnstageStaged",
      ["d"] = "DiffAtFile",
      ["$"] = "CommandHistory",
      ["<c-r>"] = "RefreshBuffer",
      ["<enter>"] = "GoToFile",
      ["<c-v>"] = "VSplitOpen",
      ["<c-x>"] = "SplitOpen",
      ["<c-t>"] = "TabOpen",
      ["?"] = "HelpPopup",
      ["D"] = "DiffPopup",
      ["P"] = "PullPopup",
      ["r"] = "RebasePopup",
      ["p"] = "PushPopup",
      ["c"] = "CommitPopup",
      ["L"] = "LogPopup",
      ["Z"] = "StashPopup",
      ["b"] = "BranchPopup",
    },
  },
}

local wk = require( "which-key" )
wk.register( { ["<leader>g"] = { name = "Git", n = { "<cmd>Neogit<cr>", "Neogit: open" } } } )

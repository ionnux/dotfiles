  require("trouble").setup {
      position = "bottom",
      auto_close = true,
      auto_open = false,
      mode = "lsp_document_diagnostics",
    }

  -- keymappings
  vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
  vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", {silent = true, noremap = true})
  vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>TroubleToggle lsp_document_diagnostics<cr>", {silent = true, noremap = true})
  vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {silent = true, noremap = true})
  vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {silent = true, noremap = true})
  vim.api.nvim_set_keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", {silent = true, noremap = true})
  vim.api.nvim_set_keymap("n", "gD", "<cmd>TroubleToggle lsp_definitions<cr>", {silent = true, noremap = true})

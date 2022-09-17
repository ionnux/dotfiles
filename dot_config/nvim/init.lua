-- require( 'impatient' )
require("options")
require("mappings")
require("autocommands")

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
vim.keymap.set("n", "<leader>ll", function()
  print("real lua function")
end, { desc = "lllllll" })

vim.cmd([[

if has('nvim')
    let $GIT_EDITOR = "nvim --server /tmp/nvim.sock --remote"
  endif]])

-- no need to load this immediately, since we have packer_compiled
vim.defer_fn(function()
  require("plugins")
end, 0)

-- vim.cmd(":intro")

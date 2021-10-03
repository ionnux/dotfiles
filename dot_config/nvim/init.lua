-- require( 'impatient' )
require("options")
require("mappings")
require("autocommands")

vim.cmd([[
if has('nvim') && executable('nvr')
    let $GIT_EDITOR = "nvr --remote-tab +'set bufhidden=wipe'"
  endif]])

-- no need to load this immediately, since we have packer_compiled
vim.defer_fn(function()
	require("plugins")
end, 0)

-- vim.cmd(":intro")

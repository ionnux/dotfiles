-- require( 'impatient' )
require( "options" )
require( "mappings" )
require( "autocommands" )

-- no need to load this immediately, since we have packer_compiled
vim.defer_fn( function() require( "plugins" ) end, 0 )

-- vim.cmd(":intro")

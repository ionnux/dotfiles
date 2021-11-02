-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{ virtual_text = false, signs = true, underline = true, update_in_insert = true }
)
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

-- Change diagnostic symbols in the sign column (gutter)
for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- print diagnostics in statusline
-- function PrintDiagnostics( opts, bufnr, line_nr, client_id )
--   opts = opts or {}

--   bufnr = bufnr or 0
--   line_nr = line_nr or (vim.api.nvim_win_get_cursor( 0 )[1] - 1)

--   local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics( bufnr, line_nr, opts, client_id )
--   if vim.tbl_isempty( line_diagnostics ) then return end

--   local diagnostic_message = ""
--   for i, diagnostic in ipairs( line_diagnostics ) do
--     diagnostic_message = diagnostic_message .. string.format( "%d: %s", i, diagnostic.message or "" )
--     print( diagnostic_message )
--     if i ~= #line_diagnostics then diagnostic_message = diagnostic_message .. "\n" end
--   end
--   vim.api.nvim_echo( { { diagnostic_message, "Normal" } }, false, {} )
-- end
-- vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

-- show line diagnostics in automatically in hover window
-- vim.cmd([[
-- autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false, border = CustomBorders.plus, focusable = false})
-- ]])

-- goto definition in split window
-- local function goto_definition( split_cmd )
--   local util = vim.lsp.util
--   local log = require( "vim.lsp.log" )
--   local api = vim.api

--   -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
--   local handler = function( _, result, ctx )
--     if result == nil or vim.tbl_isempty( result ) then
--       local _ = log.info() and log.info( ctx.method, "No location found" )
--       return nil
--     end

--     if split_cmd then vim.cmd( split_cmd ) end

--     if vim.tbl_islist( result ) then
--       util.jump_to_location( result[1] )

--       if #result > 1 then
--         util.set_qflist( util.locations_to_items( result ) )
--         api.nvim_command( "copen" )
--         api.nvim_command( "wincmd p" )
--       end
--     else
--       util.jump_to_location( result )
--     end
--   end

--   return handler
-- end
-- vim.lsp.handlers["textDocument/definition"] = goto_definition( 'split' )

-- peak definition
local function preview_location_callback(_, result)
	if result == nil or vim.tbl_isempty(result) then
		return nil
	end
	vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
	local params = vim.lsp.util.make_position_params()
	return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
end

-- keymaps
local on_attach = function(client, bufnr)
	--keymap settings
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	--buffer options
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- border settings
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = CustomBorders.plus })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = CustomBorders.plus }
	)

	-- Enable completion triggered by <c-x><c-o>
	-- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- buf_set_keymap(
	-- 	"n",
	-- 	"gd",
	-- 	"<cmd>lua PeekDefinition({popup_opts = {border = CustomBorders.plus, focusable = true}})<CR>",
	-- 	opts
	-- ) -- PeekDefinition
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- buf_set_keymap( 'n', 'gr', '<cmd>TroubleToggle lsp_references<cr>', opts ) -- use trouble
	-- buf_set_keymap( 'n', 'gd', '<cmd>TroubleToggle lsp_definitions<cr>', opts ) -- use trouble
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	-- buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	-- buf_set_keymap("n", "<leader>ca", "<cmd>CodeActionMenu<cr>", opts) --use CodeActionMenu
	buf_set_keymap("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<cr>", opts) --use telescope
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	-- buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap(
		"n",
		"<space>d",
		"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = CustomBorders.plus, focusable = false})<CR>",
		opts
	)
	buf_set_keymap(
		"n",
		"[d",
		"<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = CustomBorders.plus, focusable = false}})<CR>",
		opts
	)
	buf_set_keymap(
		"n",
		"]d",
		"<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = CustomBorders.plus, focusable = false}})<CR>",
		opts
	)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	-- buf_set_keymap( 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts )

	-- Set some keybinds conditional on server capabilities
	-- if client.resolved_capabilities.document_formatting then
	--   buf_set_keymap( "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts )
	-- elseif client.resolved_capabilities.document_range_formatting then
	--   buf_set_keymap( "n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts )
	-- end

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
			false
		)
	end
end

-- Configure lua language server for neovim development
local lua_settings = {
	Lua = {
		runtime = {
			-- LuaJIT in the case of Neovim
			version = "LuaJIT",
			path = vim.split(package.path, ";"),
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = { "vim" },
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
			},
		},
	},
}

-- config that activates keymaps and enables snippet support
local function make_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
	}
end

-- lsp-install
--[[ local function setup_servers()
	-- require("lspinstall").setup()

	-- get all installed servers
	local servers = lsp_installer.servers
	-- ... and add manually installed servers
	-- table.insert( servers, "dartls" )

	for _, server in pairs(servers) do
		local config = make_config()

		-- language specific config
		if server == "lua" then
			config.settings = lua_settings
		end
		if server == "sqls" then
			config = {
				cmd = { "/usr/local/bin/sqls", "-config", "/home/og_saaz/.config/sqls/config.yml" },
			}
		end
		if server == "sqlls" then
			config = {
				cmd = { "/usr/local/bin/sql-language-server", "up", "--method", "stdio" },
			}
		end

		require("lspconfig")[server].setup(config)
	end
end

setup_servers() --]]

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local default_opts = make_config()
	local server_opts = {}
	server:setup(server_opts[server.name] and server_opts[server.name]() or default_opts)
	vim.cmd([[ do User LspAttachBuffers ]])
end)

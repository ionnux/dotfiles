-- diagnostics
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
	float = {
		source = "always",
		border = CustomBorders.plus,
	},
})

-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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
	buf_set_keymap("n", "<space>d", "<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

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

local lsp_installer = require("nvim-lsp-installer")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp_installer.on_server_ready(function(server)
	local default_opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	local server_opts = {
		["elixirls"] = function()
			return vim.tbl_deep_extend("force", default_opts, {
				cmd = { "/home/og_saaz/.local/share/nvim/lsp_servers/elixir/elixir-ls/language_server.sh" },
				settings = {
					elixirLS = {
						dialyzerEnabled = true,
					},
				},
			})
		end,

		["sumneko_lua"] = function()
			return vim.tbl_deep_extend("force", default_opts, {
				cmd = {
					"/home/og_saaz/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/Linux/lua-language-server",
				},
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
							path = vim.split(package.path, ";"),
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							},
						},
					},
				},
			})
		end,

		["efm"] = function()
			return vim.tbl_deep_extend("force", default_opts, {
				cmd = { "/home/og_saaz/.local/share/nvim/lsp_servers/efm/efm-langserver" },
				filetypes = { "elixir" },
			})
		end,
		["gopls"] = function()
			return vim.tbl_deep_extend("force", default_opts, {
				cmd = { "/home/og_saaz/.local/share/nvim/lsp_servers/go/gopls" },
				-- filetypes = { "go" },
			})
		end,
	}

	-- Use the server's custom settings, if they exist, otherwise default to the default options
	local server_options = server_opts[server.name] and server_opts[server.name]() or default_opts
	server:setup(server_options)
end)

-- keymaps
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	-- local function buf_set_option(...)
	-- vim.api.nvim_buf_set_option(bufnr, ...)
	-- end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = CustomBorders.plus })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = CustomBorders.plus }
	)

	-- Enable completion triggered by <c-x><c-o>
	-- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- lsp Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- buf_set_keymap("n", "gd", "<cmd>lua PeekDefinition({border = CustomBorders.plus, focusable = true})<CR>", opts) -- PeekDefinition
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
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	-- buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	-- buf_set_keymap("n", "<leader>ca", "<cmd>CodeActionMenu<cr>", opts) --use CodeActionMenu
	-- buf_set_keymap("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<cr>", opts) --use telescope
	buf_set_keymap(
		"n",
		"<leader>d",
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

	-- flutter widget_guides highlight color
	vim.cmd("highlight FlutterWidgetGuides guifg=#9ccfd8")

	vim.cmd([[autocmd CursorHold,CursorHoldI * lua Lightbulb()]])

	-- flutter keymaps
	local wk = require("which-key")
	wk.register({
		["<leader>"] = {
			f = {
				name = "Flutter",
				r = {
					name = "Flutter: Run",
					r = { "<cmd>FlutterRun<cr>", "Flutter: Run" },
					d = {
						"<cmd>FlutterRun --flavor development --target lib/main_development.dart<cr>",
						"Flutter: Run Development",
					},
					s = {
						"<cmd>FlutterRun --flavor staging --target lib/main_staging.dart<cr>",
						"Flutter: Run Staging",
					},
					p = {
						"<cmd>FlutterRun --flavor production --target lib/main_production.dart<cr>",
						"Flutter: Run Production",
					},
				},
				R = { "<cmd>FlutterRestart<cr>", "Flutter: Restart" },
				e = { "<cmd>FlutterEmulators<cr>", "Flutter: Emulators" },
				d = { "<cmd>FlutterDevices<cr>", "Flutter: Devices" },
				l = { name = "log", c = { "<cmd>FlutterLogClear<cr>", "Flutter: Clear Log" } },
				o = { "<cmd>FlutterOutlineToggle<cr>", "Flutter: Toggle Outline" },
				y = { "<cmd>FlutterCopyProfilerUrl<cr>", "Flutter: Yank Profiler Url" },
				v = { "<cmd>FlutterVisualDebug<cr>", "Flutter: Enable Visual Debug" },
				p = {
					name = "Pub",
					g = { "<cmd>FlutterPubGet<cr>", "Flutter: Pub Get" },
					u = { "<cmd>FlutterPubUpgrade<cr>", "Flutter: Pub Upgrade" },
				},
			},
		},
	}, {
		buffer = "*.dart",
	})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("flutter-tools").setup({
	ui = {
		-- the border type to use for all floating windows, the same options/formats
		-- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
		border = "single",
	},
	decorations = {
		statusline = {
			-- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
			-- this will show the current version of the flutter app from the pubspec.yaml file
			app_version = true,
			-- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
			-- this will show the currently running device if an application was started with a specific
			-- device
			device = true,
		},
	},
	debugger = { -- integrate with nvim dap + install dart code debugger
		enabled = false,
	},
	-- flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
	-- flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
	widget_guides = { enabled = true, debug = true },
	closing_tags = {
		highlight = "Comment", -- highlight for the closing tag
		prefix = "-> ", -- character to use for close tag e.g. > Widget
		enabled = true, -- set to false to disable
	},
	dev_log = {
		open_cmd = "edit", -- command to use to open the log buffer
	},
	dev_tools = {
		autostart = false, -- autostart devtools server if not detected
		auto_open_browser = false, -- Automatically opens devtools in the browser
	},
	outline = {
		open_cmd = "30vnew", -- command to use to open the outline buffer
		auto_open = false, -- if true this will open the outline automatically when it is first populated
	},
	lsp = {
		on_attach = on_attach,
		capabilities = capabilities,
		--- OR you can specify a function to deactivate or change or control how the config is created
		-- capabilities = function(config)
		-- config.specificThingIDontWant = false
		-- return config
		-- end,
		settings = {
			showTodos = false,
			completeFunctionCalls = true,
			-- analysisExcludedFolders = {<path-to-flutter-sdk-packages>}
		},
	},
})

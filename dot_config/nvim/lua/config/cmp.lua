local luasnip = require("luasnip")
local cmp = require("cmp")

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

cmp.setup({
	snippet = {
		expand = function(args)
			-- For `vsnip` user.
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

			-- For `luasnip` user.
			require("luasnip").lsp_expand(args.body)

			-- For `ultisnips` user.
			-- vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		-- ["<C-k>"] = cmp.mapping.scroll_docs(-4),
		-- ["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.close()
			else
				cmp.complete()
			end
		end, {
			"i",
		}),
		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),

		["<Tab>"] = cmp.mapping(function()
			if luasnip.jumpable() then
				luasnip.jump(1)
			else
				vim.cmd("Tabout")
			end
		end, {
			"i",
			"s",
		}),

		["<S-Tab>"] = cmp.mapping(function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				vim.cmd("Tabout")
			end
		end, {
			"i",
			"s",
		}),
	},

	documentation = {
		border = "single",
		-- winhighlight = "NormalFloat:NormalFloat,FloatBorder:LspSagaHoverBorder",
		maxwidth = 70,
		maxheight = 20,
	},

	formatting = {
		format = function(entry, vim_item)
			-- fancy icons and a name of kind
			vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

			-- set a name for each source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				path = "[Path]",
				calc = "[calc]",
			})[entry.source.name]
			return vim_item
		end,
	},

	sources = {
		{ name = "nvim_lsp", priority = 2 },
		{ name = "luasnip", priority = 3 },
		{ name = "nvim_lua", priority = 3 },
		{ name = "buffer", priority = 1 },
		{ name = "path", priority = 1 },
		{ name = "calc", priority = 1 },
	},

	sorting = {
		priority_weight = 2,
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})

-- nvim-autopairs settings for nvim-cmp
require("nvim-autopairs.completion.cmp").setup({
	map_cr = true, --  map <CR> on insert mode
	map_complete = true, -- it will auto insert `(` after select function or method item
	auto_select = false, -- automatically select the first item
})

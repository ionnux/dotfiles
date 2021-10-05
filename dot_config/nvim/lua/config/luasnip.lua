local types = require("luasnip.util.types")
local util = require("luasnip.util.util")

require("luasnip").config.setup({
	history = false,
	updateevents = "InsertLeave",
	-- see :h User, event should never be triggered(except if it is `doautocmd`'d)
	region_check_events = "User None",
	delete_check_events = "User None",
	store_selection_keys = nil, -- Supossed to be the same as the expand shortcut
	ext_opts = {
		[types.textNode] = {
			active = { hl_group = "LuasnipTextNodeActive" },
			passive = { hl_group = "LuasnipTextNodePassive" },
			snippet_passive = { hl_group = "LuasnipTextNodeSnippetPassive" },
		},
		[types.insertNode] = {
			active = {
				hl_group = "LuasnipInsertNodeActive",
				virt_text = { { "●", "Type" } },
			},
			passive = { hl_group = "LuasnipInsertNodePassive" },
			snippet_passive = { hl_group = "LuasnipInsertNodeSnippetPassive" },
		},
		[types.exitNode] = {
			active = { hl_group = "LuasnipExitNodeActive" },
			passive = { hl_group = "LuasnipExitNodePassive" },
			snippet_passive = { hl_group = "LuasnipExitNodeSnippetPassive" },
		},
		[types.functionNode] = {
			active = { hl_group = "LuasnipFunctionNodeActive" },
			passive = { hl_group = "LuasnipFunctionNodePassive" },
			snippet_passive = {
				hl_group = "LuasnipFunctionNodeSnippetPassive",
			},
		},
		[types.snippetNode] = {
			active = { hl_group = "LuasnipSnippetNodeActive" },
			passive = { hl_group = "LuasnipSnippetNodePassive" },
			snippet_passive = {
				hl_group = "LuasnipSnippetNodeSnippetPassive",
			},
		},
		[types.choiceNode] = {
			active = {
				hl_group = "LuasnipInsertNodeActive",
				virt_text = { { "●", "Type" } },
			},
			passive = { hl_group = "LuasnipChoiceNodePassive" },
			snippet_passive = { hl_group = "LuasnipChoiceNodeSnippetPassive" },
		},
		[types.dynamicNode] = {
			active = { hl_group = "LuasnipDynamicNodeActive" },
			passive = { hl_group = "LuasnipDynamicNodePassive" },
			snippet_passive = {
				hl_group = "LuasnipDynamicNodeSnippetPassive",
			},
		},
		[types.snippet] = {
			active = { hl_group = "LuasnipSnippetActive" },
			passive = { hl_group = "LuasnipSnippetPassive" },
			-- not used!
			snippet_passive = { hl_group = "LuasnipSnippetSnippetPassive" },
		},
	},
	ext_base_prio = 200,
	ext_prio_increase = 7,
	enable_autosnippets = false,
	-- default applied in util.parser, requires iNode, cNode
	-- (Dependency cycle if here).
	parser_nested_assembler = nil,
})

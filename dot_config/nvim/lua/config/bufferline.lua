local colors = require("colors.themes.tokyonight")
local fmt = string.format
local utils = require("bufferline.utils")
local padding = require("bufferline.constants").padding

local present, bufferline = pcall(require, "bufferline")
if not present then
	return
end

local function diagnostics_indicator(_, _, diagnostics, context)
	local symbols = { error = "  ", warning = "  ", info = " " }
	local result = {}
	for name, count in pairs(diagnostics) do
		if symbols[name] and count > 0 then
			table.insert(result, symbols[name] .. count)
		end
	end
	result = table.concat(result, " ")
	if context.buffer:current() then
		return ""
	end
	return #result > 0 and result or ""
end

local function group_separator(group, hls, count)
	local bg_hl = hls.fill.hl
	local name, display_name = group.name, group.display_name
	local sep_grp, label_grp = hls[fmt("%s_separator", name)], hls[fmt("%s_label", name)]
	local sep_hl = sep_grp and sep_grp.hl or hls.group_separator.hl
	local label_hl = label_grp and label_grp.hl or hls.group_label.hl
	local left, right = "", ""
	-- local left, right = "█", "█"
	local indicator = utils.join(bg_hl, padding, sep_hl, left, label_hl, display_name, count, sep_hl, right, padding)
	local length = utils.measure(left, right, display_name, count, padding, padding)
	return indicator, length
end

-- use this if log is shown on a seperate tab
-- local function custom_filter(buf, buf_nums)
-- 	local logs = vim.tbl_filter(function(b)
-- 		return vim.bo[b].filetype == "log"
-- 	end, buf_nums)
-- 	if vim.tbl_isempty(logs) then
-- 		return true
-- 	end
-- 	local tab_num = vim.fn.tabpagenr()
-- 	local last_tab = vim.fn.tabpagenr("$")
-- 	local is_log = vim.bo[buf].filetype == "log"
-- 	if last_tab == 1 then
-- 		return true
-- 	end
-- 	-- only show log buffers in secondary tabs
-- 	return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
-- end

local function custom_filter(buf_number)
	-- filter out filetypes you don't want to see
	if vim.bo[buf_number].filetype ~= "log" then
		return true
	end
end

local function sort_by_mtime(a, b)
	local astat = vim.loop.fs_stat(a.path)
	local bstat = vim.loop.fs_stat(b.path)
	local mod_a = astat and astat.mtime.sec or 0
	local mod_b = bstat and bstat.mtime.sec or 0
	return mod_a > mod_b
end

local groups = require("bufferline.groups")

bufferline.setup({
	options = {
		numbers = function(opts)
			return string.format("%s", opts.lower(opts.ordinal))
		end,
		-- sort_by = sort_by_mtime,
		offsets = {
			{
				filetype = "Mundo",
				text = "Vim Mundo",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "NvimTree",
				text = "Explorer",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "DiffviewFiles",
				text = "Diff View",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "flutterToolsOutline",
				text = "Flutter Outline",
				highlight = "PanelHeading",
			},
			{
				filetype = "packer",
				text = "Packer",
				highlight = "PanelHeading",
				padding = 1,
			},
		},
		-- groups = {
		-- 	options = {
		-- 		toggle_hidden_on_enter = true,
		-- 	},
		-- 	items = {
		-- 		groups.builtin.ungrouped,
		-- 		{
		-- 			name = "BLoC",
		-- 			highlight = { guisp = colors.vibrant_green, --[[ gui = "undercurl",  --]]guibg = colors.black2 },
		-- 			auto_close = false,
		-- 			matcher = function(buf)
		-- 				-- return buf.filename:match("_spec") or buf.filename:match("test")
		-- 				return buf.path:match("bloc/")
		-- 			end,
		-- 			separator = {
		-- 				style = group_separator,
		-- 			},
		-- 		},
		-- 		{
		-- 			name = "Cubit",
		-- 			highlight = { guisp = colors.vibrant_green, --[[ gui = "undercurl",  --]]guibg = colors.black2 },
		-- 			auto_close = false,
		-- 			matcher = function(buf)
		-- 				return buf.path:match("cubit/")
		-- 			end,
		-- 			separator = {
		-- 				style = group_separator,
		-- 			},
		-- 		},
		-- 		{
		-- 			name = "View",
		-- 			highlight = { guisp = colors.vibrant_green, --[[ gui = "undercurl",  --]]guibg = colors.black2 },
		-- 			auto_close = false,
		-- 			matcher = function(buf)
		-- 				return buf.path:match("view/")
		-- 			end,
		-- 			separator = {
		-- 				style = group_separator,
		-- 			},
		-- 		},
		-- 	},
		-- },
		separator_style = "thick",
		buffer_close_icon = "",
		modified_icon = "",
		close_icon = "",
		show_close_icon = true,
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 50,
		max_prefix_length = 10,
		tab_size = 20,
		show_tab_indicators = true,
		enforce_regular_tabs = false,
		view = "multiwindow",
		show_buffer_close_icons = true,
		always_show_bufferline = true,
		diagnostics = "nvim_lsp", -- "or nvim_lsp"
		diagnostics_indicator = diagnostics_indicator,
		diagnostics_update_in_insert = false,
		custom_filter = custom_filter,
	},

	highlights = {
		background = { guifg = colors.white, guibg = colors.black2 },
		pick = { guifg = colors.red, guibg = colors.black2 },
		pick_selected = { guifg = colors.red, guibg = colors.black },
		fill = { guifg = colors.grey_fg, guibg = colors.black2 },

		-- buffers
		buffer = { guifg = colors.white, guibg = colors.black, gui = "bold" },
		buffer_selected = { guifg = colors.yellow, guibg = colors.black, gui = "bold" },
		buffer_visible = { guifg = colors.white, guibg = colors.black2 },

		-- for diagnostics = "nvim_lsp"
		error = { guifg = colors.light_grey, guibg = colors.black2 },
		error_diagnostic = { guifg = colors.light_grey, guibg = colors.black2 },

		-- close buttons
		close_button = { guifg = colors.light_grey, guibg = colors.black2 },
		close_button_visible = { guifg = colors.light_grey, guibg = colors.black2 },
		close_button_selected = { guifg = colors.red, guibg = colors.black },
		indicator_selected = { guifg = colors.black, guibg = colors.black },

		-- modified
		modified = { guifg = colors.red, guibg = colors.black2 },
		modified_visible = { guifg = colors.red, guibg = colors.black2 },
		modified_selected = { guifg = colors.green, guibg = colors.black },

		-- separators
		-- separator = { guifg = colors.vibrant_green, guibg = colors.black2 },
		-- separator_visible = { guifg = colors.black2, guibg = colors.black2 },
		-- separator_selected = { guifg = colors.black2, guibg = colors.black2 },
		-- tabs
		tab = { guifg = colors.light_grey, guibg = colors.one_bg3 },
		tab_selected = { guifg = colors.black2, guibg = colors.nord_blue },
		tab_close = { guifg = colors.red, guibg = colors.black },
	},
})

require("which-key").register({
	["gD"] = { "<Cmd>BufferLinePickClose<CR>", "bufferline: delete buffer" },
	["gb"] = { "<Cmd>BufferLinePick<CR>", "bufferline: pick buffer" },
	["<tab>"] = { "<Cmd>BufferLineCycleNext<CR>", "bufferline: next" },
	["<S-tab>"] = { "<Cmd>BufferLineCyclePrev<CR>", "bufferline: prev" },
	["]]"] = { "<Cmd>BufferLineCycleNext<CR>", "bufferline: next" },
	["[["] = { "<Cmd>BufferLineCyclePrev<CR>", "bufferline: prev" },
	["[b"] = { "<Cmd>BufferLineMoveNext<CR>", "bufferline: move next" },
	["]b"] = { "<Cmd>BufferLineMovePrev<CR>", "bufferline: move prev" },
	["<leader>1"] = { "<Cmd>BufferLineGoToBuffer 1<CR>", "which_key_ignore" },
	["<leader>2"] = { "<Cmd>BufferLineGoToBuffer 2<CR>", "which_key_ignore" },
	["<leader>3"] = { "<Cmd>BufferLineGoToBuffer 3<CR>", "which_key_ignore" },
	["<leader>4"] = { "<Cmd>BufferLineGoToBuffer 4<CR>", "which_key_ignore" },
	["<leader>5"] = { "<Cmd>BufferLineGoToBuffer 5<CR>", "which_key_ignore" },
	["<leader>6"] = { "<Cmd>BufferLineGoToBuffer 6<CR>", "which_key_ignore" },
	["<leader>7"] = { "<Cmd>BufferLineGoToBuffer 7<CR>", "which_key_ignore" },
	["<leader>8"] = { "<Cmd>BufferLineGoToBuffer 8<CR>", "which_key_ignore" },
	["<leader>9"] = { "<Cmd>BufferLineGoToBuffer 9<CR>", "bufferline: goto 9" },
})

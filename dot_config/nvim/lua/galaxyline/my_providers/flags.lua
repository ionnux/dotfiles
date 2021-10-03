local paste = function()
	if vim.o.paste then
		return "paste"
	else
		return ""
	end
end

local mode = function()
	local mode = vim.api.nvim_eval("mode()")
	if mode == "v" then
		return "--TERMINAL--"
	end
end

return { paste = paste, mode = mode }

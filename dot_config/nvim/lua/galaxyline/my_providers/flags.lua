local paste = function()
  if (vim.o.paste) then
    return 'paste'
  else
    return ''
  end
end

return {
  paste = paste
}

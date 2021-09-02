require('formatter').setup({
  logging = false,
  filetype = {
      dart = {
        -- dart format
        function()
            return{
              exe = "dart format",
              args = {"--fix"},
              stdin = true,
          }
        end
      },
  }
})

-- format on save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.dart  FormatWrite
augroup END
]], true)

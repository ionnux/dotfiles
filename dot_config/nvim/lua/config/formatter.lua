require('formatter').setup({
  logging = false,
  filetype = {
    dart = {
      -- dart format
      function()
        return {exe = "dart format", args = {"--fix"}, stdin = true}
      end
    },

    lua = {
      function()
        return {
          exe = "lua-format",
          args = {
            "--indent-width=2", "--continuation-indent-width=2",
            "--no-keep-simple-control-bloc-one-line",
            "--no-keep-simple-function-one-line",
          },
          stdin = true
        }
      end
    }
  }
})

-- format on save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.dart,*.lua  FormatWrite
augroup END
]], true)

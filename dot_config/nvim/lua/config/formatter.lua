require( 'formatter' ).setup(
  {
    logging = false,
    filetype = {
      dart = {
        -- dart format
        function()
          return { exe = "dart format", args = { "--fix" }, stdin = true }
        end,
      },

      lua = {
        function()
          return {
            exe = "lua-format",
            args = {
              "-c",
              "/home/og_saaz/.config/nvim/lua/config/lua-format-config-file.yaml",
            },
            stdin = true,
          }
        end,
      },
    },
  }
 )

-- format on save
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.dart,*.lua  FormatWrite
augroup END
]], true
 )
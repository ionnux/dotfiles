require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
}

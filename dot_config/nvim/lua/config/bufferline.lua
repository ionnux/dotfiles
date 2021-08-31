require("bufferline").setup{
  options = {
    --numbers = "buffer_id",
    --number_style = "",
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    seperator_style = "thick"
    },
highlights = {
    -- buffer_selected = {
    --     guifg = "#9ece6a",
    --     guibg = normal_bg,
    --     gui = "bold,italic"
    --     },
    separator = {
        guifg = "#7aa2f7",
        guibg = normal_bg,
        },
    modified = {
        guifg = "#f7768e",
        guibg = normal_bg,
        },
    modified_selected = {
        guifg = "#f7768e",
        guibg = normal_bg,
        },
    },
}

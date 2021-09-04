vim.g.dashboard_default_executive = "telescope"
-- vim.g.dashboard_preview_command = "splashcii"
vim.g.dashboard_preview_pipeline = "lolcat"
-- vim.g.dashboard_preview_file = "beach"
-- vim.g.dashboard_preview_file_height = 20
-- vim.g.dashboard_preview_file_width = 80
vim.g.dashboard_enable_session = 1
vim.g.dashboard_disable_statusline = 0

vim.g.dashboard_custom_header = {
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}

vim.g.dashboard_custom_shortcut = {
  ["last_session"] = "SPC s l",
  ["find_history"] = "SPC f r",
  ["find_file"] = "SPC f f",
  ["new_file"] = "SPC f n",
  ["change_colorscheme"] = "SPC h c",
  ["find_word"] = "SPC f g",
  ["book_marks"] = "SPC f b",
}
vim.g.dashboard_custom_section = {
  a = {
    description = { "  Find File                 SPC f f" },
    command = "Telescope find_files",
  },
  b = {
    description = { "  Recents                   SPC f r" },
    command = "Telescope oldfiles",
  },
  c = {
    description = { "  Find Word                 SPC f g" },
    command = "Telescope live_grep",
  },
  d = {
    description = { "洛 New File                  SPC f n" },
    command = "DashboardNewFile",
  },
  e = {
    description = { "  Bookmarks                 SPC b m" },
    command = "Telescope marks",
  },
  f = {
    description = { "  Load Last Session         SPC q l" },
    command = [[lua require("persistence").load({ last = true })]],
  },
}

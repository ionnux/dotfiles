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
  ["find_history"] = "SPC t r",
  ["find_file"] = "SPC t f",
  ["new_file"] = "SPC f n",
  ["change_colorscheme"] = "SPC h c",
  ["find_word"] = "SPC t g",
  ["book_marks"] = "SPC f b",
}
vim.g.dashboard_custom_section = {
  a = { description = { "  Recents                   SPC t r" }, command = "Telescope frecency" },
  b = { description = { "  Projects                  SPC t p" }, command = "Telescope projects theme=get_dropdown" },
  c = {
    description = { "  Load Last Session         SPC q l" },
    command = [[lua require("persistence").load({ last = true })]],
  },
  d = { description = { "  Find File                 SPC t f" }, command = "Telescope find_files" },
  e = { description = { "  Find Word                 SPC t g" }, command = "Telescope live_grep" },
  f = { description = { "洛 New File                  SPC f n" }, command = "DashboardNewFile" },
  g = { description = { "  Bookmarks                 SPC t m" }, command = "Telescope marks" },
}

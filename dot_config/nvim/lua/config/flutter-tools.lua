require("flutter-tools").setup{
widget_guides = {
  enabled = true,
  },
dev_tools = {
  autostart = false,
  auto_open_browser = false,
  },
--dev_log = {
  --open_cmd = "tabedit", -- command to use to open the log buffer
  --},
outline = {
  open_cmd = "50vnew", -- command to use to open the outline buffer
  auto_open = false -- if true this will open the outline automatically when it is first populated
      },
} -- use defaults

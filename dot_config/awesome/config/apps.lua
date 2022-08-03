local join = require("gears").table.join
local scratchpad = require("modules.scratchpad")
local terminal = "/home/og_saaz/.local/kitty.app/bin/kitty  "

local default_apps = {
  terminal = terminal,
  web_browser = "vivaldi",
  launcher = "/home/og_saaz/.config/rofi/scripts/launcher.sh",
  editor = terminal .. "-e nvim",
  music_player = terminal .. "-e ncmpcpp",
  file_manager = terminal .. " env TERM=kitty-direct -e ~/.config/vifm/scripts/vifmrun ",
}

local default_scratchpad_config = {
  sticky = false,
  autoclose = true,
  floating = true,
  reapply = true,
  focus_before_close = true,
  geometry = { position = "bottom", size = 900 },
  border_color = "#6e6a86",
}

local scratchpad_apps_config = {
  terminal1 = join(
    default_scratchpad_config,
    { command = terminal .. "--title terminal_1 --class scratchpad", rule = { name = "terminal_1" } }
  ),

  terminal2 = join(default_scratchpad_config, {
    command = terminal .. "--title terminal_2 --class scratchpad",
    rule = { name = "terminal_2" },
    border_color = "#9d7cd8",
  }),

  music_player = join(default_scratchpad_config, {
    command = terminal
      .. "--title music_player --class scratchpad -e ~/.config/ncmpcpp/ncmpcpp-ueberzug/ncmpcpp-ueberzug",
    rule = { name = "music_player" },
    geometry = { position = "bottom", size = 420 },
  }),

  file_manager = join(default_scratchpad_config, {
    command = terminal
      .. "--title file_manager --class scratchpad -e env TERM=kitty-direct ~/.config/vifm/scripts/vifmrun",
    rule = { name = "file_manager" },
  }),

  resource_monitor = join(default_scratchpad_config, {
    command = terminal .. "--title resource_monitor --class scratchpad -e btop",
    rule = { name = "resource_monitor" },
  }),

  git = join(default_scratchpad_config, {
    command = terminal .. "--title git --class scratchpad -e lazygit",
    rule = { name = "git" },
  }),
}

local scratchpad_apps = {
  music_player = scratchpad:new(scratchpad_apps_config.music_player),
  resource_monitor = scratchpad:new(scratchpad_apps_config.resource_monitor),
  terminal1 = scratchpad:new(scratchpad_apps_config.terminal1),
  terminal2 = scratchpad:new(scratchpad_apps_config.terminal2),
  file_manager = scratchpad:new(scratchpad_apps_config.file_manager),
  git = scratchpad:new(scratchpad_apps_config.git),
}

return { default = default_apps, scratchpad = scratchpad_apps }

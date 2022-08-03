-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, "luarocks.loader")

require("rules")
require("signals")
require("vi")
-- load theme
local beautiful = require("beautiful")
-- local gears = require("gears")
local awful = require("awful")
local gfs = require("gears.filesystem")

-- theme
-- local theme = "amarena"
beautiful.init(gfs.get_configuration_dir() .. "themes/" .. "theme.lua")
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- load key and mouse bindings
require("bindings")

local notification_themes = {
  "lovelace", -- 1 -- Plain with standard image icons
  "ephemeral", -- 2 -- Outlined text icons and a rainbow stripe
  "amarena", -- 3 -- Filled text icons on the right, text on the left
}
local notification_theme = notification_themes[3]
local notifications = require("modules.notifications")
-- notifications.init(notification_theme)

-- init apps
awful.spawn.with_shell("pkill --signal=9 sxhkd; sxhkd -c ~/.config/awesome/sxhkdrc")
awful.spawn.with_shell("picom --experimental-backends")
awful.spawn.with_shell("~/.fehbg &")

-- Garbage collection
-- Enable for lower memory consumption
-- ===================================================================

-- collectgarbage("setpause", 160)
-- collectgarbage("setstepmul", 400)

-- collectgarbage("setpause", 110)
-- collectgarbage("setstepmul", 1000)

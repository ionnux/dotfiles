local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local vars = require("config.vars")
local widgets = require("widgets")

-- screen.connect_signal("request::wallpaper", function(s)
--   awful.wallpaper({
--     screen = s,
--     widget = {
--       {
--         image = "/home/og_saaz/Pictures/Wallpapers/cosmic cliffs (small).png",
--         -- image = "/home/og_saaz/Pictures/Wallpapers/cosmic cliffs.png",
--         resize = true,
--         -- upscale = true,
--         -- downscale = true,
--         widget = wibox.widget.imagebox,
--       },
--       horizontal_fit_policy = "fit",
--       vertical_fit_policy = "fit",
--       valign = "center",
--       halign = "center",
--       tiled = false,
--       widget = wibox.container.tile,
--     },
--   })
-- end)

screen.connect_signal("request::desktop_decoration", function(s)
  awful.tag(vars.tags, s, awful.layout.layouts[1])
  s.promptbox = widgets.create_promptbox()
  s.layoutbox = widgets.create_layoutbox(s)
  s.taglist = widgets.create_taglist(s)
  s.tasklist = widgets.create_tasklist(s)
  s.wibox = widgets.create_wibox(s)
end)

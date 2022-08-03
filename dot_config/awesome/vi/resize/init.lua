local mode = require("vi.mode")
local awful = require("awful")

local resize_bindings = {
  h = function(_)
    local c = client.focus
    if c.floating then
      c:relative_move(0, 0, -5, 0)
    else
      awful.tag.incmwfact(-0.025)
    end
  end,

  l = function(_)
    local c = client.focus
    if c.floating then
      c:relative_move(0, 0, 5, 0)
    else
      awful.tag.incmwfact(0.025)
    end
  end,

  k = function(_)
    local c = client.focus
    if c.floating then
      c:relative_move(0, 0, 0, -5)
    else
      awful.client.incwfact(0.025)
    end
  end,

  j = function(_)
    local c = client.focus
    if c.floating then
      c:relative_move(0, 0, 0, 5)
    else
      awful.client.incwfact(-0.025)
    end
  end,

  m = function(self)
    mode.change_mode(self, mode.mode_list.move.keygrabber)
  end,
}

mode.create_mode("resize", resize_bindings, {
  keybindings = {
    awful.key({
      modifiers = { "Mod4" },
      description = "activate resize mode",
      group = "vi mode",
      key = "r",
      on_press = function() end,
    }),
  },
}, true)

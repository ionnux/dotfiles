local mode = require("vi.mode")
local awful = require("awful")

local move_bindings = {
  h = function(_)
    local c = client.focus
    if c.floating then
      c:relative_move(-10, 0, 0, 0)
    else
      awful.client.swap.global_bydirection("left", c)
    end
  end,

  l = function(_)
    local c = client.focus
    if c.floating then
      c:relative_move(10, 0, 0, 0)
    else
      awful.client.swap.global_bydirection("right", c)
    end
  end,

  k = function(_)
    local c = client.focus
    if c.floating then
      c:relative_move(0, -10, 0, 0)
    else
      awful.client.swap.global_bydirection("up", c)
    end
  end,

  j = function(_)
    local c = client.focus
    if c.floating then
      c:relative_move(0, 10, 0, 0)
    else
      awful.client.swap.global_bydirection("down", c)
    end
  end,

  r = function(self, _)
    mode.change_mode(self, mode.mode_list.resize.keygrabber)
  end,
}

mode.create_mode("move", move_bindings, {
  keybindings = {
    awful.key({
      modifiers = { "Mod1", "Shift" },
      description = "activate move mode",
      group = "vi mode",
      key = "Tab",
      on_press = function() end,
    }),
  },
}, true)

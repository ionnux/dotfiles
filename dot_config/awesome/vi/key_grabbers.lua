-- local mod = require("bindings.mod")
local awful = require("awful")
-- local gears = require("gears")
-- local naughty = require("naughty")
local actions = require("vi.actions")
local modes = {}

local function change_mode(current_keygrabber, new_keygrabber)
  current_keygrabber:stop()
  new_keygrabber:start()
end

local function keypressed_callback(current_keygrabber, key, mode_name)
  if key == "k" then
    actions[mode_name].up()
  elseif key == "j" then
    actions[mode_name].down()
  elseif key == "l" then
    actions[mode_name].right()
  elseif key == "h" then
    actions[mode_name].left()
  end
end

modes.move = {
  name = "move",
  keygrabber = awful.keygrabber({
    keybindings = {
      awful.key({
        modifiers = { "Mod1", "Shift" },
        key = "Tab",
        on_press = function() end,
      }),
    },

    keypressed_callback = function(self, _, key, _)
      if key == "r" then
        change_mode(self, modes.resize.keygrabber)
      else
        keypressed_callback(self, key, modes.move.name)
      end
    end,
    stop_key = "q",
    stop_event = "release",
    export_keybindings = true,
  }),
}
modes.resize = {
  name = "resize",
  keygrabber = awful.keygrabber({
    keybindings = {
      awful.key({
        modifiers = { "Mod1" },
        key = "Tab",
        on_press = function() end,
      }),
    },
    -- Note that it is using the key name and not the modifier name.
    keypressed_callback = function(self, mod, key, _)
      if key == "m" then
        change_mode(self, modes.move.keygrabber)
      else
        keypressed_callback(self, key, modes.resize.name)
      end
    end,
    stop_key = "q",
    stop_event = "release",
    export_keybindings = true,
  }),
}

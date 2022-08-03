local awful = require("awful")
-- local naughty = require("naughty")
local gears = require("gears")
-- local actions = require("vi.actions")
local mode_list = {}

local function action_with_repetition(repetition, action)
  for _ = 1, repetition do
    action()
  end
end

local function parse_keys(keygrabber, mode_bindings, key, concat_number_string, enable_repeat, last_action)
  local repetition = 1
  if type(key) == "string" and tonumber(key) ~= nil then
    concat_number_string = concat_number_string .. key
  else
    if key == "." then
      if enable_repeat and last_action ~= nil then
        if tonumber(concat_number_string) ~= nil then
          last_action.repetition = tonumber(concat_number_string) * last_action.repetition
          concat_number_string = ""
        end
        -- naughty.notification({ message = tostring(last_action.repetition) })

        mode_bindings[key](keygrabber, last_action)
        repetition = 1
      end
    else
      if tonumber(concat_number_string) ~= nil then
        repetition = tonumber(concat_number_string)
        concat_number_string = ""
      end

      if mode_bindings[key] ~= nil then
        action_with_repetition(repetition, function()
          mode_bindings[key](keygrabber)
        end)

        last_action = {
          repetition = repetition,
          action = function(current_keygrabber)
            mode_bindings[key](current_keygrabber)
          end,
        }
      end
    end
  end
  return concat_number_string, last_action
end

local repeat_keybinding = {
  ["."] = function(keygrabber, last_action)
    action_with_repetition(last_action.repetition, function()
      last_action.action(keygrabber)
    end)
  end,
}

local function create_mode(mode_name, mode_bindings, keygrabber_config, enable_repeat)
  mode_bindings = gears.table.join(mode_bindings, repeat_keybinding)
  -- naughty.notification({ message = "aaa" })
  local concat_number_string = ""
  local last_action = nil
  mode_list[mode_name] = {
    name = mode_name,
    keygrabber = awful.keygrabber(gears.table.join({
      keypressed_callback = function(self, _, key, _)
        concat_number_string, last_action =
          parse_keys(self, mode_bindings, key, concat_number_string, enable_repeat, last_action)
      end,
      stop_key = { "q", "Escape", "Enter" },
      stop_event = "release",
      export_keybindings = true,
    }, keygrabber_config)),
  }
end

local function change_mode(current_keygrabber, new_keygrabber)
  current_keygrabber:stop()
  new_keygrabber:start()
end

return {
  mode_list = mode_list,
  create_mode = create_mode,
  change_mode = change_mode,
}

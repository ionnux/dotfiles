local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local ruled = require("ruled")

local Scratchpad = {}

--- Checks whether the passed client is a childprocess of a given process ID
--
-- @param c A client
-- @param pid The process ID
-- @return True if the passed client is a childprocess of the given PID otherwise false
local function is_child_of(c, pid)
  -- io.popen is normally discouraged. Should probably be changed
  if not c or not c.valid then
    return false
  end
  if tostring(c.pid) == tostring(pid) then
    return true
  end
  local pid_cmd = [[pstree -T -p -a -s ]] .. tostring(c.pid) .. [[ | sed '2q;d' | grep -o '[0-9]*$' | tr -d '\n']]
  local handle = io.popen(pid_cmd)
  local parent_pid = handle:read("*a")
  handle:close()
  return tostring(parent_pid) == tostring(pid) or tostring(parent_pid) == tostring(c.pid)
end

local function toggle_off(c)
  c:tags({})
  c.sticky = false
  client.emit_signal("turn_off", c)
end

--- Creates a new scratchpad object based on the argument
--
-- @param args A table of possible arguments
-- @return The new scratchpad object
function Scratchpad:new(args)
  args = args or {}

  local ret = gears.object({})
  gears.table.crush(ret, Scratchpad)
  gears.table.crush(ret, args)

  return ret
end

--- Search for clients that match all the rule given
--
-- @param rule the rule to search for
-- @return a table of matched clients
local function find(rule)
  local function filter(c)
    return ruled.client.match(c, rule)
  end

  local matches = {}
  for c in awful.client.iterate(filter) do
    table.insert(matches, c)
  end

  return matches
end

--- Find all clients that satisfy the the rule
--
-- @return A list of all clients that satisfy the rule
function Scratchpad:find()
  return find(self.rule)
end

local function get_placement_geometry(args)
  local geometry = {}
  if args.size ~= nil then
    if args.position == "top" or args.position == "bottom" or args.position == "center" then
      geometry.height = args.size
    end
    if args.position == "left" or args.position == "right" or args.position == "center" then
      geometry.width = args.size
    end
  end

  local placement = {
    top = awful.placement.top + awful.placement.maximize_horizontally,
    bottom = awful.placement.bottom + awful.placement.maximize_horizontally,
    left = awful.placement.left + awful.placement.maximize_vertically,
    right = awful.placement.right + awful.placement.maximize_vertically,
    center = awful.placement.centered,
  }
  geometry.placement = placement[args.position]
  return geometry
end

--- Applies the objects scratchpad properties to a given client
--
-- @param c A client to which to apply the properties
function Scratchpad:apply(c)
  if c and c.valid then
    c.floating = self.floating
    c.sticky = self.sticky
    c.fullscreen = false
    c.maximized = false

    if self.border_color then
      c.border_color = self.border_color
    end

    local geometry = {}

    if self.geometry.position and self.geometry.size then
      geometry = get_placement_geometry({
        auto_placement = true,
        position = self.geometry.position,
        size = self.geometry.size,
      })
      awful.rules.execute(c, geometry)
    elseif self.geometry.x and self.geometry.y and self.geometry.height and self.geometry.width then
      c:geometry(self.geometry)
    else
      naughty.notification({ title = "Scratchpad Error", message = "geometrical error" })
    end

    if self.autoclose then
      c:connect_signal("unfocus", function(c1)
        toggle_off(c1)
      end)
    end
  end
end

--- Turns the scratchpad on
function Scratchpad:toggle_on()
  local c = self:find()[1]

  if c and c.first_tag and c.first_tag.selected then
    c:raise()
    client.focus = c
    return
  end

  if c then
    -- if a client was found, turn it on
    if self.reapply then
      self:apply(c)
    end
    -- c.sticky was set to false in turn_off so it has to be reapplied anyway
    c.sticky = self.sticky

    local current_tag = c.screen.selected_tag
    c:tags({ current_tag })
    c:raise()
    client.focus = c
    self:emit_signal("turn_on", c)

    return
  end

  -- if no client was found, spawn one, find the corresponding window,
  --  apply the properties only once (until the next closing)
  if not c then
    local pid = awful.spawn.with_shell(self.command)
    local function inital_apply(c1)
      if is_child_of(c1, pid) then
        c = c1
        self:apply(c1)
        self:emit_signal("inital_apply", c1)
        client.disconnect_signal("manage", inital_apply)
      end
    end
    client.connect_signal("manage", inital_apply)
  end
end

--- Turns the scratchpad off
function Scratchpad:toggle_off()
  local c = self:find()[1]
  if c then
    toggle_off(c)
  end
end

--- Turns the scratchpad off if it is focused otherwise it raises the scratchpad
function Scratchpad:toggle()
  local should_toggle_off = false
  local c = self:find()[1]

  if self.focus_before_close then
    should_toggle_off = client.focus and awful.rules.match(client.focus, self.rule)
  else
    if c then
      if c.sticky and #c:tags() > 0 then
        should_toggle_off = true
      else
        local current_tag = c.screen.selected_tag
        if c.first_tag == current_tag then
          should_toggle_off = true
        else
          should_toggle_off = false
        end
      end
    end
  end

  if should_toggle_off then
    self:toggle_off()
  else
    self:toggle_on()
  end
end

return Scratchpad

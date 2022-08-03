local awful = require("awful")
local resize = {
  left = function()
    local c = client.focus
    if c.floating then
      c:relative_move(0, 0, -5, 0)
    else
      awful.tag.incmwfact(-0.025)
    end
  end,

  right = function()
    local c = client.focus
    if c.floating then
      c:relative_move(0, 0, 5, 0)
    else
      awful.tag.incmwfact(0.025)
    end
  end,

  up = function()
    local c = client.focus
    if c.floating then
      c:relative_move(0, 0, 0, -5)
    else
      awful.client.incwfact(0.025)
    end
  end,

  down = function()
    local c = client.focus
    if c.floating then
      c:relative_move(0, 0, 0, 5)
    else
      awful.client.incwfact(-0.025)
    end
  end,
}

local move = {
  left = function()
    local c = client.focus
    if c.floating then
      c:relative_move(-10, 0, 0, 0)
    else
      awful.client.swap.global_bydirection("left")
    end
  end,

  right = function()
    local c = client.focus
    if c.floating then
      c:relative_move(10, 0, 0, 0)
    else
      awful.client.swap.global_bydirection("right")
    end
  end,

  up = function()
    local c = client.focus
    if c.floating then
      c:relative_move(0, -10, 0, 0)
    else
      awful.client.swap.global_bydirection("up")
    end
  end,

  down = function()
    local c = client.focus
    if c.floating then
      c:relative_move(0, 10, 0, 0)
    else
      awful.client.swap.global_bydirection("down")
    end
  end,
}

return {
  move = move,
  resize = resize,
}

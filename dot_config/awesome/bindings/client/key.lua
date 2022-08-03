local awful = require("awful")
local mod = require("bindings.mod")

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({

    -- window state
    awful.key({
      modifiers = { mod.super },
      key = "q",
      description = "terminate client",
      group = "client",
      on_press = function(c)
        awesome.kill(c.pid, 15)
      end,
    }),
    awful.key({
      modifiers = { mod.super, mod.shift },
      key = "q",
      description = "kill client",
      group = "client",
      on_press = function(c)
        awesome.kill(c.pid, 9)
      end,
    }),
    awful.key({
      modifiers = { mod.super },
      key = "o",
      description = "toggle floating",
      group = "client",
      on_press = awful.client.floating.toggle,
    }),
    awful.key({
      modifiers = { mod.super, mod.shift },
      key = "Return",
      description = "move to master",
      group = "client",
      on_press = function(c)
        c:swap(awful.client.getmaster())
      end,
    }),
    -- awful.key({
    --   modifiers = { mod.super },
    --   key = "o",
    --   description = "move to screen",
    --   group = "client",
    --   on_press = function(c)
    --     c:move_to_screen()
    --   end,
    -- }),

    -- resize window
    awful.key({ mod.super, mod.ctrl }, "k", function(c)
      if c.floating then
        c:relative_move(0, 0, 0, -10)
      else
        awful.client.incwfact(0.025)
      end
    end, { description = "Floating Resize Vertical -", group = "client" }),

    awful.key({ mod.super, mod.ctrl }, "j", function(c)
      if c.floating then
        c:relative_move(0, 0, 0, 10)
      else
        awful.client.incwfact(-0.025)
      end
    end, { description = "Floating Resize Vertical +", group = "client" }),
    awful.key({ mod.super, mod.ctrl }, "h", function(c)
      if c.floating then
        c:relative_move(0, 0, -10, 0)
      else
        awful.tag.incmwfact(-0.025)
      end
    end, { description = "Floating Resize Horizontal -", group = "client" }),
    awful.key({ mod.super, mod.ctrl }, "l", function(c)
      if c.floating then
        c:relative_move(0, 0, 10, 0)
      else
        awful.tag.incmwfact(0.025)
      end
    end, { description = "Floating Resize Horizontal +", group = "client" }),

    -- Moving floating windows
    awful.key({ mod.super, mod.shift }, "j", function(c)
      c:relative_move(0, 10, 0, 0)
    end, { description = "Floating Move Down", group = "client" }),
    awful.key({ mod.super, mod.shift }, "k", function(c)
      c:relative_move(0, -10, 0, 0)
    end, { description = "Floating Move Up", group = "client" }),
    awful.key({ mod.super, mod.shift }, "h", function(c)
      c:relative_move(-10, 0, 0, 0)
    end, { description = "Floating Move Left", group = "client" }),
    awful.key({ mod.super, mod.shift }, "l", function(c)
      c:relative_move(10, 0, 0, 0)
    end, { description = "Floating Move Right", group = "client" }),

    -- Moving window focus works between desktops
    awful.key({ mod.super }, "j", function(c)
      awful.client.focus.global_bydirection("down")
      c:lower()
    end, { description = "focus next window up", group = "client" }),
    awful.key({ mod.super }, "k", function(c)
      awful.client.focus.global_bydirection("up")
      c:lower()
    end, { description = "focus next window down", group = "client" }),
    awful.key({ mod.super }, "l", function(c)
      awful.client.focus.global_bydirection("right")
      c:lower()
    end, { description = "focus next window right", group = "client" }),
    awful.key({ mod.super }, "h", function(c)
      awful.client.focus.global_bydirection("left")
      c:lower()
    end, { description = "focus next window left", group = "client" }),

    -- Moving windows between positions works between desktops
    awful.key({ mod.super, "Shift" }, "h", function(c)
      awful.client.swap.global_bydirection("left")
      c:raise()
    end, { description = "swap with left client", group = "client" }),
    awful.key({ mod.super, "Shift" }, "l", function(c)
      awful.client.swap.global_bydirection("right")
      c:raise()
    end, { description = "swap with right client", group = "client" }),
    awful.key({ mod.super, "Shift" }, "j", function(c)
      awful.client.swap.global_bydirection("down")
      c:raise()
    end, { description = "swap with down client", group = "client" }),
    awful.key({ mod.super, "Shift" }, "k", function(c)
      awful.client.swap.global_bydirection("up")
      c:raise()
    end, { description = "swap with up client", group = "client" }),

    -- awful.key({
    --   modifiers = { mod.super },
    --   key = "t",
    --   description = "toggle keep on top",
    --   group = "client",
    --   on_press = function(c)
    --     c.ontop = not c.ontop
    --   end,
    -- }),
    -- awful.key({
    --   modifiers = { mod.super },
    --   key = "n",
    --   description = "minimize",
    --   group = "client",
    --   on_press = function(c)
    --     c.minimized = true
    --   end,
    -- }),

    -- Maximize unmaximize
    awful.key({
      modifiers = { mod.super },
      key = "m",
      description = "(un)fullscreen",
      group = "client",
      on_press = function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
    }),
    awful.key({
      modifiers = { mod.super, mod.shift },
      key = "m",
      description = "(un)maximize",
      group = "client",
      on_press = function(c)
        c.maximized = not c.maximized
        c:raise()
      end,
    }),
    -- awful.key({
    --   modifiers = { mod.super, mod.ctrl },
    --   key = "m",
    --   description = "(un)maximize vertically",
    --   group = "client",
    --   on_press = function(c)
    --     c.maximized_vertical = not c.maximized_vertical
    --     c:raise()
    --   end,
    -- }),
    -- awful.key({
    --   modifiers = { mod.super, mod.shift },
    --   key = "m",
    --   description = "(un)maximize horizontally",
    --   group = "client",
    --   on_press = function(c)
    --     c.maximized_horizontal = not c.maximized_horizontal
    --     c:raise()
    --   end,
    -- }),
  })
end)

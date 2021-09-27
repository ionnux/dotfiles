require( "flutter-tools" ).setup {
  ui = {
    -- the border type to use for all floating windows, the same options/formats
    -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
    border = "shadow",
  },
  decorations = {
    statusline = {
      -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
      -- this will show the current version of the flutter app from the pubspec.yaml file
      app_version = true,
      -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
      -- this will show the currently running device if an application was started with a specific
      -- device
      device = true,
    },
  },
  debugger = { -- integrate with nvim dap + install dart code debugger
    enabled = false,
  },
  -- flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
  -- flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
  widget_guides = { enabled = true },
  closing_tags = {
    highlight = "Comment", -- highlight for the closing tag
    prefix = "> ", -- character to use for close tag e.g. > Widget
    enabled = true, -- set to false to disable
  },
  dev_log = {
    open_cmd = "tabedit", -- command to use to open the log buffer
  },
  dev_tools = {
    autostart = false, -- autostart devtools server if not detected
    auto_open_browser = false, -- Automatically opens devtools in the browser
  },
  outline = {
    open_cmd = "50vnew", -- command to use to open the outline buffer
    auto_open = false, -- if true this will open the outline automatically when it is first populated
  },
  lsp = {
    -- on_attach = my_custom_on_attach,
    -- capabilities = my_custom_capabilities -- e.g. lsp_status capabilities
    --- OR you can specify a function to deactivate or change or control how the config is created
    -- capabilities = function(config)
    -- config.specificThingIDontWant = false
    -- return config
    -- end,
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      -- analysisExcludedFolders = {<path-to-flutter-sdk-packages>}
    },
  },
}

local wk = require( "which-key" )
wk.register(
  {
    ["<leader>"] = {
      f = {
        name = "Flutter",
        r = {
          name = "Flutter: Run",
          r = { "<cmd>FlutterRun<cr>", "Flutter: Run" },
          d = {
            "<cmd>FlutterRun --flavor development --target lib/main_development.dart<cr>",
            "Flutter: Run Development",
          },
          s = { "<cmd>FlutterRun --flavor staging --target lib/main_staging.dart<cr>", "Flutter: Run Staging" },
          p = { "<cmd>FlutterRun --flavor production --target lib/main_production.dart<cr>", "Flutter: Run Production" },
        },
        R = { "<cmd>FlutterRestart<cr>", "Flutter: Restart" },
        e = { "<cmd>FlutterEmulators<cr>", "Flutter: Emulators" },
        d = { "<cmd>FlutterDevices<cr>", "Flutter: Devices" },
        l = { name = "log", c = { "<cmd>FlutterLogClear<cr>", "Flutter: Clear Log" } },
        o = { "<cmd>FlutterOutlineToggle<cr>", "Flutter: Toggle Outline" },
        y = { "<cmd>FlutterCopyProfilerUrl<cr>", "Flutter: Yank Profiler Url" },
        v = { "<cmd>FlutterVisualDebug<cr>", "Flutter: Enable Visual Debug" },
        p = {
          name = "Pub",
          g = { "<cmd>FlutterPubGetd<cr>", "Flutter: Pub Get" },
          u = { "<cmd>FlutterPubUpgrade<cr>", "Flutter: Pub Upgrade" },
        },
      },
    },
  }
 )

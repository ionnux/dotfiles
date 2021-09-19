-- local flags = require( 'galaxyline/my_providers/flags' )
local gl = require( 'galaxyline' )

local colors = require( 'galaxyline.theme' ).default
local theme_colors = require( 'colors' )
for i, v in pairs( theme_colors ) do colors[i] = v end
-- colors.bg = "None"

local condition = require( 'galaxyline.condition' )
local gls = gl.section
gl.short_line_list = { 'NvimTree', 'Mundo', 'MundoDiff', 'vista', 'dbui', 'packer' }

gls.left[1] = { RainbowRed = { provider = function() return '▊ ' end, highlight = { colors.blue, colors.bg } } }
gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local vim_mode = {
        ['c'] = { 'COMMAND-LINE', colors.magenta },
        ['ce'] = { 'NORMAL EX', colors.red },
        ['cv'] = { 'EX', colors.red },
        ['i'] = { 'INSERT', colors.green },
        ['ic'] = { 'INS-COMPLETE', colors.yellow },
        ['n'] = { 'NORMAL', colors.blue },
        ['no'] = { 'OPERATOR-PENDING', colors.red },
        ['r'] = { 'HIT-ENTER', colors.cyan },
        ['r?'] = { ':CONFIRM', colors.cyan },
        ['rm'] = { '--MORE', colors.cyan },
        ['R'] = { 'REPLACE', colors.violet },
        ['Rv'] = { 'VIRTUAL', colors.violet },
        ['s'] = { 'SELECT', colors.orange },
        ['S'] = { 'SELECT', colors.orange },
        [''] = { 'SELECT', colors.orange },
        ['t'] = { 'TERMINAL', colors.red },
        ['v'] = { 'VISUAL', colors.blue },
        ['V'] = { 'VISUAL LINE', colors.blue },
        [''] = { 'VISUAL BLOCK', colors.blue },
        ['!'] = { 'SHELL', colors.red },
      }

      -- local mode_color = {
      --   n = colors.red,
      --   i = colors.green,
      --   v = colors.blue,
      --   [''] = colors.blue,
      --   V = colors.blue,
      --   c = colors.magenta,
      --   no = colors.red,
      --   s = colors.orange,
      --   S = colors.orange,
      --   [''] = colors.orange,
      --   ic = colors.yellow,
      --   R = colors.violet,
      --   Rv = colors.violet,
      --   cv = colors.red,
      --   ce = colors.red,
      --   r = colors.cyan,
      --   rm = colors.cyan,
      --   ['r?'] = colors.cyan,
      --   ['!'] = colors.red,
      --   t = colors.red,
      -- }

      vim.api.nvim_command( 'hi GalaxyViMode guifg=' .. vim_mode[vim.fn.mode()][2] )
      return ' ' .. vim_mode[vim.fn.mode()][1] .. ' '
    end,
    highlight = { colors.red, colors.bg, 'bold' },
  },
}

-- gls.left[3] = {
--   FileSize = {
--     provider = 'FileSize',
--     condition = condition.buffer_not_empty,
--     highlight = { colors.fg, colors.bg },
--   },
-- }

gls.left[4] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = { require( 'galaxyline.provider_fileinfo' ).get_file_icon_color, colors.bg },
  },
}

gls.left[5] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = { colors.magenta, colors.bg, 'bold' },
  },
}

gls.left[6] = {
  LineInfo = {
    provider = 'LineColumn',
    condition = condition.buffer_not_empty,
    separator = ' ',
    separator_highlight = { 'NONE', colors.bg },
    highlight = { colors.fg, colors.bg },
  },
}

-- gls.left[7] = {
--   PerCent = {
--     provider = 'LinePercent',
--     separator = ' ',
--     separator_highlight = { 'NONE', colors.bg },
--     highlight = { colors.fg, colors.bg, 'bold' },
--   },
-- }

gls.left[8] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    condition = condition.buffer_not_empty,
    icon = '  ',
    highlight = { colors.red, colors.bg },
  },
}
gls.left[9] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    condition = condition.buffer_not_empty,
    icon = '  ',
    highlight = { colors.yellow, colors.bg },
  },
}

gls.left[10] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    condition = condition.buffer_not_empty,
    icon = '  ',
    highlight = { colors.cyan, colors.bg },
  },
}

gls.left[11] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    condition = condition.buffer_not_empty,
    icon = '  ',
    highlight = { colors.blue, colors.bg },
  },
}

gls.left[12] = {
  Paste = {
    provider = function()
      if (vim.o.paste) then
        return ' --PASTE-- '
      else
        return ''
      end
    end,
    -- icon = '▊',
    condition = condition.buffer_not_empty,
    highlight = { colors.red, colors.bg, 'bold' },
  },
}

-- gls.left[13] = {
--   treesitterStatusline = {
--     provider = function()
--       return require( "nvim-treesitter" ).statusline(
--         {
--           indicator_size = 50,
--           type_patterns = { 'class', 'function', 'method' },
--           transform_fn = function( line ) return line:gsub( '%s*[%[%(%{]*%s*$', '' ) end,
--           separator = ' > ',
--
--         }
--        )
--     end,
--     condition = condition.buffer_not_empty,
--     highlight = { colors.blue, colors.bg, 'bold' },
--   },
-- }

gls.mid[1] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function()
      local tbl = { ['dashboard'] = true, [''] = false, ['toggleterm'] = true }
      if tbl[vim.bo.filetype] then return false end
      return true
    end,
    icon = ' LSP:',
    highlight = { colors.cyan, colors.bg, 'bold' },
  },
}

-- gls.right[1] = {
--   FileEncode = {
--     provider = 'FileEncode',
--     condition = condition.hide_in_width,
--     separator = ' ',
--     separator_highlight = {'NONE',colors.bg},
--     highlight = {colors.green,colors.bg,'bold'}
--   }
-- }

-- gls.right[2] = {
--     FileFormat = {
--         provider = 'FileFormat',
--         condition = condition.hide_in_width,
--         separator = ' ',
--         separator_highlight = {'NONE',colors.bg},
--         highlight = {colors.green,colors.bg,'bold'}
--     }
-- }

gls.right[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = { 'NONE', colors.bg },
    highlight = { colors.blue, colors.bg, 'bold' },
  },
}

gls.right[2] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = { 'NONE', colors.bg },
    highlight = { colors.violet, colors.bg, 'bold' },
  },
}

gls.right[3] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = { colors.violet, colors.bg, 'bold' },
  },
}

gls.right[4] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '   ',
    highlight = { colors.green, colors.bg },
  },
}
gls.right[7] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = '  柳',
    highlight = { colors.blue, colors.bg },
  },
}
gls.right[8] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '   ',
    highlight = { colors.red, colors.bg },
  },
}

gls.right[9] = {
  RainbowBlue = { provider = function() return '  ▊' end, highlight = { colors.blue, colors.bg, 'bold' } },
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = { 'NONE', colors.bg },
    highlight = { colors.blue, colors.bg, 'bold' },
  },
}

gls.short_line_left[2] = {
  SFileName = {
    provider = 'SFileName',
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.bg, 'bold' },
  },
}

gls.short_line_right[1] = { BufferIcon = { provider = 'BufferIcon', highlight = { colors.fg, colors.bg } } }

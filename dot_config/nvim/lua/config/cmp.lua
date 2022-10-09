local luasnip = require('luasnip')
local cmp = require('cmp')
local lspkind = require('lspkind')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local kind_icons = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = 'ﴯ',
  Interface = '',
  Module = '',
  Property = 'ﰠ',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

local feedkey = function(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), 'n', true)
end

local function toggleCmp()
  if cmp.visible() then
    cmp.close()
  else
    cmp.complete()
  end
end

cmp.setup({
  enabled = function()
    -- disable completion in comments
    local context = require('cmp.config.context')
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
    end
  end,
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

      -- For `luasnip` user.
      require('luasnip').lsp_expand(args.body)

      -- For `ultisnips` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    -- ["<C-k>"] = cmp.mapping.scroll_docs(-4),
    -- ["<C-j>"] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping(toggleCmp, { 'i' }),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),

    ['<Tab>'] = cmp.mapping(function()
      if luasnip.jumpable() then
        luasnip.jump(1)
      else
        vim.cmd('Tabout')
      end
    end, {
      'i',
      's',
    }),

    ['<S-Tab>'] = cmp.mapping(function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        vim.cmd('TaboutBack')
      end
    end, {
      'i',
      's',
    }),
  }),

  -- documentation = {
  -- 	border = "single",
  -- 	-- winhighlight = "NormalFloat:NormalFloat,FloatBorder:LspSagaHoverBorder",
  -- 	maxwidth = 70,
  -- 	maxheight = 20,
  -- },
  window = {
    completion = {
      border = 'rounded',
      scrollbar = '║',
    },
    documentation = {
      border = 'rounded',
      scrollbar = '║',
    },
  },
  formatting = {
    format = lspkind.cmp_format({
      preset = 'default',
      mode = 'symbol_text',
      -- maxwidth = 50,
      menu = {
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
        path = '[Path]',
        calc = '[calc]',
        fish = '[fish]',
      },
      symbol_map = {
        Text = ' ',
        Method = ' ',
        Function = ' ',
        Constructor = ' ',
        Field = ' ',
        Variable = ' ',
        Class = ' ',
        Interface = ' ',
        Module = ' ',
        Property = ' ',
        Unit = ' ',
        Value = ' ',
        Enum = ' ',
        Keyword = ' ',
        Snippet = ' ',
        Color = ' ',
        File = ' ',
        Reference = ' ',
        Folder = ' ',
        EnumMember = ' ',
        Constant = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
      },
    }),
  },
  -- formatting = {
  -- format = function(entry, vim_item)
  --   -- fancy icons and a name of kind
  --   vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. ' ' .. vim_item.kind
  --   -- vim_item.kind = kind_icons[vim_item.kind] .. " " or ""
  --   -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)

  --   -- set a name for each source
  --   vim_item.menu = ({
  --     buffer = '[Buffer]',
  --     nvim_lsp = '[LSP]',
  --     luasnip = '[LuaSnip]',
  --     nvim_lua = '[Lua]',
  --     path = '[Path]',
  --     calc = '[calc]',
  --   })[entry.source.name]
  --   return vim_item
  -- end,
  -- },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 2 },
    { name = 'luasnip', priority = 3 },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua', priority = 3 },
    { name = 'fish' },
    { name = 'buffer', priority = 1 },
    { name = 'path', options = { trailing_slash = true }, priority = 1 },
    { name = 'calc', priority = 1 },
  }),

  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  -- view = {
  --   entries = { name = 'wildmenu' },
  -- },
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' },
  }, {
    { name = 'buffer' },
  }),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  -- view = {
  --   entries = { name = 'wildmenu' },
  -- },
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

-- nvim autopair
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

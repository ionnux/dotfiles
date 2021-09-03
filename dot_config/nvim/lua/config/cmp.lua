local luasnip = require 'luasnip'
local cmp = require 'cmp'

local check_back_space = function()
  local col = vim.fn.col( '.' ) - 1
  return col == 0 or vim.fn.getline( '.' ):sub( col, col ):match( '%s' )
end

cmp.setup {
  snippet = {
    expand = function( args )
      -- require('luasnip').lsp_expand(args.body)
      vim.fn["vsnip#anonymous"]( args.body )
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-j>'] = cmp.mapping.scroll_docs( -4 ),
    ['<C-k>'] = cmp.mapping.scroll_docs( 4 ),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm(
      { behavior = cmp.ConfirmBehavior.Replace, select = true }
     ),
    ['<Tab>'] = function( fallback )
      -- if vim.fn.pumvisible() == 1 then
      --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      if luasnip.jumpable( 1 ) then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            '<Plug>luasnip-jump-next', true, true, true
           ), ''
         )
      elseif check_back_space() then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes( '<Tab>', true, true, true ), 'n'
         )
      elseif vim.fn['vsnip#jumpable']() == 1 then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            '<Plug>(vsnip-jump-next)', true, true, true
           ), ''
         )
      else
        fallback()
      end
    end,

    ['<S-Tab>'] = function( fallback )
      -- if vim.fn.pumvisible() == 1 then
      --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      if luasnip.jumpable( 1 ) then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            '<Plug>luasnip-jump-prev', true, true, true
           ), ''
         )
      elseif vim.fn['vsnip#jumpable']() == 1 then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            '<Plug>(vsnip-jump-prev)', true, true, true
           ), ''
         )
      else
        fallback()
      end
    end,
  },

  documentation = {
    border = "single",
    winhighlight = 'NormalFloat:None,FloatBorder:LspSagaHoverBorder',
    maxwidth = 150,
    maxheight = 20,
  },

  formatting = {
    format = function( entry, vim_item )
      -- fancy icons and a name of kind
      vim_item.kind =
        require( "lspkind" ).presets.default[vim_item.kind] .. " " ..
          vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        vsnip = "[Vsnip]",
        path = "[Path]",
        calc = "[calc]",
      })[entry.source.name]
      return vim_item
    end,
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'calc' },
  },
}

-- nvim-autopairs settings for nvim-cmp
require( "nvim-autopairs.completion.cmp" ).setup(
  {
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` after select function or method item
    auto_select = true, -- automatically select the first item
  }
 )

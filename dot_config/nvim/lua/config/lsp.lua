local borders = require("config.borders")
local util = require("lspconfig/util")

-- -- diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
  float = {
    source = "always",
    border = borders.plus,
  },
})

-- Change diagnostic symbols in the sign column (gutter)
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local signs = { Error = "■", Warn = "■", Hint = "■", Info = "■" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
  noremap = true,
  silent = true,
  desc = "lsp: goto next diagnostic",
})
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
  noremap = true,
  silent = true,
  desc = "lsp: goto previous diagnostics",
})
vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, {
  noremap = true,
  silent = true,
  desc = "lsp: show line diagnostics",
})

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = "lsp: goto declaration",
  })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = "lsp: goto definition",
  })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = "lsp: hover",
  })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = "lsp: implementation",
  })
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = "lsp: signature help",
  })
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = "lsp: add workspace folder",
  })
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = "lsp: remove workspace folder",
  })
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = "lsp: list workspace folder",
  })
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = "lsp: type definition",
  })
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = "lsp: rename",
  })
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, buffer = bufnr })
  -- vim.keymap.set("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<cr>", {
  --   noremap = true,
  --   silent = true,
  --   buffer = bufnr,
  --   desc = "telescope: code action",
  -- }) --use telescope

  vim.keymap.set("n", "gr", vim.lsp.buf.references, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = "lsp: goto references",
  })
  vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = "lsp: format",
  })

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
      false
    )
  end
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- -- peak definition
-- local function preview_location_callback(_, result)
--   if result == nil or vim.tbl_isempty(result) then
--     return nil
--   end
--   vim.lsp.util.preview_location(result[1])
-- end

-- function PeekDefinition()
--   local params = vim.lsp.util.make_position_params()
--   return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
-- end

-- -- keymaps
-- local on_attach = function(client, bufnr)
--   --keymap settings
--   local function buf_set_keymap(...)
--     vim.api.nvim_buf_set_keymap(bufnr, ...)
--   end
--   --buffer options
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end

-- border settings
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = borders.plus }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = borders.plus }),
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require("lspconfig")
lspconfig["bashls"].setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  flags = lsp_flags,
})
lspconfig["sumneko_lua"].setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  flags = lsp_flags,
  root_dir = util.root_pattern(".luarc.json", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", ".git"),
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        path = "?/init.lua",
      },
      format = { enable = true },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          "vim",
          "awesome",
          "client",
          "root",
          "screen",
          "mouse",
        },
      },
      workspace = {
        --   -- Make the server aware of Neovim runtime files
        checkThirdParty = false,
        --   library = vim.api.nvim_get_runtime_file("", true),
        library = {
          -- ["~/.config/nvim/"] = true,
          ["/usr/share/awesome/lib"] = true,
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

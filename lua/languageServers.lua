local configs = require('lspconfig.configs')
local util = require('lspconfig.util')
local lspconfig = require('lspconfig')

if not configs.helm_ls then
  configs.helm_ls = {
    default_config = {
      cmd = { "helm_ls", "serve" },
      filetypes = { 'helm', 'tpl' },
      root_dir = function(fname)
        return util.root_pattern('Chart.yaml')(fname)
      end,
    },
  }
end

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

local opts = { noremap = true, silent = true }

local global_keybinds = {
  ["gD"] = "<cmd>lua vim.lsp.buf.type_definition()<CR>",
  ["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>", -- leaving this here in case telescope doesnt work
  ["K"] = "<cmd>lua vim.lsp.buf.hover()<CR>",
  ["<space>we"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>",
  ["<space>wa"] = "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
  ["<space>wr"] = "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
  ["<space>wl"] = "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
  ["<space>rn"] = "<cmd>lua vim.lsp.buf.rename()<CR>",
  ["<space>ca"] = "<cmd>lua vim.lsp.buf.code_action()<CR>",
}

require('elixir').setup()

local servers = {
  'golangci_lint_ls',
  'gopls',
  'rust_analyzer',
  -- 'helm_ls', -- custom setup() above
  'ts_ls',
  'angularls',
  'elixirls',
  -- 'lua_ls', -- custom setup() above
  -- 'clangd',
  'ccls',
  -- 'pyright',
  'pylyzer',
  'terraformls',
  'yamlls',
  'bashls',
  'gleam',
  'nil_ls',
}

--
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local base_on_attach = function(client, bufnr)
  for key, action in pairs(global_keybinds) do
    vim.api.nvim_buf_set_keymap(bufnr, 'n', key, action, opts)
  end
  require('lsp_signature').on_attach(client, bufnr)
end

-- for completions

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = base_on_attach,
    capabilities = capabilities,
  }
end

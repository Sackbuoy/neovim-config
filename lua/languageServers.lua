local configs = require('lspconfig.configs')
local util = require('lspconfig.util')

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

if not configs.golangcilsp then
 	configs.golangcilsp = {
		default_config = {
			cmd = {'golangci-lint-langserver'},
			root_dir = util.root_pattern('.git', 'go.mod'),
			init_options = {
					command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json", "--issues-exit-code=1" };
			}
		};
	}
end


local opts = { noremap = true, silent = true }

local global_keybinds = {
  ["gD"] = "<cmd>lua vim.lsp.buf.declaration()<CR>",
  ["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>", -- leaving this here in case telescope doesnt work
  ["K"] = "<cmd>lua vim.lsp.buf.hover()<CR>",
  ["<C-k>"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>",
  ["<space>wa"] = "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
  ["<space>wr"] = "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
  ["<space>wl"] = "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
  ["<space>rn"] = "<cmd>lua vim.lsp.buf.rename()<CR>",
  ["<space>ca"] = "<cmd>lua vim.lsp.buf.code_action()<CR>",
}


local servers = {
  'golangci_lint_ls',
  'gopls',
  'rust_analyzer',
  'helm_ls',
  'tsserver',
  'angularls',
}

local lspconfig = require 'lspconfig'
--
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local base_on_attach = function(client, bufnr)
  for key, action in pairs(global_keybinds) do
    vim.api.nvim_buf_set_keymap(bufnr, 'n', key, action, opts)
  end
  require('lsp_signature').on_attach(client, bufnr)
end

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = base_on_attach,
  }
end


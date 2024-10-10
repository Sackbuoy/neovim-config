--   'golangci_lint_ls',
--   'gopls',
--   'rust_analyzer',
--   -- 'helm_ls',
--   'ts_ls',
--   'angularls',
--   'elixirls',
--   -- 'lua_ls',
--   -- 'clangd',
--   'ccls',
--   -- 'pyright',
--   'pylyzer',
--   'terraformls',
--   'yamlls',
--   'bashls',
--   'gleam',
--   'nil_ls',

local servers = {
  gopls = {
    name = "gopls",
    cmd = "gopls",
    root_dir = vim.fs.find({ "go.work", "go.mod", ".git" }, { upward = true })[1],
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    formatter = {
      filetypes = { "*.go" },
      cmd = "golangci-lint run --fix",
    },
  },
  rust_analyzer = {
    name = "rust-analyzer",
    cmd = "rust-analyzer",
    root_dir = vim.fs.find({ "cargo.toml", ".git" }, { upward = true })[1],
    filetypes = { "rust" },
    formatter = {
      filetypes = { "*.rs" },
      cmd = "rustfmt",
    },
  },
  pylyzer = {
    name = "pylyzer",
    cmd = "pylyzer",
    root_dir = vim.fs.find({ "requirements.txt", ".git" }, { upward = true })[1],
    filetypes = { "python" },
    formatter = {
      filetypes = { "*.py" },
      cmd = "black",
    },
  },
  pyright = {
    name = "pyright",
    cmd = "pyright",
    root_dir = vim.fs.find({ "requirements.txt", ".git" }, { upward = true })[1],
    filetypes = { "python" },
    formatter = {
      filetypes = { "*.py" },
      cmd = "black",
    },
  },
}

local autocmd = vim.api.nvim_create_autocmd
for _, lsp in pairs(servers) do
  autocmd("FileType", {
    pattern = lsp.filetypes,
    callback = function()
      local client = vim.lsp.start({
          name = lsp.name,
          cmd = { lsp.cmd },
          root_dir = lsp.root_dir,
      })
      vim.lsp.buf_attach_client(0, client)
    end
  })
  autocmd("BufWritePost", {
    pattern = lsp.formatter.filetypes,
    callback = function()
      command = string.format("silent !%s", lsp.formatter.cmd) 
      vim.cmd(command)
      vim.cmd("edit")
    end
  })
end


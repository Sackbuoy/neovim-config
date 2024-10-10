--   "golangci_lint_ls",
--   "gopls",
--   "rust_analyzer",
--   -- "helm_ls",
--   "ts_ls",
--   "angularls",
--   "elixirls",
--   -- "lua_ls",
--   -- "clangd",
--   "ccls",
--   -- "pyright",
--   "pylyzer",
--   "terraformls",
--   "yamlls",
--   "bashls",
--   "gleam",
--   "nil_ls",

local servers = {
  gopls = {
    name = "gopls",
    cmd = { "gopls", "serve" },
    root_dir = vim.loop.cwd(),
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    autoformat = false,
    formatter = {
      filetypes = { "*.go" },
      cmd = "golangci-lint run --fix",
    },
  },
  golanci_lint_ls = {
    name = "golangci-lint-ls",
    cmd = { "golangci-lint-langserver" },
    root_dir = vim.loop.cwd(),
    filetypes = { "go", "gomod" },
    formatter = {
      filetypes = { "*.go" },
      cmd = "",
    },
    init_options = {
      command = {"golangci-lint", "run", "--out-format", "json" },
    },
  },
  rust_analyzer = {
    name = "rust-analyzer",
    cmd = { "rust-analyzer" },
    root_dir = vim.loop.cwd(),
    filetypes = { "rust" },
    formatter = {
      filetypes = { "*.rs" },
      cmd = "rustfmt",
    },
  },
  pylyzer = {
    name = "pylyzer",
    cmd = { "pylyzer", "--server" },
    root_dir = vim.loop.cwd(),
    filetypes = { "python" },
    formatter = {
      filetypes = { "*.py" },
      cmd = "black",
    },
  },
  elixir_ls = {
    name = "elixir-ls",
    cmd = { "elixir-ls" },
    root_dir = vim.loop.cwd(),
    filetypes = { "elixir" },
    formatter = {
      filetypes = { "*.ex", "*.exs" },
      cmd = "mix format",
    },
  },
  terraformls = {
    name = "terraform-ls",
    cmd = { "terraform-ls", "serve" },
    root_dir = vim.loop.cwd(),
    filetypes = { "terraform", "terraform-vars", "hcl" },
    formatter = {
      filetypes = { "*.tf" },
      cmd = "terraform fmt",
    },
  },
  typescript_language_server = {
    name = "typescript-language-server",
    cmd = { "typescript-language-server", "--stdio" },
    root_dir = vim.loop.cwd(),
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    formatter = {
      filetypes = { "*.ts", "*.tsx" },
      cmd = "prettier --write",
    },
  },
  angularls = {
    name = "angular-ls",
    cmd = { "ngserver", "--stdio", "--tsProbeLocations", vim.fn.getcwd(), "--ngProbeLocations", vim.fn.getcwd() },
    root_dir = vim.loop.cwd(),
    filetypes = { "angular" },
    formatter = {
      filetypes = { "*.ts", "*.html" },
      cmd = "prettier --write",
    },
  },
  bash_language_server = {
    name = "bash-language-server",
    cmd = { "bash-language-server", "start" },
    root_dir = vim.loop.cwd(),
    filetypes = { "sh" },
    formatter = {
      filetypes = { "*.sh" },
      cmd = "",
    },
  },
  gleamls = {
    name = "gleam-ls",
    cmd = { "gleamlsp" }, -- this isnt expanding the args for some reason so i made this binary
    root_dir = vim.loop.cwd(),
    filetypes = { "gleam" },
    formatter = {
      filetypes = { "*.gleam" },
      cmd = "gleam format",
    },
  },
  lua_ls = {
    name = "lua-ls",
    cmd = { "lua-language-server" },
    root_dir = vim.loop.cwd(),
    filetypes = { "lua" },
    formatter = {
      filetypes = { "*.lua" },
      cmd = "lua-format",
    },
  },
  helm_ls = {
    name = "helm-ls",
    cmd = { "helm_ls", "serve" },
    root_dir = vim.loop.cwd(),
    filetypes = { "helm", "yaml" },
    formatter = {
      filetypes = { "*.helm" },
      cmd = "helm lint",
    },
  },
  yaml_ls = {
    name = "yaml-ls",
    cmd = { "yamlls" }, -- not expanding args either
    root_dir = vim.loop.cwd(),
    filetypes = { "yaml" },
    formatter = {
      filetypes = { "*.yaml", "*.yml" },
      cmd = "prettier --write",
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
        cmd = lsp.cmd,
        root_dir = lsp.root_dir,
        init_options = lsp.init_options,
      })
      vim.lsp.buf_attach_client(0, client)

      vim.api.nvim_create_user_command("Fmt", 
        function()
          command = string.format("silent !%s", cmd)
          vim.cmd(command)
          vim.cmd("edit")
        end, {}
      )
    end
  })
  if lsp.autoformat then
    autocmd("BufWritePost", {
      pattern = lsp.formatter.filetypes,
      callback = function()
        command = string.format("silent !%s", lsp.formatter.cmd)
        vim.cmd(command)
        vim.cmd("edit")
      end
    })
  end
end


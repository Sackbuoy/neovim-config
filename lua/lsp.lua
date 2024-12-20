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
--
--
local formatcommandlist = {}
local autoformatcommandlist = {}
local runformatcommands = function(cmdList)
  for _, cmd in pairs(cmdList) do
    cmd.cmd()
  end
end

local gci = function()
  vim.cmd('echo "gci"')
  vim.cmd('silent !golangci-lint run --fix --disable-all --enable gci')
end

local goimports = function()
  vim.cmd('echo "goimports"')
  vim.cmd('silent !goimports -w '..vim.fn.expand("%"))
end

local golangcilintfix = function()
  vim.cmd('echo "golangci-lint"')
  vim.cmd('silent !golangci-lint run --fix '..vim.fn.expand("%"))
end

local servers = {
  gopls = {
    name = "gopls",
    cmd = { "gopls", "serve" },
    root_dir = vim.loop.cwd(),
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    formatters = {
      filetypes = { "*.go" },
      formatcommands = {
        {
          name = "goimports",
          cmd = goimports,
          autoformat = false,
        },
        -- {
        --   name = "gci",
        --   cmd = gci,
        --   autoformat = true,
        -- },
      },
    },
  },
  golanci_lint_ls = {
    name = "golangci-lint-ls",
    cmd = { "golangci-lint-langserver" },
    root_dir = vim.loop.cwd(),
    filetypes = { "go", "gomod" },
    formatters = {
      filetypes = { "*.go" },
      formatcommands = {
        {
          name = "golangcilint",
          cmd = golangcilintfix,
          autoformat = false,
        },
      },
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
    formatters = {
      filetypes = { "*.rs" },
      commands = {
        "rustfmt",
      },
    },
  },
  pylyzer = {
    name = "pylyzer",
    cmd = { "pylyzer", "--server" },
    root_dir = vim.loop.cwd(),
    filetypes = { "python" },
    formatters = {
      filetypes = { "*.py" },
      commands = {
        "black",
      },
    },
  },
  -- elixir_ls = {
  --   name = "elixir-ls",
  --   cmd = { "elixir-ls" },
  --   root_dir = vim.loop.cwd(),
  --   filetypes = { "elixir" },
  --   formatters = {
  --     filetypes = { "*.ex", "*.exs" },
  --     commands = {
    --     "mix format",
  --     },
  --   },
  -- },
  lexical = {
    name = "lexical",
    cmd = { "start_lexical.sh" }, -- this is weird, symlink doesnt work
    root_dir = vim.loop.cwd(),
    filetypes = { "elixir" },
    formatters = {
      filetypes = { "*.lexical" },
      -- commands = { "lexical format" },
    },
  },
  erlang_ls = {
    name = "erlang-ls",
    cmd = { "erlang_ls" },
    root_dir = vim.loop.cwd(),
    filetypes = { "erlang" },
    formatters = {
      filetypes = { "*.erl" },
      commands = { "erl_tidy" },
    },
  },
  terraformls = {
    name = "terraform-ls",
    cmd = { "terraform-ls", "serve" },
    root_dir = vim.loop.cwd(),
    filetypes = { "terraform", "terraform-vars", "hcl" },
    formatters = {
      filetypes = { "*.tf" },
      commands = { "terraform fmt" },
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
    formatters = {
      filetypes = { "*.ts", "*.tsx" },
      commands = { "prettier --write" },
    },
  },
  angularls = {
    name = "angular-ls",
    cmd = { "ngserver", "--stdio", "--tsProbeLocations", vim.fn.getcwd(), "--ngProbeLocations", vim.fn.getcwd() },
    root_dir = vim.loop.cwd(),
    filetypes = { "angular" },
    formatters = {
      filetypes = { "*.ts", "*.html" },
      commands = { "prettier --write" },
    },
  },
  bash_language_server = {
    name = "bash-language-server",
    cmd = { "bash-language-server", "start" },
    root_dir = vim.loop.cwd(),
    filetypes = { "sh" },
    formatters = {
      filetypes = { "*.sh" },
      commands = { "" },
    },
  },
  gleamls = {
    name = "gleam-ls",
    cmd = { "gleamlsp" }, -- this isnt expanding the args for some reason so i made this binary
    root_dir = vim.loop.cwd(),
    filetypes = { "gleam" },
    formatters = {
      filetypes = { "*.gleam" },
      commands =  {"gleam format" },
    },
  },
  lua_ls = {
    name = "lua-ls",
    cmd = { "lua-language-server" },
    root_dir = vim.loop.cwd(),
    filetypes = { "lua" },
    formatters = {
      filetypes = { "*.lua" },
      commands = { "lua-format" },
    },
  },
  helm_ls = {
    name = "helm-ls",
    cmd = { "helm_ls", "serve" },
    root_dir = vim.loop.cwd(),
    filetypes = { "helm", "yaml" },
    formatters = {
      filetypes = { "*.yaml", "*.yml", ".tpl" },
      commands = { "helm lint" },
    },
  },
  -- yaml_ls = {
  --   name = "yaml-ls",
  --   cmd = { "yamlls" }, -- not expanding args either
  --   root_dir = vim.loop.cwd(),
  --   filetypes = { "yaml" },
  --   formatters = {
  --     filetypes = { "*.yaml", "*.yml" },
  --     commands = { "prettier --write" },
  --   },
  -- },
}

local autocmd = vim.api.nvim_create_autocmd
local formattergroup = vim.api.nvim_create_augroup('formattergroup', { clear = true })
local autoformattergroup = vim.api.nvim_create_augroup('autoformattergroup', { clear = true })
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

      if (lsp.formatters ~= nil and lsp.formatters.formatcommands ~= nil) then
        for _, formatter in pairs(lsp.formatters.formatcommands) do

          if (formatter.autoformat) then
            autoformatcommandlist[formatter.name] = { cmd = formatter.cmd }
            -- autoformatcommandlist.insert(formatter, { cmd = formatter.cmd })
          else
            formatcommandlist[formatter.name] =  { cmd = formatter.cmd }
          end
        end
      end

      vim.lsp.buf_attach_client(0, client)

      vim.api.nvim_create_user_command("Fmt",
        function()
          runformatcommands(formatcommandlist)
        end, {}
      )
    end
  })

  autocmd("BufWritePost", {
    pattern = lsp.formatters.filetypes,
    group = formattergroup,
    callback = function()
      runformatcommands(autoformatcommandlist)
    end
  })
end

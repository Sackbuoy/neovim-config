return {
  cmd = {
    "emmylua_ls"
  },
  filetypes = {
    "lua"
  },
  root_markers = {
    ".git",
    ".emmyrc.json",
    ".luacheckrc",
    ".luarc.json",
    ".luarc.jsonc",
    ".stylua.toml",
    "selene.toml",
    "selene.yml",
    "stylua.toml"
  },
  settings = {
    emmylua = {
      format = {
        externalTool = {
          program = "luafmt",
          args = { "--stdin" },
          timeout = 5000
        }
      },
      runtime = {
        version = 'LuaJIT'
      },
      diagnostics = {
        --     disable = { "missing-parameters", "missing-fields" },
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true)
      }
    }
  },
  on_attach = function (client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function ()
        vim.lsp.buf.format({ async = false })
      end
    })
  end,

  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning
}

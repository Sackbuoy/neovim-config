return {
  cmd = { "golangci-lint-langserver" },
  filetypes = { "go", "gomod" },
  root_markers = {
    "go.mod",
    ".golangci.yml",
    ".golangci.yaml",
    ".git",
  },
  init_options = {
    command = { "golangci-lint", "run", "--output.json.path", "stdout", "--show-stats=false" },
  },
  on_attach = function(client, bufnr)
    vim.o.autoread = true
    local root = client.config.root_dir
    local group = vim.api.nvim_create_augroup("GolangciFix_" .. bufnr, { clear = true })
    local debounce_timer = nil

    local function reload_if_clean(target_bufnr, filename)
      vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(target_bufnr) then return end
        if vim.api.nvim_buf_get_name(target_bufnr) ~= filename then return end
        if vim.bo[target_bufnr].modified then return end
        vim.cmd("silent! checktime")
      end)
    end

    vim.api.nvim_create_autocmd("BufWritePost", {
      group = group,
      buffer = bufnr,
      callback = function()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local pkg_dir = vim.fn.fnamemodify(filename, ":h")

        -- Tier 1: instant, file-scoped formatters
        vim.fn.jobstart({ "golangci-lint", "fmt", filename }, {
          cwd = root,
          on_exit = function() reload_if_clean(bufnr, filename) end,
        })

        -- Tier 2: debounced, package-scoped type-aware fixers
        if debounce_timer then
          debounce_timer:stop()
        end
        debounce_timer = vim.defer_fn(function()
          vim.fn.jobstart({ "golangci-lint", "run", "--fix", pkg_dir .. "/..." }, {
            cwd = root,
            on_exit = function() reload_if_clean(bufnr, filename) end,
          })
        end, 500)
      end,
    })
  end,
}

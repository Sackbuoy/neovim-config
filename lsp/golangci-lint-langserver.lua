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
    -- vim.api.nvim_create_autocmd("BufWritePost", {
    --   buffer = bufnr,
    --   callback = function()
    --     local filename = vim.fn.expand("%:p")
    --     vim.fn.system({ "gci", "write", "--skip-generated", filename })
    --     vim.cmd("silent! checktime")
    --   end,
    -- })
    -- Run golangci-lint --fix asynchronously after the file is written
    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = bufnr,
      callback = function()
        local filename = vim.fn.expand("%:p")
        vim.fn.jobstart({ "golangci-lint", "run", "--fix", filename }, {
          on_exit = function()
            vim.schedule(function()
              vim.cmd("silent! checktime")
            end)
          end,
        })
      end,
    })
  end,
}

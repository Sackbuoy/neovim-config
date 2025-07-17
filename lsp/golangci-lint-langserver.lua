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
   vim.api.nvim_create_autocmd("BufWritePre", {
     buffer = bufnr,
     callback = function()
       local filename = vim.fn.expand("%")
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

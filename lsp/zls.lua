return {
 cmd = { "zls" },
 filetypes = { "zig" },
 root_markers = {
   "*.zig",
   ".git",
 },
 on_attach = function(client, bufnr)
   vim.api.nvim_create_autocmd("BufWritePre", {
     buffer = bufnr,
     callback = function()
       vim.lsp.buf.format({ async = true })
     end,
   })
 end,
}

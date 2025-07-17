return {
 cmd = { "lexical" },
 filetypes = { "elixir", "eex", "heex", "surface" },
 root_markers = {
   "mix.exs",
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

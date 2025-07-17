return {
 cmd = { "rust-analyzer" },
 filetypes = { "rust" },
 root_markers = {
   "Cargo.toml",
   "rust-project.json",
 },
 settings = {
   ["rust-analyzer"] = {
     cargo = {
       allFeatures = true,
     },
     checkOnSave = {
       command = "clippy",
     },
     rustfmt = {
       extraArgs = { "+nightly" }, -- optional, for nightly rustfmt features
     },
   },
 },
  on_attach = function(client, bufnr)
   -- Auto-format on save
   vim.api.nvim_create_autocmd("BufWritePre", {
     buffer = bufnr,
     callback = function()
       vim.lsp.buf.format({ async = false })
     end,
   })
 end,
}

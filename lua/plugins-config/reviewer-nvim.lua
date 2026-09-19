vim.opt.runtimepath:prepend("/home/sackbuoy/Dev/goofin/reviewer-nvim")
require('reviewer-nvim').setup({
  enabled = true,
  picker = "telescope"
})

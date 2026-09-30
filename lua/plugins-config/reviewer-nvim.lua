vim.opt.runtimepath:prepend("~/Dev/goofin/reviewer-nvim")
require('reviewer-nvim').setup({
  enabled              = true,
  picker               = "telescope",
  default_split        = "vsplit",    -- "edit" | "split" | "vsplit" | "tab"
  checkout_on_load     = true,     -- git checkout source branch when a review is loaded
  auto_show_discussion = true, -- open discussion popup when jumping to a discussion line
  highlights           = {
    addition = { bg = "#1a3a1a" },   -- custom green
    deletion = { bg = "#3a1a1a" },   -- custom red
    changed  = { link = "CurSearch" } -- reuse another group
  },
  indicators           = {
    discussion_hl    = { fg = "#ffaa00", bold = true },
    deletion_sign_hl = { link = "DiffDelete" }
  }
})

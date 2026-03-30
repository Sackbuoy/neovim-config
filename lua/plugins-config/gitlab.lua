vim.api.nvim_set_hl(0, "DiffviewDiffAddMuted",    { bg = "#1a3a2a" })  -- soft green
vim.api.nvim_set_hl(0, "DiffviewDiffDeleteMuted",  { bg = "#3a1a1a" })  -- soft red
vim.api.nvim_set_hl(0, "DiffviewDiffChangeMuted",  { bg = "#2a2a1a" })  -- soft olive
vim.api.nvim_set_hl(0, "DiffviewDiffTextMuted",    { bg = "#3a3a2a" })  -- slightly brighter for inline changes

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "DiffviewDiffAddMuted",    { bg = "#1a3a2a" })
    vim.api.nvim_set_hl(0, "DiffviewDiffDeleteMuted",  { bg = "#3a1a1a" })
    vim.api.nvim_set_hl(0, "DiffviewDiffChangeMuted",  { bg = "#2a2a1a" })
    vim.api.nvim_set_hl(0, "DiffviewDiffTextMuted",    { bg = "#3a3a2a" })
  end,
})
require('diffview').setup({
  enhanced_diff_hl = true,
  hooks = {
    diff_buf_read = function(bufnr, ctx)
      -- Override diff highlights in every diff buffer
      vim.opt_local.winhl = table.concat({
        "DiffAdd:DiffviewDiffAddMuted",
        "DiffDelete:DiffviewDiffDeleteMuted",
        "DiffChange:DiffviewDiffChangeMuted",
        "DiffText:DiffviewDiffTextMuted",
      }, ",")
    end,
  },
})
require('gitlab').setup()


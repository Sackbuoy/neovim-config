require("diffview").setup({
  enhanced_diff_hl = true,
  use_icons = true,
  view = {
    default = { layout = "diff2_horizontal" },
    merge_tool = { layout = "diff3_horizontal" },
  },
  file_panel = {
    listing_style = "tree",
    win_config = { position = "right", width = 35 }, -- Use "auto" to fit content
  },
  hooks = {},   -- See :h diffview-config-hooks
  keymaps = {}, -- See :h diffview-config-keymaps
})

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     vim.api.nvim_set_hl(0, "DiffAdd", {bg = "#20303b"})
--     vim.api.nvim_set_hl(0, "DiffDelete", {bg = "#37222c"})
--     vim.api.nvim_set_hl(0, "DiffChange", {bg = "#1f2231"})
--     vim.api.nvim_set_hl(0, "DiffText", {bg = "#394b70"})
--     -- vim.api.nvim_set_hl(0, "DiffAdd",    { bg = "NvimDarkGreen", fg = "NONE" })
--     -- vim.api.nvim_set_hl(0, "DiffText",    { bg = "#5a2a2a", fg = "NONE" }) -- red: changed/removed text (left window)
--     -- vim.api.nvim_set_hl(0, "DiffTextAdd", { bg = "#2a5a2a", fg = "NONE" }) -- green: purely added text (right window)
--     -- vim.api.nvim_set_hl(0, "DiffText",   { bg = "NONE",          fg = "NONE" }) -- same
--     -- vim.api.nvim_set_hl(0, "DiffDelete", { bg = "NONE",          fg = "NONE" }) -- same
--   end,
-- })

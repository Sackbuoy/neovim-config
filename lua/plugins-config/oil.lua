require('oil').setup({
  use_default_keymaps = false,
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-h>"] = "<cmd>lua require('smart-splits').move_cursor_left()<CR>",
    ["<C-l>"] = "<cmd>lua require('smart-splits').move_cursor_right()<CR>",
    ["<C-j>"] = "<cmd>lua require('smart-splits').move_cursor_down()<CR>",
    ["<C-k>"] = "<cmd>lua require('smart-splits').move_cursor_up()<CR>",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["<leader>s"] = { "actions.select", opts = { vertical = true } },
    ["<leader>h"] = { "actions.select", opts = { horizontal = true } },
  },
})

local smartsplits = require('smart-splits')
vim.keymap.set('n', '<A-h>', smartsplits.resize_left)
vim.keymap.set('n', '<A-j>', smartsplits.resize_down)
vim.keymap.set('n', '<A-k>', smartsplits.resize_up)
vim.keymap.set('n', '<A-l>', smartsplits.resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', smartsplits.move_cursor_left)
vim.keymap.set('n', '<C-j>', smartsplits.move_cursor_down)
vim.keymap.set('n', '<C-k>', smartsplits.move_cursor_up)
vim.keymap.set('n', '<C-l>', smartsplits.move_cursor_right)
vim.keymap.set('n', '<C-\\>', smartsplits.move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', smartsplits.swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', smartsplits.swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', smartsplits.swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', smartsplits.swap_buf_right)

smartsplits.setup()

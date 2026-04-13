-- require('nvim-treesitter').setup({
--   install_dir = vim.fn.stdpath('data') .. '/site',
-- })
--
-- -- Install the parsers you want
-- require('nvim-treesitter').install({
--   'lua', 'go', 'javascript', 'typescript', 'python', 'json', 'yaml', 'markdown',
-- })
--
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'TelescopePreviewerLoaded',
--   callback = function()
--     local buf = vim.api.nvim_get_current_buf()
--     local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
--     if ft and ft ~= '' then
--       vim.treesitter.start(buf, ft)
--     end
--   end
-- })
--
-- vim.api.nvim_create_autocmd('FileType', {
--   callback = function(args)
--     pcall(vim.treesitter.start, args.buf)
--   end,
-- })
require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})
vim.filetype.add({
  extension = {
    tofu = "terraform",
  },
})
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft ~= '' and not ft:match('^Telescope') then
      pcall(vim.treesitter.start, args.buf)
    end
  end,
})

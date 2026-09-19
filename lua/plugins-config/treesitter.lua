require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site'
})
vim.filetype.add({
  extension = {
    tofu = "terraform",
    k = "kcl"
  }
})
vim.api.nvim_create_autocmd('FileType', {
  callback = function (args)
    local ft = vim.bo[args.buf].filetype
    if ft ~= '' and not ft:match('^Telescope') then
      pcall(vim.treesitter.start, args.buf)
    end
  end
})

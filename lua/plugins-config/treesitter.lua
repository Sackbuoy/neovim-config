require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  auto_install = true, --auto install every lang
  highlight = {
    enable = true,
  },
})


-- This file is just for defining what plugins I have, and calling their respective 
-- setup functions
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

  Plug('numToStr/Comment.nvim')
  Plug('preservim/nerdtree')

  -- Plug('MunifTanjim/nui.nvim')
  -- Plug('nvim-tree/nvim-web-devicons')
  -- Plug('nvim-neo-tree/neo-tree.nvim')


  Plug('neovim/nvim-lspconfig')
  Plug('nvim-telescope/telescope.nvim')

  -- 'for' and 'do' are keywords so i gotta do this fuckery
  Plug('nvim-treesitter/nvim-treesitter', {
    -- this commit has a fix for telescope find_files() that fails on lua  otherwise
    -- commit = '668de0951a36ef17016074f1120b6aacbe6c4515',     
    ['do'] = function()
      vim.call(':TSUpdate')
    end
  })

  Plug('f-person/git-blame.nvim')
  Plug('mbbill/undotree')
  Plug('stevearc/aerial.nvim')

  Plug('lewis6991/gitsigns.nvim')

  -- This is for lazy loading plugins? ngl idk
  -- lol literally just a library of random functions
  Plug('nvim-lua/plenary.nvim')

  -- Language specific plugins
  -- Go
  -- Plug('fatih/vim-go', {
  --   ['do'] = function()
  --     vim.call(':GoUpdateBinaries')
  --   end
  -- })
  Plug('meain/vim-jsontogo')

  -- Terraform
  Plug('hashivim/vim-terraform')

  -- Rust
  Plug('rust-lang/rust.vim')
  -- Plug('alx741/vim-rustfmt' -- did some magic to make this always use nightly)
  -- Plug('simrat39/rust-tools.nvim')

  -- JS
  Plug('yuezk/vim-js')
  Plug('HerringtonDarkholme/yats.vim')
  Plug('maxmellon/vim-jsx-pretty')

  -- Elixir
  -- Plug('elixir-tools/elixir-tools.nvim')
  Plug('mhanberg/elixir.nvim')

  -- Gleam
  Plug('gleam-lang/gleam.vim')

  -- Themes
  Plug('dracula/vim', { as = 'dracula' })
  Plug('folke/tokyonight.nvim', { branch = 'main', as = 'tokyonight' })
  Plug('gruvbox-community/gruvbox')
  Plug('whatyouhide/vim-gotham')
  Plug('arcticicestudio/nord-vim')
  Plug('cocopon/iceberg.vim')
  Plug('ayu-theme/ayu-vim')
  Plug('mhartington/oceanic-next')
  Plug('Th3Whit3Wolf/space-nvim')

  -- harpoon navigation
  Plug('ThePrimeagen/harpoon')

  -- dev icons
  Plug('nvim-tree/nvim-web-devicons')

  Plug('j-hui/fidget.nvim', { tag = 'legacy' })

  Plug('tyru/open-browser.vim')
  Plug('tyru/open-browser-github.vim')

  -- For Lsp Installation
  Plug('williamboman/mason.nvim')
  Plug('williamboman/mason-lspconfig.nvim')

  -- signature help
  Plug('ray-x/lsp_signature.nvim')

  -- Copilot
  Plug('github/copilot.vim')

  -- for cheat.sh
  Plug('RishabhRD/popfix')
  Plug('RishabhRD/nvim-cheat.sh')

  Plug('christoomey/vim-tmux-navigator')

  Plug('stevearc/conform.nvim')
  -- other LLM's 
  -- Plug('huynle/ogpt.nvim')
  -- Plug('MunifTanjim/nui.nvim') -- this is a UI library, just a dependency
  --
  -- Plug('ellisonleao/glow.nvim')
  -- Plug('lukas-reineke/headlines.nvim')
  Plug('MeanderingProgrammer/render-markdown.nvim')

  -- Diffs/PR's
  -- Plug('sindrets/diffview.nvim')
  -- Plug('pwntester/octo.nvim')
vim.call('plug#end')

-- require('octo').setup()

require('render-markdown').setup()
require('fidget').setup {}
require('gitsigns').setup()
require('lsp_signature').setup()
require('Comment').setup()
require('mason').setup()
require('mason-lspconfig').setup()
require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  auto_install = true, --auto install every lang
  highlight = {
    enable = true,
  },
})

-- Telescope is special
local telescope = require('telescope')
telescope.setup({
  defaults = {
      file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/", "^plugged/" },
    }
})

telescope.load_extension('aerial')
require('aerial').setup()
-- require('ogpt').setup() -- no clue if this is actually needed
--

local conform = require('conform')
conform.setup({
  formatters_by_ft = {
    go = {'gofumpt'},
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

require('languageServers')


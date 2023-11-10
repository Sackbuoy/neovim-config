-- This file is just for defining what plugins I have, and calling their respective 
-- setup functions
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

  Plug 'numToStr/Comment.nvim'
  Plug 'preservim/nerdtree'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-telescope/telescope.nvim'

  -- 'for' and 'do' are keywords so i gotta do this fuckery
  Plug('nvim-treesitter/nvim-treesitter', { 
    -- this commit has a fix for telescope find_files() that fails on lua  otherwise
    -- commit = '668de0951a36ef17016074f1120b6aacbe6c4515',     
    ['do'] = function() 
      vim.call(':TSUpdate')
    end
  })

  Plug 'f-person/git-blame.nvim'
  Plug 'mbbill/undotree'
  Plug 'stevearc/aerial.nvim'
 
  -- Plug 'github/copilot.vim'
  Plug 'lewis6991/gitsigns.nvim'

  -- This is for lazy loading plugins? ngl idk
  Plug 'nvim-lua/plenary.nvim'

  -- Language specific plugins
  -- Go
  Plug('fatih/vim-go', { 
    ['do'] = function() 
      vim.call(':GoUpdateBinaries')
    end
  })

  -- Terraform
  Plug 'hashivim/vim-terraform'

  -- Rust
  Plug 'rust-lang/rust.vim'
  -- Plug 'alx741/vim-rustfmt' -- did some magic to make this always use nightly
  -- Plug 'simrat39/rust-tools.nvim'

  -- JS
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'

  -- Themes
  Plug('dracula/vim', { as = 'dracula' })
  Plug('folke/tokyonight.nvim', { branch = 'main', as = 'tokyonight' })
  Plug 'gruvbox-community/gruvbox'
  Plug 'whatyouhide/vim-gotham'
  Plug 'arcticicestudio/nord-vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'ayu-theme/ayu-vim'
  Plug 'mhartington/oceanic-next'

  -- harpoon navigation
  Plug 'ThePrimeagen/harpoon'

  -- dev icons
  Plug 'nvim-tree/nvim-web-devicons'

  Plug('j-hui/fidget.nvim', { tag = 'legacy' })

  Plug 'tyru/open-browser.vim'
  Plug 'tyru/open-browser-github.vim'

  -- For Lsp Installation
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'

  -- signature help
  Plug 'ray-x/lsp_signature.nvim'

vim.call('plug#end')

require('fidget').setup {}
require('gitsigns').setup()
require('lsp_signature').setup()
require('Comment').setup()
require('mason').setup()
require('mason-lspconfig').setup()
require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  auto_install = true, --auto install every lang
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

local lsps = require('languageServers')


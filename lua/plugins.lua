-- This file is just for defining what plugins I have, and calling their respective
-- setup functions
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

  Plug('numToStr/Comment.nvim')

  Plug('nvim-telescope/telescope.nvim')

  -- 'for' and 'do' are keywords so i gotta do this fuckery
  Plug('nvim-treesitter/nvim-treesitter')

  Plug('f-person/git-blame.nvim')
  Plug('mbbill/undotree')
  Plug('stevearc/aerial.nvim')

  Plug('lewis6991/gitsigns.nvim')

  -- This is for lazy loading plugins? ngl idk
  -- lol literally just a library of random functions
  -- used by telescope
  Plug('nvim-lua/plenary.nvim')

  Plug('meain/vim-jsontogo')

  -- Themes
  -- Plug('dracula/vim', { as = 'dracula' })
  -- Plug('folke/tokyonight.nvim', { branch = 'main', as = 'tokyonight' })
  -- Plug('gruvbox-community/gruvbox')
  -- Plug('whatyouhide/vim-gotham')
  -- Plug('arcticicestudio/nord-vim')
  -- Plug('cocopon/iceberg.vim')
  -- Plug('ayu-theme/ayu-vim')
  -- Plug('mhartington/oceanic-next')
  Plug('Th3Whit3Wolf/space-nvim')

  -- harpoon navigation
  Plug('ThePrimeagen/harpoon')

  -- dev icons
  Plug('nvim-tree/nvim-web-devicons')

  Plug('j-hui/fidget.nvim', { tag = 'legacy' })

  Plug('Sackbuoy/git_browse.nvim')

  -- signature help
  Plug('ray-x/lsp_signature.nvim')

  -- Completions
  Plug('hrsh7th/cmp-nvim-lsp')
  Plug('hrsh7th/cmp-buffer')
  Plug('hrsh7th/cmp-path')
  Plug('hrsh7th/cmp-cmdline')
  Plug('hrsh7th/nvim-cmp')

  Plug('mrjones2014/smart-splits.nvim')

  Plug('MeanderingProgrammer/render-markdown.nvim')

-- Handling large files
  Plug('LunarVim/bigfile.nvim')

  Plug('stevearc/oil.nvim')

  -- my stuff hehe
  Plug('Sackbuoy/gsm-secrets')
  Plug('Sackbuoy/goto-caller.nvim')

  Plug('benomahony/uv.nvim')

  -- Claude
  Plug('coder/claudecode.nvim')
  Plug('folke/snacks.nvim')

  Plug('nvim-treesitter/nvim-treesitter-context')

  -- also uses plenary and nvim-web-devicons
  Plug('harrisoncramer/gitlab.nvim')
  Plug('MunifTanjim/nui.nvim')
  Plug('sindrets/diffview.nvim')
  Plug('stevearc/dressing.nvim')

  Plug('zongben/dbout.nvim')
vim.call('plug#end')

require('plugins-config.treesitter')
require('plugins-config.telescope')
require('plugins-config.nvim-cmp')
require('plugins-config.oil')
require('plugins-config.smart-splits')
require('plugins-config.render-markdown')
require('plugins-config.claude-code')
require('plugins-config.gitlab')

require('fidget').setup {}
require('gitsigns').setup()
require('lsp_signature').setup()
require('Comment').setup()
require('aerial').setup()
require('bigfile').setup()
require('dbout').setup()

require('gsm-secrets').setup()
require('uv').setup()

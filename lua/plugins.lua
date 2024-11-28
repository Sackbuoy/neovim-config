-- This file is just for defining what plugins I have, and calling their respective 
-- setup functions
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

  Plug('numToStr/Comment.nvim')
  Plug('preservim/nerdtree')

  Plug('nvim-tree/nvim-web-devicons')

  Plug('nvim-telescope/telescope.nvim')
  Plug('Yggdroot/LeaderF', { ['do'] = ':LeaderfInstallCExtension' })

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

  Plug('meain/vim-jsontogo')

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

  -- signature help
  Plug('ray-x/lsp_signature.nvim')

  -- Completions
  -- Plug('github/copilot.vim')
  Plug('hrsh7th/cmp-nvim-lsp')
  Plug('hrsh7th/cmp-buffer')
  Plug('hrsh7th/cmp-path')
  Plug('hrsh7th/cmp-cmdline')
  Plug('hrsh7th/nvim-cmp')

  -- for cheat.sh
  Plug('RishabhRD/popfix')
  Plug('RishabhRD/nvim-cheat.sh')

  Plug('christoomey/vim-tmux-navigator')

  Plug('stevearc/conform.nvim')

  Plug('MeanderingProgrammer/render-markdown.nvim')

  Plug('Zeioth/compiler.nvim', { cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"} })
  Plug('stevearc/overseer.nvim', { cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"} })

  -- Debuggers
  Plug('mfussenegger/nvim-dap')
  -- Plug('theHamsta/nvim-dap-virtual-text')
  Plug('rcarriga/nvim-dap-ui')
  Plug('nvim-neotest/nvim-nio')

  -- Handling large files
  Plug('LunarVim/bigfile.nvim')

vim.call('plug#end')

require('plugins-config.treesitter')
require('plugins-config.telescope')
require('plugins-config.nvim-cmp')
require('plugins-config.nvim-dap')

require('render-markdown').setup()
require('fidget').setup {}
require('gitsigns').setup()
require('lsp_signature').setup()
require('Comment').setup()
require('aerial').setup()
require('compiler').setup()
require('bigfile').setup()

-- This file is just for defining what plugins I have, and calling their respective 
-- setup functions
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

  Plug('numToStr/Comment.nvim')
  Plug('preservim/nerdtree')
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
  Plug('nvim-lua/plenary.nvim')

  -- Language specific plugins
  -- Go
  Plug('fatih/vim-go', { 
    ['do'] = function() 
      vim.call(':GoUpdateBinaries')
    end
  })

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

  -- Themes
  Plug('dracula/vim', { as = 'dracula' })
  Plug('folke/tokyonight.nvim', { branch = 'main', as = 'tokyonight' })
  Plug('gruvbox-community/gruvbox')
  Plug('whatyouhide/vim-gotham')
  Plug('arcticicestudio/nord-vim')
  Plug('cocopon/iceberg.vim')
  Plug('ayu-theme/ayu-vim')
  Plug('mhartington/oceanic-next')

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
  -- Plug('github/copilot.vim')

  -- completions
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'

  -- For vsnip users.
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

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

-- nvim-cmp setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})


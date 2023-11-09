require('plugins')

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- other stuff idk how to categorize
vim.opt.showmatch = true
vim.opt.incsearch = false

-- scrolling
vim.opt.scrolloff = 12
vim.opt.ttyfast  = true-- speed up scrolling
vim.opt.mouse = '' -- dumb that i have to set it to empty string

-- visuals/colors
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'
vim.opt.termguicolors = true -- some themes need this

-- idk honestly
vim.opt.hidden = true -- keep buffers open
vim.opt.completeopt=menu,menuone,noselect

-- set leader
vim.g.mapleader = ' '

vim.cmd.colorscheme('OceanicNext')

-- Telescope

local utils = require('telescope.utils')
local builtin = require('telescope.builtin')
_G.project_files = function()
    local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' }) 
    if ret == 0 then 
        builtin.git_files() 
    else
        builtin.find_files()
    end 
end 

vim.keymap.set('n', '<leader>ff', '<cmd>lua project_files()<CR>', {noremap=true})
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<space>a', '<cmd>Telescope aerial<CR>', {noremap=true, silent=true})

-- NERDTree keybinds
vim.keymap.set('n', '<leader>l', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<leader>d', ':NERDTreeFind<CR>')

-- Global Keybinds
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')
vim.keymap.set('n', '<leader>E', ':Telescope diagnostics<CR>')

-- LSP keybinds
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')

-- rust.vim
vim.g.rust_clip_command = 'pbcopy' -- for mac
-- vim.g.rust_clip_command = 'xclip -selection clipboard' --for linux

-- vim-go
vim.g.go_gopls_enabled = 0 -- im doing gopls myself so i get universal keybinds

-- function for executing a command that rewrites the buffer,
-- and then restores the cursor to its original location before the exec
_G.retain_window_exec = function(args)
  local view = vim.fn.winsaveview()
  vim.cmd.execute(arg)
  vim.fn.winrestview(view)
end

-- autocmd for running my formatter on go files
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  command = "lua retain_window_exec('silent %!myfmt')",
})

  

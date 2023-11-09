require('plugins')

local opt = vim.opt
local g = vim.g
local cmd = vim.cmd
local keymap = vim.keymap
local api = vim.api
local fn = vim.fn

-- line numbers
opt.number = true
opt.relativenumber = true

opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

-- other stuff idk how to categorize
opt.showmatch = true
opt.incsearch = false

-- scrolling
opt.scrolloff = 12
opt.ttyfast  = true-- speed up scrolling
opt.mouse = '' -- dumb that i have to set it to empty string

-- visuals/colors
opt.signcolumn = 'yes'
opt.colorcolumn = '80'
opt.termguicolors = true -- some themes need this

-- idk honestly
opt.hidden = true -- keep buffers open
opt.completeopt=menu,menuone,noselect

-- set leader
g.mapleader = ' '

cmd.colorscheme('OceanicNext')

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

keymap.set('n', '<leader>ff', '<cmd>lua project_files()<CR>', {noremap=true})
keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>')
keymap.set('n', '<space>a', '<cmd>Telescope aerial<CR>', {noremap=true, silent=true})

-- NERDTree keybinds
keymap.set('n', '<leader>l', ':NERDTreeToggle<CR>')
keymap.set('n', '<leader>d', ':NERDTreeFind<CR>')

-- Global Keybinds
keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')
keymap.set('n', '<leader>E', ':Telescope diagnostics<CR>')

-- LSP keybinds
keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')

-- system clipboard shortcuts
keymap.set('v', '<leader>y', '"+y')
keymap.set('v', '<leader>p', '"+p')

-- rust.vim
g.rust_clip_command = 'pbcopy' -- for mac
-- g.rust_clip_command = 'xclip -selection clipboard' --for linux

-- go
g.go_gopls_enabled = 0 -- im doing gopls myself so i get universal keybinds

-- function for executing a command that rewrites the buffer,
-- and then restores the cursor to its original location before the exec
_G.retain_window_exec = function(args)
  local view = fn.winsaveview()
  cmd.execute(arg)
  fn.winrestview(view)
end

-- autocmd for running my formatter on go files
api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  command = "lua retain_window_exec('silent %!myfmt')",
})

  

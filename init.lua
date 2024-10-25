-- In this file I set all the global options, define functions, 
-- and configure the per-plugin options.
-- keybinds at the bottom
require('plugins')

local opt = vim.opt
local g = vim.g
local b = vim.b
local o = vim.o
local cmd = vim.cmd
local api = vim.api
local fn = vim.fn

-- line numbers
opt.number = true
opt.relativenumber = true

-- line wrap
opt.wrap = false

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
opt.textwidth = 80
opt.termguicolors = true -- some themes need this

-- idk honestly
opt.hidden = true -- keep buffers open
opt.completeopt=menu,menuone,noselect

-- set leader
g.mapleader = ' '

cmd.colorscheme('space-nvim')

require('keybinds')
require('lsp')

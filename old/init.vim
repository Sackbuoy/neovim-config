" tab/indentation options
set tabstop=2 softtabstop=2
set expandtab
set shiftwidth=2

set autoindent " auto indent newline just as much as previous line
filetype plugin indent on " allows auto indenting depending on type of file

" line numbers
set number " add line numbers
set relativenumber
set showmatch 

" search 
set incsearch

" scrolling
set scrolloff=12
set ttyfast " speed up scrolling

set signcolumn=yes
set colorcolumn=80

set hidden " keep buffers open
set noerrorbells

set completeopt=menu,menuone,noselect

" apparently this is required for rust.vim
syntax enable

" changes some color settings or something idk but it looks awful without it
set termguicolors

" disable mouse
set mouse=

call plug#begin()
  " Editor plugins
  Plug 'numToStr/Comment.nvim'
  Plug 'preservim/nerdtree'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'f-person/git-blame.nvim'
  Plug 'mbbill/undotree'
  Plug 'stevearc/aerial.nvim'
  Plug 'nvim-telescope/telescope-live-grep-args.nvim'
 
  " Copilot
  " Plug 'github/copilot.vim'

  " This is for lazy loading plugins? ngl idk
  Plug 'nvim-lua/plenary.nvim'

  " Language specific plugins
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'hashivim/vim-terraform'
  Plug 'towolf/vim-helm'

  " Rust disabling these bc it was doubling my lang servers and slowing shit
  " down lol, id rather do it myself
  " Plug 'rust-lang/rust.vim'
  " Plug 'alx741/vim-rustfmt' " did some magic to make this always use nightly: EDIT lmao no clue what this means
  " Plug 'simrat39/rust-tools.nvim'

  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'

  " Themes
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'gruvbox-community/gruvbox'
  Plug 'whatyouhide/vim-gotham'
  Plug 'arcticicestudio/nord-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'nanotech/jellybeans.vim'
  Plug 'glepnir/oceanic-material'
  Plug 'mhartington/oceanic-next'

  " For Lsp Installation
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'

  " COC
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Debugging
  " Plug 'mfussenegger/nvim-dap'
  " Plug 'leoluz/nvim-dap-go'
  " Plug 'rcarriga/nvim-dap-ui'
  " Plug 'theHamsta/nvim-dap-virtual-text'
  " Plug 'nvim-telescope/telescope-dap.nvim'

  " signature help
  Plug 'ray-x/lsp_signature.nvim'

  " git stuff
  Plug 'sindrets/diffview.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'tpope/vim-fugitive'
  Plug 'lewis6991/gitsigns.nvim'

  " harpoon, for navigation
  Plug 'ThePrimeagen/harpoon'

  " lsp progress on stuff
  Plug 'j-hui/fidget.nvim', { 'tag' : 'legacy' }

  " open github
  Plug 'tyru/open-browser.vim'
  Plug 'tyru/open-browser-github.vim'

  " Arduino
  Plug 'stevearc/vim-arduino'

  " GDScript
  Plug 'habamax/vim-godot'

  " pr reviewing
  " dev icons for octopr
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'pwntester/octo.nvim'

  " bufferline
  " Plug 'bling/vim-bufferline'

  " Svelte
  Plug 'othree/html5.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'evanleck/vim-svelte', {'branch': 'main'}
call plug#end()

nnoremap <C-R> <cmd>:source /Users/cameron.kientz/.config/nvim/init.vim<CR>

" colorscheme gruvbox
" colorscheme slate
" colorscheme jellybeans
" colorscheme tokyonight-night
colorscheme OceanicNext

" Keybinds
let mapleader="\<SPACE>"

" for system clipboard use leader
vnoremap <leader>y "*y
vnoremap <leader>p "*p

" Global Keybinds
nnoremap <leader>d <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap [d <cmd>lua vim.diagnostic.goto_prev()<CR> 
nnoremap ]d <cmd>lua vim.diagnostic.goto_next()<CR> 
nnoremap <leader>q <cmd>lua vim.diagnostic.setloclist()<CR> 
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>D :Telescope diagnostics<CR>

nnoremap gr :Telescope lsp_references<CR>
nnoremap gi :Telescope lsp_implementations<CR>
nnoremap gd :Telescope lsp_definitions<CR>

noremap <leader>y "+y

" NERDTree keybinds
nnoremap <leader>l :NERDTreeToggle<CR>
nnoremap <leader>e :NERDTreeFind<CR>
nnoremap <leader>n :NERDTree .<CR>

" Telescope keybinds
nnoremap <leader>ff :Telescope find_files<CR>
" nnoremap <leader>fg <cmd>Telescope live_grep<CR>
" nnoremap <leader>fg <cmd>lua require("telescope.builtin").live_grep({ path_display = { "smart" }})<CR>
nnoremap <leader>fg <cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>

" git keybinds
nnoremap <leader>sd <cmd>DiffviewOpen<CR>

" harpoon keybinds
nnoremap <leader>hl <cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>ha <cmd>lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>o <cmd>lua require("harpoon.ui").nav_prev()<CR>
nnoremap <leader>i <cmd>lua require("harpoon.ui").nav_next()<CR>

" remap undo
nnoremap u :undo<CR>
nnoremap U :redo<CR>


" debugging go
let g:go_debug_windows = {
      \ 'vars':       'rightbelow 60vnew',
      \ 'stack':      'rightbelow 10new',
\ }

let g:go_debug_mappings = {
      \ '(go-debug-continue)': {'key': 'c', 'arguments': '<nowait>'},
      \ '(go-debug-next)': {'key': 'n', 'arguments': '<nowait>'},
      \ '(go-debug-step)': {'key': 's'},
      \ '(go-debug-print)': {'key': 'p'},
  \}

nnoremap <leader>ds :GoDebugStart<cr>
nnoremap <leader>dt :GoDebugStop<cr>
nnoremap <leader>b :GoDebugBreakpoint<cr>
nnoremap <leader>r :GoDebugRestart<cr>

" open github 
nnoremap <leader>g :OpenGithubFile<cr>

let g:terraform_fmt_on_save=1
let g:terraform_align=1

let g:airline_powerline_fonts = 1

" let g:go_fmt_command = 'mygci'
let g:go_fmt_autosave = 0 " doing it myself with myfmt
let g:go_imports_autosave = 0 " doing it myself with myfmt
let g:go_gopls_enabled = 0 " I'm doing gopls myself with mason
let g:go_gopls_complete_unimported = 0 " idk im doing shit myself

let g:NERDTreeWinSize = 60

" Arduino
nnoremap <leader>aa <cmd>ArduinoAttach<CR>
nnoremap <leader>av <cmd>ArduinoVerify<CR>
nnoremap <leader>au <cmd>ArduinoUpload<CR>
nnoremap <leader>aus <cmd>ArduinoUploadAndSerial<CR>
nnoremap <leader>as <cmd>ArduinoSerial<CR>
nnoremap <leader>ab <cmd>ArduinoChooseBoard<CR>
nnoremap <leader>ap <cmd>ArduinoChooseProgrammer<CR>


runtime coc.vim

lua require('init')

" myfmt - runs my formatter script for go files
autocmd BufWritePre *.go :call KeepEx('silent %!myfmt')

" function for retaining cursor position on buffer rewrite
function! KeepEx(arg)
  let l:winview = winsaveview()
  execute a:arg
  call winrestview(l:winview)
endfunction


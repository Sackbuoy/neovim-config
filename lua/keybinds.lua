local keybinds = {
  -- LSP stuff
  ["gD"] = {
    mode = "n",
    cmd = "<cmd>lua vim.lsp.buf.type_definition()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["gd"] = {
    mode = "n",
    cmd = ":Telescope lsp_definitions<CR>",
    opts = {noremap=true, silent=true},
  },
  ["gi"] = {
    mode = "n",
    cmd = ":Telescope lsp_implementations<CR>",
    opts = {noremap=true, silent=true},
  },
  ["gr"] = {
    mode = "n",
    cmd = ":Telescope lsp_references<CR>",
    opts = {noremap=true, silent=true},
  },
  ["K"] = {
    mode = "n",
    cmd = "<cmd>lua vim.lsp.buf.hover()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>we"] = {
    mode = "n",
    cmd = "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>wa"] = {
    mode = "n",
    cmd = "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>wr"] = {
    mode = "n",
    cmd = "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>wl"] = {
    mode = "n",
    cmd = "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>rn"] = {
    mode = "n",
    cmd = "<cmd>lua vim.lsp.buf.rename()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>ca"] = {
    mode = "n",
    cmd = "<cmd>lua vim.lsp.buf.code_action()<CR>",
    opts = {noremap=true, silent=true},
  },


  -- Telescope
  ["<leader>ff"] = {
    mode = "n",
    cmd = "<cmd>lua project_files()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>fg"] = {
    mode = "n",
    cmd = ":Telescope live_grep<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<space>a"] = {
    mode = "n",
    cmd = "<cmd>Telescope aerial<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>D"] = {
    mode = "n",
    cmd = ":Telescope diagnostics<CR>",
    opts = {noremap=true, silent=true},
  },


  -- NERDTree keybinds
  ["<leader>l"] = {
    mode = "n",
    cmd = ":NERDTreeToggle<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>e"] = {
    mode = "n",
    cmd = ":NERDTreeFind<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>n"] = {
    mode = "n",
    cmd = ":NERDTree .<CR>",
    opts = {noremap=true, silent=true},
  },

  -- Global Keybinds
  ["<leader>d"] = {
    mode = "n",
    cmd = "<cmd>lua vim.diagnostic.open_float()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["[d"] = {
    mode = "n",
    cmd = "<cmd>lua vim.diagnostic.goto_prev()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["]d"] = {
    mode = "n",
    cmd = "<cmd>lua vim.diagnostic.goto_next()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>q"] = {
    mode = "n",
    cmd = "<cmd>lua vim.diagnostic.setloclist()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>u"] = {
    mode = "n",
    cmd = ":UndotreeToggle<CR>",
    opts = {noremap=true, silent=true},
  },

  -- Harpoon
  ["<leader>hl"] = {
    mode = "n",
    cmd = "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>ha"] = {
    mode = "n",
    cmd = "<cmd>lua require('harpoon.mark').add_file()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>o"] = {
    mode = "n",
    cmd = "<cmd>lua require('harpoon.ui').nav_prev()<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>i"] = {
    mode = "n",
    cmd = "<cmd>lua require('harpoon.ui').nav_next()<CR>",
    opts = {noremap=true, silent=true},
  },


  -- Open Github
  ["<leader>g"] = {
    mode = "n",
    cmd = ":OpenGithubFile()<CR>",
    opts = {noremap=true, silent=true},
  },


  -- System Clipboard shortcuts
  ["<leader>y"] = {
    mode = "v",
    cmd = '"+y',
    opts = {noremap=true, silent=true},
  },
  ["<leader>p"] = {
    mode = "v",
    cmd = '"+p',
    opts = {noremap=true, silent=true},
  },

  -- Remap redo
  ["U"] = {
    mode = "n",
    cmd = ":redo<CR>",
    opts = {noremap=true, silent=true},
  },
}

local set_keybinds = function(keys)
  for key, item in pairs(keys) do
    vim.keymap.set(item.mode, key, item.cmd, item.opts)
  end
end

set_keybinds(keybinds)

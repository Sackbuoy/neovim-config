function _G._note_complete()
  return vim.trim(vim.fn.system("note list"))
end

local keybinds = {
  -- LSP stuff
  ["gD"] = {
    mode = "n",
    cmd = ":Telescope lsp_type_definitions<CR>",
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
  ["<leader>f"] = {
    mode = "n",
    cmd = "<cmd>:Telescope find_files<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>g"] = {
    mode = "n",
    cmd = ":Telescope live_grep<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<space>a"] = {
    mode = "n",
    cmd = "<cmd>Telescope aerial<CR>",
    opts = {noremap=true, silent=true},
  },
  ["<leader>DD"] = {
    mode = "n",
    cmd = ":Telescope diagnostics<CR>",
    opts = {noremap=true, silent=true},
  },

  ["<leader>e"] = {
    mode = "n",
    cmd = ":Oil<CR>",
    opts = {noremap=true, silent=true},
  },

  -- Global Keybinds
  ["<leader>D"] = {
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
  ["<leader>U"] = {
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


  -- Open Remote in browser
  ["<leader>G"] = {
    mode = "n",
    cmd = ":BrowseLine<CR>",
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

  -- Retain visual selection when tabbing
  [">"] = {
    mode = "v",
    cmd = ">gv",
    opts = {noremap=true},
  },
  ["<"] = {
    mode = "v",
    cmd = "<gv",
    opts = {noremap=true},
  },
  --
  -- -- Smart Splits stuff
  -- ["<C-h>"] = {
  --   mode = "n",
  --   cmd = ":SmartCursorMoveLeft",
  -- },
  -- ["<C-l>"] = {
  --   mode = "n",
  --   cmd = ":SmartCursorMoveRight",
  -- },
  -- ["<C-j>"] = {
  --   mode = "n",
  --   cmd = ":SmartCursorMoveDown",
  -- },
  -- ["<C-k>"] = {
  --   mode = "n",
  --   cmd = ":SmartCursorMoveUp",
  -- },
  ["ex"] = {
    mode = "n",
    cmd = ":!%:p<CR>",
    opts = {noremap=true},
  },
  ["<leader>C"] = {
    mode = {"n", "t"},
    cmd = function() require('snacks').terminal.toggle(nil, { cwd = vim.fn.getcwd(), win = { position = "float", width = 0.7, height = 0.7 } }) end,
    opts = {noremap=true, silent=true, desc="Toggle floating terminal"},
  },
  ["<leader>N"] = {
    mode = {"n", "t"},
    cmd = function()
      local snacks = require('snacks')
      local on_close = function()
        -- When we toggle, we set this flag so on_close knows not to clear
        if not vim.g._note_toggling then
          vim.g._note_term_cmd = nil
        end
      end
      local win_opts = { position = "float", width = 0.7, height = 0.7, on_close = on_close }
      -- If a note terminal is already open, toggle it
      if vim.g._note_term_cmd then
        vim.g._note_toggling = true
        snacks.terminal.toggle(vim.g._note_term_cmd, { win = win_opts })
        vim.g._note_toggling = false
        return
      end
      -- Otherwise prompt for a note name
      vim.ui.input({ prompt = "Note: ", completion = "custom,v:lua._note_complete" }, function(name)
        name = name and vim.trim(name)
        if name and name ~= "" then
          local cmd = "note " .. vim.fn.shellescape(name)
          vim.g._note_term_cmd = cmd
          snacks.terminal.toggle(cmd, { win = win_opts })
        end
      end)
    end,
    opts = {noremap=true, silent=true, desc="Open a note"},
  },
  ["so"] = {
    mode = { "n" },
    cmd = require("goto-caller").goto_caller,
    opts = {noremap=true, desc="Jump to caller"},
  },

}

local set_keybinds = function(keys)
  for key, item in pairs(keys) do
    vim.keymap.set(item.mode, key, item.cmd, item.opts)
  end
end

set_keybinds(keybinds)

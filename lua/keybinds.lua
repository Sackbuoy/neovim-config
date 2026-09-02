local keybinds = {
  -- LSP stuff
  ["gD"] = {
    mode = "n",
    cmd = ":Telescope lsp_type_definitions<CR>",
    opts = { noremap = true, silent = true }
  },
  ["gd"] = {
    mode = "n",
    cmd = ":Telescope lsp_definitions<CR>",
    opts = { noremap = true, silent = true }
  },
  ["gi"] = {
    mode = "n",
    cmd = ":Telescope lsp_implementations<CR>",
    opts = { noremap = true, silent = true }
  },
  ["gr"] = {
    mode = "n",
    cmd = ":Telescope lsp_references<CR>",
    opts = { noremap = true, silent = true }
  },
  ["<leader>d"] = {
    mode = "n",
    cmd = ":Telescope diagnostics<CR>",
    opts = {noremap=true, silent=true},
  },
  ["K"] = {
    mode = "n",
    cmd = "<cmd>lua vim.lsp.buf.hover()<CR>",
    opts = { noremap = true, silent = true }
  },
  ["<leader>rn"] = {
    mode = "n",
    cmd = "<cmd>lua vim.lsp.buf.rename()<CR>",
    opts = { noremap = true, silent = true }
  },
  ["<leader>ca"] = {
    mode = "n",
    cmd = "<cmd>lua vim.lsp.buf.code_action()<CR>",
    opts = { noremap = true, silent = true }
  },

  -- Telescope
  ["<leader>f"] = {
    mode = "n",
    cmd = "<cmd>:Telescope find_files<CR>",
    opts = { noremap = true, silent = true }
  },
  ["<leader>g"] = {
    mode = "n",
    cmd = ":Telescope live_grep<CR>",
    opts = { noremap = true, silent = true }
  },
  ["<space>a"] = {
    mode = "n",
    cmd = "<cmd>Telescope aerial<CR>",
    opts = { noremap = true, silent = true }
  },
  ["<leader>DD"] = {
    mode = "n",
    cmd = ":Telescope diagnostics<CR>",
    opts = { noremap = true, silent = true }
  },

  ["<leader>e"] = {
    mode = "n",
    cmd = ":Oil<CR>",
    opts = { noremap = true, silent = true }
  },

  -- Global Keybinds
  ["<leader>D"] = {
    mode = "n",
    cmd = "<cmd>lua vim.diagnostic.open_float()<CR>",
    opts = { noremap = true, silent = true }
  },
  ["[d"] = {
    mode = "n",
    cmd = "<cmd>lua vim.diagnostic.goto_prev()<CR>",
    opts = { noremap = true, silent = true }
  },
  ["]d"] = {
    mode = "n",
    cmd = "<cmd>lua vim.diagnostic.goto_next()<CR>",
    opts = { noremap = true, silent = true }
  },
  ["<leader>q"] = {
    mode = "n",
    cmd = "<cmd>lua vim.diagnostic.setloclist()<CR>",
    opts = { noremap = true, silent = true }
  },

  -- Open Remote in browser
  ["<leader>G"] = {
    mode = "n",
    cmd = ":BrowseLine<CR>",
    opts = { noremap = true, silent = true }
  },

  -- System Clipboard shortcuts
  ["<leader>y"] = {
    mode = "v",
    cmd = '"+y',
    opts = { noremap = true, silent = true }
  },
  ["<leader>p"] = {
    mode = "v",
    cmd = '"+p',
    opts = { noremap = true, silent = true }
  },

  -- Remap redo
  ["U"] = {
    mode = "n",
    cmd = ":redo<CR>",
    opts = { noremap = true, silent = true }
  },

  -- Retain visual selection when tabbing
  [">"] = {
    mode = "v",
    cmd = ">gv",
    opts = { noremap = true }
  },
  ["<"] = {
    mode = "v",
    cmd = "<gv",
    opts = { noremap = true }
  },
  ["<leader>so"] = {
    mode = { "n" },
    cmd = require("goto-caller").goto_caller,
    opts = { noremap = true, desc = "Jump to caller" }
  },
  -- Test Stuff
  ["<leader>tt"] = {
    mode = { "n" },
    cmd = ":TestNearest<CR>",
    opts = { noremap = true, silent = true }
  },
  ["<leader>tf"] = {
    mode = { "n" },
    cmd = ":TestFile<CR>",
    opts = { noremap = true, silent = true }
  },

  -- reviewer-nvim
  ["<leader>rs"] = {
    mode = "n",
    cmd = ":ReviewSelect<CR>",
    opts = { noremap = true, silent = true, desc = "Review: select review" }
  },
  ["<leader>rd"] = {
    mode = "n",
    cmd = ":ReviewDescription<CR>",
    opts = { noremap = true, silent = true, desc = "Review: go to description" }
  },
  ["<leader>rfs"] = {
    mode = "n",
    cmd = ":ReviewFileSelect<CR>",
    opts = { noremap = true, silent = true, desc = "Review: select file" }
  },
  ["<leader>rfn"] = {
    mode = "n",
    cmd = ":ReviewFileNext<CR>",
    opts = { noremap = true, silent = true, desc = "Review: next file" }
  },
  ["<leader>rfp"] = {
    mode = "n",
    cmd = ":ReviewFilePrev<CR>",
    opts = { noremap = true, silent = true, desc = "Review: prev file" }
  },
  ["<leader>rft"] = {
    mode = "n",
    cmd = ":ReviewFileTargetVsplit<CR>",
    opts = { noremap = true, silent = true, desc = "Review: open target-branch file" }
  },
  ["<leader>rds"] = {
    mode = "n",
    cmd = ":ReviewDiscussionSelect<CR>",
    opts = { noremap = true, silent = true, desc = "Review: select discussion" }
  },
  ["<leader>rdo"] = {
    mode = "n",
    cmd = ":ReviewDiscussionOpen<CR>",
    opts = { noremap = true, silent = true, desc = "Review: open discussion at cursor" }
  },
  ["<leader>rdn"] = {
    mode = "n",
    cmd = ":ReviewDiscussionNext<CR>",
    opts = { noremap = true, silent = true, desc = "Review: next discussion" }
  },
  ["<leader>rdp"] = {
    mode = "n",
    cmd = ":ReviewDiscussionPrev<CR>",
    opts = { noremap = true, silent = true, desc = "Review: prev discussion" }
  },
  ["<leader>ra"] = {
    mode = "n",
    cmd = ":ReviewApprove<CR>",
    opts = { noremap = true, silent = true, desc = "Review: approve" }
  },
  ["<leader>rx"] = {
    mode = "n",
    cmd = ":ReviewSubmit<CR>",
    opts = { noremap = true, silent = true, desc = "Review: submit reply/comment" }
  }
}

local set_keybinds = function (keys)
  for key, item in pairs(keys) do
    vim.keymap.set(item.mode, key, item.cmd, item.opts)
  end
end

set_keybinds(keybinds)

-- Make all lowercase marks global by mapping them to their uppercase equivalents.
-- e.g. `ma` sets mark A (global), `'a` / `a` jump to it from any file.
for c = string.byte('a'), string.byte('z') do
  local lower = string.char(c)
  local upper = string.char(c - 32)
  -- set mark
  vim.keymap.set('n', 'm' .. lower, 'm' .. upper, { noremap = true, silent = true })
  -- jump to line of mark (single-quote style)
  vim.keymap.set('n', "'" .. lower, "'" .. upper, { noremap = true, silent = true })
  -- jump to exact position of mark (backtick style)
  vim.keymap.set('n', '`' .. lower, '`' .. upper, { noremap = true, silent = true })
  -- delete mark
  vim.keymap.set('n', 'M' .. lower, ':delmarks ' .. upper .. '<CR>', { noremap = true, silent = true })
end

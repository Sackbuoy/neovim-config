local toggle_key = '<leader>,'
require('snacks').setup()
require('claudecode').setup({
  terminal = {
    provider = "snacks",  -- explicitly set snacks so it doesn't fall back
    snacks_win_opts = {
      position = "float",
      width = 0.7,
      height = 0.7,
      keys = {
        claude_hide = {
          toggle_key,
          function(self)
            self:hide()
          end,
          mode = "t",
          desc = "Hide",
        },
      },
    },
  },
})

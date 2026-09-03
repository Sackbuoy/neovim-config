require('gitlab').setup({
  server = {
    binary = vim.fn.exepath("gitlab.nvim")
  },
  discussion_signs = {
    enabled = false
  },
  popup = {
    width = "75%",
    height = "75%",
  },
  keymaps = {
    global = {
      approve = "glA",
      pipeline = "glp",
      toggle_discussions = "gld",
    },
    popup = {
      perform_action = "<CR>",
      discard_action = "<Esc>"
    },
    reviewer = {
      create_comment = "c"
    },
   discussion_tree = {
      jump_to_file = "f",
      jump_to_reviewer = "o",
      toggle_node = "<CR>",
    },
  },
})

vim.api.nvim_create_user_command("GlabMR", function()
  require("gitlab").choose_merge_request()
end, {})

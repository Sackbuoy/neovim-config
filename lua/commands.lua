-- LSP management
vim.api.nvim_create_user_command('LspRestart', function()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    print("No active LSP clients")
    return
  end
  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client)
  end
  vim.cmd('edit')
end, {})

vim.api.nvim_create_user_command('LspClients', function()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    print("No active LSP clients")
    return
  end
  for _, client in ipairs(clients) do
    print(client.name)
  end
end, {})

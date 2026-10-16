-- Resolve the Cargo *workspace* root (not the nearest member crate), so that
-- all member crates share one rust-analyzer instance. Mirrors the approach in
-- nvim-lspconfig's rust_analyzer config:
-- https://git.sudomsg.com/mirror/nvim-lspconfig/plain/lsp/rust_analyzer.lua?h=v2.5.0
local function workspace_root(bufnr, on_dir)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  local crate_dir = vim.fs.root(fname, { "Cargo.toml" })

  if not crate_dir then
    on_dir(vim.fs.root(fname, { "rust-project.json" }))
    return
  end

  vim.system(
    { "cargo", "metadata", "--no-deps", "--format-version", "1",
      "--manifest-path", crate_dir .. "/Cargo.toml" },
    { text = true },
    function(out)
      vim.schedule(function()
        if out.code == 0 then
          local ok, meta = pcall(vim.json.decode, out.stdout)
          if ok and meta and meta.workspace_root then
            on_dir(vim.fs.normalize(meta.workspace_root))
            return
          end
        end
        on_dir(crate_dir) -- fall back to the crate dir if cargo metadata fails
      end)
    end
  )
end

return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir = workspace_root,

  settings = {
    ["rust-analyzer"] = {
      cargo = {
        targetDir = true,     -- separate target/rust-analyzer dir; avoids lock contention with terminal cargo
        allTargets = false,   -- skip tests/benches/examples (check inherits this on recent versions)
        features = "all",     -- replaces the removed `allFeatures`; delete this line if you don't need it (it makes loads/checks heavier)
      },
      check = {
        command = "check",    -- "clippy" is slower
        workspace = false,    -- only check the saved file's package
        allTargets = false,   -- explicit, for older rust-analyzer versions where check.allTargets defaults to true
      },
      checkOnSave = true,
      rustfmt = {
        extraArgs = { "+nightly" }, -- requires the nightly toolchain to be installed via rustup
      },
    },
  },

  on_attach = function(client, bufnr)
    -- Auto-format on save. Per-buffer augroup with clear=true prevents
    -- duplicate autocmds when the client re-attaches.
    local group = vim.api.nvim_create_augroup("RustFormatOnSave_" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr, id = client.id, async = false })
      end,
    })
  end,
}

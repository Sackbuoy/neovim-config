vim.lsp.enable({
    "gopls",
    "lua_ls",
    "basedpyright",
    -- "pytest_lsp",  -- pytest-language-server not available in nixpkgs
    -- "ruff",
    -- "pylyzer",
    "rust-analyzer",
    "nixd",
    "golangci-lint-langserver",
    -- "protobuf-language-server",
    "bufls",
    -- "lexical",
    "typescript-language-server",
    -- "typos",
})

vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})

vim.g["test#strategy"] = "neovim"
vim.g["test#neovim#term_position"] = "vert botright"

-- Go
vim.g["test#go#runner"] = "gotest"

-- Rust
vim.g["test#rust#cargotest#options"] = "-- --nocapture --test-threads=1"

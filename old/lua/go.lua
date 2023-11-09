-- This file is for setup that is entirely unique to golang, excluding plugins and the language server initialization

local lspconfig = require'lspconfig'
local configs = require 'lspconfig/configs'

-- golangci-lint setup
if not configs.golangcilsp then
 	configs.golangcilsp = {
		default_config = {
			cmd = {'golangci-lint-langserver'},
			root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
			init_options = {
					command = { "golangci-lint", "run", "--out-format", "tab" };
			}
		};
	}
end

return {
	cmd = { "haskell-language-server-wrapper", "--lsp" },
	filetypes = { "haskell", "lhaskell" },
	root_markers = {
		"hie.yaml",
		"stack.yaml",
		"cabal.project",
		"*.cabal",
		"package.yaml",
		".git",
	},
	settings = {
		haskell = {
			formattingProvider = "ormolu",
			checkProject = true,
		},
	},
	single_file_support = true,
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"scheme",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				scheme_langserver = {},
			},
		},
	},
}

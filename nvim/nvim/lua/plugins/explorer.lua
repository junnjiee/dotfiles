return {
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				sources = {
					explorer = {
						layout = { hidden = { "input" } },
						hidden = true, -- hidden files
						ignored = false, -- gitignored files
					},
				},
			},
		},
	},
}

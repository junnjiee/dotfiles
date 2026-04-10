return {
	{
		"timothyckl/tau.nvim",
		build = "cd cli && bun build --compile src/index.ts --outfile tau",
		config = function()
			require("tau").setup({
				api_url = "https://api.openai.com/v1",
				api_key = vim.fn.getenv("OPENAI_API_KEY"),
				model = "gpt-5.4",
			})
		end,
		keys = {
			{ "<leader>t", ":Tau ", mode = "v", desc = "Tau: LLM edit selection" },
		},
	},
}

return {
	"timothyckl/tau.nvim",
	lazy = false,
	build = "cd cli && bun run build",
	config = function()
		require("tau").setup({
			api_url = "https://api.openai.com/v1",
			api_key = vim.fn.getenv("OPENAI_API_KEY"),
			model = "gpt-5.4",
		})
	end,
	keys = {
		{ "<leader>t", ":Tau<CR>", mode = "v", desc = "Tau: edit selection" },
		{ "<C-t>", ":TauContext<CR>", mode = "n", desc = "Tau: context files" },
	},
}

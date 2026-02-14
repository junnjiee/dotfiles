return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            layout = { hidden = { "input" } },
            hidden = true, -- Show hidden files by default
            ignored = true, -- Show gitignored files by default (this includes .env)
          },
        },
      },
    },
  },
}

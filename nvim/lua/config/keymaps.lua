vim.g.mapleader = " "
vim.keymap.set("n", "<leader>wd", [[:Neotree<cr>]], { desc = "Open Neotree" })
vim.keymap.set("n", "<leader>ch", [[:noh<cr>]], { desc = "[c]lear [h]ighlights" })
vim.keymap.set("n", "cp", [["+Y]], { desc = "[c]o[p]y to clipboard" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diganostic in pop up buffer" })

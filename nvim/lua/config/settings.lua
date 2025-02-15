-- relative line number
vim.opt.nu = true
vim.opt.relativenumber = true

-- use spaces for tab
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- no wrap lines
vim.opt.wrap = false

-- minimum number of lines to keep in screen
vim.opt.scrolloff = 8

-- show errors inline
vim.diagnostic.config({ virtual_text = true })

-- respects .editorconfig
vim.g.editorconfig = true

-- enable code folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevelstart = 99

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", {}),
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

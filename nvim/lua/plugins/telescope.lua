return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local vertical_strategy = {
            layout_strategy = 'vertical',
            layout_config = {
                preview_cutoff = 3,
                preview_height = 0.6
            }
        }
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = { ".git/" },
                layout_config = {
                    width = 0.99,
                    height = 0.99,
                }
            },
            pickers = {
                find_files = vertical_strategy,
                live_grep = vertical_strategy,
                git_status = vertical_strategy,
                git_branches = vertical_strategy,
                git_commits = vertical_strategy,
                git_bcommits = vertical_strategy,
            }
        })
    end,
    keys = {
        -- file pickers
        {
            "<leader>ff",
            function() require("telescope.builtin").find_files({ hidden = true }) end,
            desc = "[f]ilename [f]uzzy find in working directory"
        },
        {
            "<leader>fg",
            function() require("telescope.builtin").live_grep() end,
            desc = "[f]ile contents live [g]rep in working directory"
        },
        -- git pickers
        {
            "<leader>gs",
            function() require("telescope.builtin").git_status() end,
            desc = "[g]it [s]tatus preview"
        },
        {
            "<leader>gb",
            function() require("telescope.builtin").git_branches() end,
            desc = "[g]it [b]ranches preview"
        },
        {
            "<leader>gc",
            function() require("telescope.builtin").git_commits() end,
            desc = "[g]it [c]ommits preview"
        },
        {
            "<leader>go",
            function() require("telescope.builtin").git_bcommits() end,
            desc = "[g]it c[o]mmits preview for current buffer only"
        },
        -- vim pickers
        {
            "<leader>ua",
            function() require("telescope.builtin").buffers() end,
            desc = "list b[u]ffers [a]ll"
        },
        {
            "<leader>uc",
            function() require("telescope.builtin").current_buffer_fuzzy_find() end,
            desc = "fuzzy search b[u]ffer that's [c]urrently open"
        }
    }
}

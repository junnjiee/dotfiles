return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- allows LSP to detect vim globals
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            -- allow LSPs to communicate with the blink-cmp plugin
            local capablities = require("blink-cmp").get_lsp_capabilities()
            require("lspconfig").lua_ls.setup({ capabilities = capablities })
            require("lspconfig").ts_ls.setup({ capablities = capablities })
            require("lspconfig").gopls.setup({ capablities = capablities })

            require("lspconfig").eslint.setup({ capablities = capablities })
            require("lspconfig").jsonls.setup({ capablities = capablities })

            require("lspconfig").html.setup({ capablities = capablities })

            require("lspconfig").cssls.setup({ capablities = capablities })
            require("lspconfig").css_variables.setup({ capablities = capablities })
            require("lspconfig").cssmodules_ls.setup({ capablities = capablities })

            -- format on save if the LSP has a built-in formatter
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    if client == nil then
                        return
                    end

                    if client.supports_method("textDocument/formatting") then
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end,
                        })
                    end
                end,
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({})
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "gopls", "jsonls", "html", "cssls" },
                automatic_installation = false,
                automatic_enable = true,
            })
        end,
    },
}

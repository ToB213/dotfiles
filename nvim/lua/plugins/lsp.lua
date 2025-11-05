return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "gopls", "bashls", "pyright", "lua_ls" },
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(_, bufnr)
                local opts = { buffer = bufnr, noremap = true, silent = true }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            end

            vim.lsp.config("gopls", {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    gopls = {
                        gofumpt = true,
                        analyses = { unusedparams = true },
                        staticcheck = true,
                    },
                },
            })

            vim.lsp.config("bashls", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            vim.lsp.config("pyright", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            vim.lsp.config("lua_ls", {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                    },
                },
            })

            local mason_lsp = require("mason-lspconfig")
            for _, server in ipairs(mason_lsp.get_installed_servers()) do
                vim.lsp.enable(server)
            end
        end,
    },
}


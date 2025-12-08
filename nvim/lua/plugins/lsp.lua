return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"stevearc/conform.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "bashls", "pyright", "lua_ls" },
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- 【重要】LSPがバッファにアタッチされたときにキーマップを設定する
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- バッファローカルなキーマップを設定する関数
					local opts = { buffer = ev.buf, silent = true }

					-- 1. 定義へジャンプ (gd)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

					-- 2. 定義・ドキュメント表示 (K)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

					-- 3. 参照元を表示 (gr)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

					-- 4. リネーム (<leader>rn)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

					-- 5. コードアクション (<leader>ca) - エラー修正の提案など
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})

			-- 各サーバーの設定

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})

			vim.lsp.config("bashls", { capabilities = capabilities })
			vim.lsp.config("pyright", { capabilities = capabilities })

			local mason_lsp = require("mason-lspconfig")
			for _, server in ipairs(mason_lsp.get_installed_servers()) do
				vim.lsp.enable(server)
			end

			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},
}

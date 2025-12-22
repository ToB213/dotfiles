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

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }

          -- 定義へジャンプ (gd)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

          -- 定義・ドキュメント表示 (K)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

          -- 参照元を表示 (gr)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        end,
      })


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

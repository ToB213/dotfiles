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
        ensure_installed = { "bashls", "lua_ls" },
      })
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      _G.lsp_capabilities = capabilities

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        end,
      })

      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_dir = vim.fs.root(0,
          { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml',
            '.git' }),
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      vim.lsp.config('bashls', {
        capabilities = capabilities,
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh', 'bash' },
        root_dir = vim.fs.root(0, { '.git' }),
      })

      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
}

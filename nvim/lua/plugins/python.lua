return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 新しい vim.lsp.config API を使用
      vim.lsp.config('pyright', {
        capabilities = capabilities,
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_dir = vim.fs.root(0, { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' }),
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "standard",
            },
          },
        },
      })

      vim.lsp.config('ruff', {
        capabilities = capabilities,
        cmd = { 'ruff', 'server' },
        filetypes = { 'python' },
        root_dir = vim.fs.root(0, { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' }),
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },
}

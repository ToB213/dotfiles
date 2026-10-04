return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
          local missing = {}
          for _, language in ipairs({ "markdown", "markdown_inline" }) do
            if not pcall(vim.treesitter.language.add, language) then
              table.insert(missing, language)
            end
          end

          if #missing > 0 then
            require("nvim-treesitter").install(missing):wait(300000)
          end
        end,
      },
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      render_modes = { "n", "c" },
      heading = { sign = false },
      code = { sign = false },
    },
    init = function()
      local markdown_group = vim.api.nvim_create_augroup("markdown_writing", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = markdown_group,
        pattern = "markdown",
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
          vim.opt_local.breakindent = true

          vim.keymap.set({ "n", "x" }, "j", "gj", { buffer = args.buf, silent = true })
          vim.keymap.set({ "n", "x" }, "k", "gk", { buffer = args.buf, silent = true })
        end,
      })
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npx --yes yarn install",
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        ft = "markdown",
        desc = "Toggle Markdown preview",
      },
    },
  },
}

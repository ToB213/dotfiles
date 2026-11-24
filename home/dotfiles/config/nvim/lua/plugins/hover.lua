return {
  "lewis6991/hover.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hover").config({
      providers = { "hover.providers.lsp" },
      mouse_providers = { "hover.providers.lsp" },
      mouse_delay = 500,
      preview_opts = { border = "single" },
    })

    vim.opt.mousemoveevent = true
    vim.keymap.set("n", "<MouseMove>", function()
      require("hover").mouse()
    end, { desc = "Show LSP information under mouse" })
  end,
}

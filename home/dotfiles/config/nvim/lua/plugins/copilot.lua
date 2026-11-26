return {
  {
    "github/copilot.vim",
    branch = "release",
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        silent = true,
        desc = "Accept Copilot suggestion",
      })
    end,
  },
}

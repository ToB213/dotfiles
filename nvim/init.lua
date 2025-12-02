vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = 'a'

vim.opt.termguicolors = true
require("config.lazy")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

local copilot_on = false

vim.keymap.set('n', '<Leader>cp', function()
  local command = require("copilot.command")
  if copilot_on then
    command.disable()
    print("Copilot OFF")
    copilot_on = false
  else
    command.enable()
    print("Copilot ON")
    copilot_on = true
  end
end, { desc = "Toggle Copilot" })

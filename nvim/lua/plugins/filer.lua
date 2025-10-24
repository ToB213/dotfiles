return {
  'nvim-tree/nvim-tree.lua',
  version = '*', -- or 'dev' or a specific tag
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {}

    local keymap = vim.keymap
    keymap.set('n', '<Leader>ee', '<Cmd>NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
  end,
}

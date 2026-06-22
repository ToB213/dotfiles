return {
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
          end,
          default_settings = {
            ['rust-analyzer'] = {
            },
          },
        },
      }
    end,
  },
}

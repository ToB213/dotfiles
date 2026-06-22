return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup {
      detection_methods = { "pattern", "lsp" },

      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        "Cargo.toml",
        "go.mod",
        "pyproject.toml",
        "setup.py",
      },

      exclude_dirs = {},

      silent_chdir = true,

      scope_chdir = 'global',

      datapath = vim.fn.stdpath("data"),
    }
  end
}

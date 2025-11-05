return {
    {
        "github/copilot.vim",
        cmd = "Copilot",
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
            require("copilot_cmp").setup()
        end,
    },
}


return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup()
			vim.keymap.set("n", "<Leader>ee", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
		end,
	},
}

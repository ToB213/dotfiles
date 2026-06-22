return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local alpha = require("alpha")
      local if_nil = vim.F.if_nil

      local function button(sc, txt, keybind, keybind_opts)
        local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
        local opts = {
          position = "center",
          shortcut = sc,
          cursor = 3,
          width = 50,
          align_shortcut = "right",
          hl_shortcut = "Keyword",
        }

        if keybind then
          keybind_opts = if_nil(keybind_opts, {
            noremap = true,
            silent = true,
            nowait = true,
          })
          opts.keymap = { "n", sc_, keybind, keybind_opts }
        end

        return {
          type = "button",
          val = txt,
          on_press = function()
            local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
            vim.api.nvim_feedkeys(key, "t", false)
          end,
          opts = opts,
        }
      end

      local function recent_project_buttons()
        local project_history = vim.fn.stdpath("data") .. "/project_nvim/project_history"
        if vim.fn.filereadable(project_history) ~= 1 then
          return {}
        end

        local items = {
          {
            type = "text",
            val = "Recent Projects",
            opts = {
              position = "center",
              hl = "SpecialComment",
            },
          },
          { type = "padding", val = 1 },
        }

        for i, path in ipairs(vim.fn.readfile(project_history)) do
          if i > 5 then
            break
          end

          local name = vim.fn.fnamemodify(path, ":t")
          local escaped_path = vim.fn.fnameescape(path)
          table.insert(
            items,
            button(tostring(i), "  " .. name, "<cmd>cd " .. escaped_path .. " | Telescope find_files<CR>")
          )
        end

        table.insert(items, { type = "padding", val = 1 })
        return items
      end

      local function stats()
        local parts = {}
        local ok, lazy = pcall(require, "lazy")
        if ok then
          table.insert(parts, lazy.stats().count .. " plugins")
        end

        local version = vim.version()
        table.insert(parts, "v" .. version.major .. "." .. version.minor .. "." .. version.patch)
        return table.concat(parts, "   ")
      end

      local layout = {
        { type = "padding", val = 2 },
        {
          type = "text",
          val = "NVIM",
          opts = {
            position = "center",
            hl = "Type",
          },
        },
        { type = "padding", val = 2 },
        {
          type = "group",
          val = {
            button("e", "New file", "<cmd>ene <CR>"),
            button("SPC f f", "Find file"),
            button("SPC f g", "Find word"),
            button("SPC s l", "Open last session"),
          },
          opts = {
            spacing = 1,
          },
        },
      }

      local project_buttons = recent_project_buttons()
      if #project_buttons > 0 then
        table.insert(layout, { type = "padding", val = 1 })
        for _, item in ipairs(project_buttons) do
          table.insert(layout, item)
        end
      end

      table.insert(layout, { type = "padding", val = 1 })
      table.insert(layout, {
        type = "text",
        val = {
          "",
          stats(),
        },
        opts = {
          position = "center",
          hl = "Number",
        },
      })

      alpha.setup({
        layout = layout,
        opts = {
          margin = 5,
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function()
          vim.opt_local.scrolloff = 999
          vim.opt_local.cursorline = false

          local opts = { buffer = true, silent = true }
          vim.keymap.set("n", "<ScrollWheelUp>", "<Nop>", opts)
          vim.keymap.set("n", "<ScrollWheelDown>", "<Nop>", opts)
          vim.keymap.set("n", "<C-u>", "<Nop>", opts)
          vim.keymap.set("n", "<C-d>", "<Nop>", opts)
          vim.keymap.set("n", "<C-b>", "<Nop>", opts)
          vim.keymap.set("n", "<C-f>", "<Nop>", opts)
          vim.keymap.set("n", "gg", "<Nop>", opts)
          vim.keymap.set("n", "G", "<Nop>", opts)
        end,
      })
    end,
  },
}

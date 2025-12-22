return {
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      integrations = {},
      max_width = 100,
      max_height = 12,
    },
  },
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      '3rd/image.nvim',
    },
    config = function()
      local alpha = require('alpha')
      local if_nil = vim.F.if_nil
      
      local logo_path = vim.fn.stdpath('config') .. '/images/logo.png'
      local logo_image = nil

      local header = {
        type = "text",
        val = {
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
        },
        opts = {
          position = "center",
          hl = "Type",
        },
      }

      local leader = "SPC"
      local function button(sc, txt, keybind, keybind_opts)
        local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")
        local opts = {
          position = "center",
          shortcut = sc,
          cursor = 3,
          width = 50,
          align_shortcut = "right",
          hl_shortcut = "Keyword",
        }
        if keybind then
          keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
          opts.keymap = { "n", sc_, keybind, keybind_opts }
        end
        local function on_press()
          local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
          vim.api.nvim_feedkeys(key, "t", false)
        end
        return {
          type = "button",
          val = txt,
          on_press = on_press,
          opts = opts,
        }
      end

      local function get_recent_projects()
        local projects = {}
        
        local project_history = vim.fn.stdpath("data") .. "/project_nvim/project_history"
        
        if vim.fn.filereadable(project_history) == 1 then
          local lines = vim.fn.readfile(project_history)
          for i, line in ipairs(lines) do
            if i <= 5 then
              local name = vim.fn.fnamemodify(line, ":t")
              table.insert(projects, {
                name = name,
                path = line,
              })
            end
          end
        end
        
        return projects
      end

      local function get_project_buttons()
        local projects = get_recent_projects()
        local project_buttons = {}
        
        if #projects > 0 then
          table.insert(project_buttons, {
            type = "text",
            val = "Recent Projects",
            opts = {
              position = "center",
              hl = "SpecialComment",
            },
          })
          table.insert(project_buttons, { type = "padding", val = 1 })
          
          for i, project in ipairs(projects) do
            local shortcut = tostring(i)
            table.insert(project_buttons, 
              button(shortcut, "  " .. project.name, "<cmd>cd " .. project.path .. " | Telescope find_files<CR>")
            )
          end
          
          table.insert(project_buttons, { type = "padding", val = 1 })
        end
        
        return project_buttons
      end

      local buttons = {
        type = "group",
        val = {
          button("e", "  New file", "<cmd>ene <CR>"),
          button("SPC f f", "󰈞  Find file"),
          button("SPC f g", "󰈬  Find word"),
          button("SPC s l", "  Open last session"),
        },
        opts = {
          spacing = 1,
        },
      }

      local function get_stats()
        local stats = {}
        
        local ok, lazy = pcall(require, "lazy")
        if ok then
          local plugins = lazy.stats().count
          table.insert(stats, "  " .. plugins .. " plugins")
        end
        
        local version = vim.version()
        table.insert(stats, "  v" .. version.major .. "." .. version.minor .. "." .. version.patch)
        
        return table.concat(stats, "   ")
      end

      local footer = {
        type = "text",
        val = {
          "",
          get_stats(),
        },
        opts = {
          position = "center",
          hl = "Number",
        },
      }

      local layout = {
        { type = "padding", val = 2 },
        header,
        { type = "padding", val = 2 },
        buttons,
      }
      
      local project_buttons = get_project_buttons()
      if #project_buttons > 0 then
        table.insert(layout, { type = "padding", val = 1 })
        for _, pb in ipairs(project_buttons) do
          table.insert(layout, pb)
        end
      end
      
      table.insert(layout, { type = "padding", val = 1 })
      table.insert(layout, footer)

      local config = {
        layout = layout,
        opts = {
          margin = 5,
        },
      }

      alpha.setup(config)

      local function render_logo()
        local win = vim.api.nvim_get_current_win()
        local win_width = vim.api.nvim_win_get_width(win)
        
        local image_char_width = 14
        local x_pos = math.floor((win_width - image_char_width) / 2)
        
        if logo_image then
          logo_image:clear()
        end
        
        logo_image = require('image').from_file(logo_path)
        
        if logo_image then
          logo_image.geometry = {
            x = x_pos,
            y = 2,
          }
          logo_image:render()
        end
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = render_logo,
      })

      vim.api.nvim_create_autocmd("VimResized", {
        callback = function()
          if vim.bo.filetype == "alpha" then
            render_logo()
          end
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function()
          vim.opt_local.scrolloff = 999
          vim.opt_local.cursorline = false
          
          local opts = { buffer = true, silent = true }
          vim.keymap.set('n', '<ScrollWheelUp>', '<Nop>', opts)
          vim.keymap.set('n', '<ScrollWheelDown>', '<Nop>', opts)
          vim.keymap.set('n', '<C-u>', '<Nop>', opts)
          vim.keymap.set('n', '<C-d>', '<Nop>', opts)
          vim.keymap.set('n', '<C-b>', '<Nop>', opts)
          vim.keymap.set('n', '<C-f>', '<Nop>', opts)
          vim.keymap.set('n', 'gg', '<Nop>', opts)
          vim.keymap.set('n', 'G', '<Nop>', opts)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaClosed",
        callback = function()
          if logo_image then
            logo_image:clear()
            logo_image = nil
          end
        end,
      })

      vim.api.nvim_create_autocmd("BufLeave", {
        callback = function()
          if vim.bo.filetype == "alpha" and logo_image then
            logo_image:clear()
            logo_image = nil
          end
        end,
      })
    end,
  }
}

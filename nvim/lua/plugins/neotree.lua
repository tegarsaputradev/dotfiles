return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              bo = {
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },

    config = function()
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
          },
        },
      })

      require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        sort_case_insensitive = false,

        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            with_expanders = true,
            expander_collapsed = "▶",
            expander_expanded = "▼",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰉗",
            default = "",
            highlight = "NeoTreeFileIcon",
            provider = function(icon, node)
              if node.type == "file" or node.type == "terminal" then
                local success, web_devicons = pcall(require, "nvim-web-devicons")
                if success then
                  local name = node.type == "terminal" and "terminal" or node.name
                  local devicon, hl = web_devicons.get_icon(name, node.ext)
                  if devicon then
                    icon.text = devicon .. " "
                    icon.highlight = hl
                  end
                end
              end
            end,
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              added = "✚",
              modified = "",
              deleted = "✖",
              renamed = "➜",
              untracked = "",
              ignored = "◌",
              unstaged = "",
              staged = "✓",
              conflict = "",
            },
            -- Added highlight groups for better git colors
            highlight = {
              added = "GitSignsAdd",
              modified = "GitSignsChange",
              deleted = "GitSignsDelete",
              renamed = "GitSignsChange",
              untracked = "NeoTreeGitUntracked",
              ignored = "NeoTreeDimText",
              unstaged = "NeoTreeModified",
              staged = "GitSignsStaged",
              conflict = "DiffText",
            },
          },
          file_size = {
            enabled = true,
            width = 12,
            required_width = 64,
          },
          type = {
            enabled = true,
            width = 10,
            required_width = 122,
          },
          last_modified = {
            enabled = true,
            width = 20,
            required_width = 88,
          },
          created = {
            enabled = true,
            width = 20,
            required_width = 110,
          },
          symlink_target = {
            enabled = false,
          },
        },
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = "toggle_node",
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["l"] = "open",
            ["<esc>"] = "cancel",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["h"] = "close_node",
            ["z"] = "close_all_nodes",
            ["a"] = { "add", config = { show_path = "none" } },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["b"] = "rename_basename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
          },
        },
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = false,
            hide_by_name = {},
            hide_by_pattern = {},
            always_show = {},
            never_show = {},
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
          group_empty_dirs = false,
          hijack_netrw_behavior = "open_default",
          use_libuv_file_watcher = true,
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["#"] = "fuzzy_sorter",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["og"] = { "order_by_git_status", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
            fuzzy_finder_mappings = {
              ["<down>"] = "move_cursor_down",
              ["<C-n>"] = "move_cursor_down",
              ["<up>"] = "move_cursor_up",
              ["<C-p>"] = "move_cursor_up",
              ["<esc>"] = "close",
            },
          },
        },
        buffers = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          group_empty_dirs = true,
          show_unloaded = true,
          window = {
            mappings = {
              ["d"] = "buffer_delete",
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
          },
        },
        -- git_status = {
        --   window = {
        --     position = "float",
        --     mappings = {
        --       ["A"] = "git_add_all",
        --       ["gu"] = "git_unstage_file",
        --       ["ga"] = "git_add_file",
        --       ["gr"] = "git_revert_file",
        --       ["gc"] = "git_commit",
        --       ["gp"] = "git_push",
        --       ["gg"] = "git_commit_and_push",
        --       ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
        --       ["oc"] = { "order_by_created", nowait = false },
        --       ["od"] = { "order_by_diagnostics", nowait = false },
        --       ["om"] = { "order_by_modified", nowait = false },
        --       ["on"] = { "order_by_name", nowait = false },
        --       ["os"] = { "order_by_size", nowait = false },
        --       ["ot"] = { "order_by_type", nowait = false },
        --     },
        --   },
        -- },
      })

      vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")
      vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#00FF00" }) -- Bright green
      vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { link = "Normal" }) -- Links to default text color
    end,
  },
}

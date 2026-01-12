return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      hide_by_name = {
        ".git",
      },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },

    event_handlers = {
      {
        event = "file_added",
        handler = function(file_path)
          -- vim.schedule prevents the crash by waiting 1ms for the tree to finish
          vim.schedule(function() vim.cmd("edit " .. file_path) end)
        end,
      },
    },

    window = {
      width = 25,
      mappings = {
        -- Custom Navigation
        ["H"] = function() require("smart-splits").move_cursor_left() end,
        ["h"] = function() require("smart-splits").move_cursor_right() end,
        ["k"] = function() require("smart-splits").move_cursor_down() end,
        ["K"] = function() require("smart-splits").move_cursor_up() end,

        -- Standard Actions
        ["l"] = "open",
        ["<CR>"] = "open",
        ["s"] = "none",
        ["S"] = "none",
      },
    },
  },
}

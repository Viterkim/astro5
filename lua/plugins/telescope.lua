return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      layout_strategy = "vertical",
      layout_config = {
        width = 0.95,
        height = 0.95,
        vertical = {
          preview_height = 0.60,
          mirror = false,
        },
      },
      file_ignore_patterns = {
        "node_modules",
        "target",
        "build",
        "%.lock",
      },
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
        },
      },
    },
  },
}

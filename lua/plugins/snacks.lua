return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      layout = {
        width = 0.95,
        height = 0.95,
        layout = {
          box = "vertical",
          border = "rounded",
          title = "{source}",
          title_pos = "center",

          { win = "preview", title = "{preview}", height = 0.4, border = "bottom" },
          { win = "input", height = 1, border = "bottom", title = "{title} {live} {flags}" },
          { win = "list", border = "none" },
        },
      },
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
    },
  },
}

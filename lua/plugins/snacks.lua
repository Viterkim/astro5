return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      layout = {
        preset = "vertical",
        layout = {
          width = 0.95,
          height = 0.95,
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

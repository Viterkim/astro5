return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      server = {
        cmd = function()
          -- Arch rust analyzer location
          return { "/usr/lib/rustup/bin/rust-analyzer" }
        end,
      },
    }
  end,
}

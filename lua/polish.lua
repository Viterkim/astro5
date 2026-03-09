vim.cmd "set winblend=0"

-- Remove unwanted format options globally
vim.opt.formatoptions:remove { "c", "r", "o" }

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufReadPost", "BufNewFile" }, {
  callback = function() vim.opt.formatoptions:remove { "c", "r", "o" } end,
  pattern = "*",
  desc = "Remove auto-commenting and other format options for cleaner pasting",
})

-- Increase scroll speed with mouse, only on linux (gg wayland)
local os = (vim.uv or vim.loop).os_uname().sysname
if os == "Linux" then vim.opt.mousescroll = "ver:8,hor:2" end

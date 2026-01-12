-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.cmd "set winblend=0"

-- Remove unwanted formatoptions globally
vim.opt.formatoptions:remove { "c", "r", "o" }

-- Ensure formatoptions are enforced each time you open or switch to a buffer
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufReadPost", "BufNewFile" }, {
  callback = function() vim.opt.formatoptions:remove { "c", "r", "o" } end,
  pattern = "*", -- Applies to all files
  desc = "Remove auto-commenting and other format options for cleaner pasting",
})

local M = {}

local function looks_like_match_arms_action(action)
  local title = (action.title or ""):lower()
  return title:find("fill match arms", 1, true) ~= nil
end

local function ensure_match_line_has_braces()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_get_current_line()

  if not line:find "match%s+" then return nil end

  if not line:find("{", 1, true) then
    line = line:gsub("%s*$", "") .. " {}"
    vim.api.nvim_set_current_line(line)
  elseif not line:find("}", 1, true) then
    line = line:gsub("%s*$", "") .. "}"
    vim.api.nvim_set_current_line(line)
  end

  local open_brace = line:find("{", 1, true)
  local close_brace = open_brace and line:find("}", open_brace + 1, true) or nil
  if not open_brace or not close_brace then return nil end

  local inner_col = open_brace
  vim.api.nvim_win_set_cursor(0, { row, inner_col })

  return { row = row }
end

local function replace_generated_todos_with_braces(open_pos)
  if not open_pos then return end

  local save = vim.api.nvim_win_get_cursor(0)

  local line = vim.api.nvim_buf_get_lines(0, open_pos.row - 1, open_pos.row, false)[1]
  if not line then return end

  local open_brace = line:find("{", 1, true)
  if not open_brace then return end

  local brace_col = open_brace - 1
  pcall(vim.api.nvim_win_set_cursor, 0, { open_pos.row, brace_col })

  local ok = pcall(function() vim.cmd.normal { args = { "%" }, bang = true } end)

  if not ok then
    pcall(vim.api.nvim_win_set_cursor, 0, save)
    return
  end

  local close = vim.api.nvim_win_get_cursor(0)
  pcall(vim.api.nvim_win_set_cursor, 0, save)

  local start_row = open_pos.row
  local end_row = close[1]

  if end_row < start_row then return end

  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
  if #lines == 0 then return end

  for i, l in ipairs(lines) do
    lines[i] = l:gsub("(=>%s*)todo!%(%)(%s*,?)", "%1{}%2")
  end

  vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, false, lines)
end

function M.rust_fill_match_arms_smart()
  if vim.bo.filetype ~= "rust" then return end

  vim.cmd.stopinsert()

  local open_pos = ensure_match_line_has_braces()
  if not open_pos then return end

  vim.defer_fn(function()
    vim.lsp.buf.code_action {
      apply = true,
      filter = looks_like_match_arms_action,
    }

    vim.defer_fn(function() replace_generated_todos_with_braces(open_pos) end, 150)
  end, 80)
end

function M.select_whole_file() vim.cmd.normal { args = { "gg0vG$" }, bang = true } end

return M

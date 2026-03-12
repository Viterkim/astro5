local M = {}

function M.sudoku_quit()
  local answer = vim.fn.input "Type sudoku to nuke all windows: "
  if answer ~= "sudoku" then
    vim.notify "Aborted"
    return
  end

  pcall(function() vim.cmd "Neotree close left" end)
  pcall(function() vim.cmd "Neotree close right" end)
  vim.cmd "qa!"
end

function M.exit_visual()
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
end

local function get_visual_bounds()
  local mode = vim.fn.mode()
  local start_pos, end_pos

  if mode == "v" or mode == "V" or mode == "\22" then
    start_pos = vim.fn.getpos "v"
    end_pos = vim.fn.getpos "."
  else
    mode = vim.fn.visualmode()
    start_pos = vim.fn.getpos "'<"
    end_pos = vim.fn.getpos "'>"
  end

  local srow, scol = start_pos[2], start_pos[3]
  local erow, ecol = end_pos[2], end_pos[3]

  if srow > erow or (srow == erow and scol > ecol) then
    srow, erow = erow, srow
    scol, ecol = ecol, scol
  end

  return mode, srow, scol, erow, ecol
end

function M.get_visual_selection()
  local mode, srow, scol, erow, ecol = get_visual_bounds()
  if srow == 0 or erow == 0 then return "" end

  if mode == "V" then
    local lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
    return table.concat(lines, "\n")
  end

  local lines = vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
  return table.concat(lines, "\n")
end

function M.get_visual_one_line()
  local text = M.get_visual_selection()
  text = text:gsub("\n", " ")
  text = text:gsub("%s+", " ")
  return vim.trim(text)
end

function M.save_session_and_quit()
  local resession = require "resession"
  local info = resession.get_current_session_info()

  if info and info.name then
    resession.save(info.name, {
      dir = info.dir,
      notify = false,
    })
  else
    resession.save(vim.fn.getcwd(), {
      dir = "dirsession",
      notify = false,
    })
  end

  vim.cmd "qa"
end

local function is_real_file_buffer(bufnr)
  return vim.api.nvim_buf_is_valid(bufnr)
    and vim.bo[bufnr].buflisted
    and vim.bo[bufnr].buftype == ""
    and vim.api.nvim_buf_get_name(bufnr) ~= ""
end

local function save_all_real_files()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if is_real_file_buffer(bufnr) and vim.bo[bufnr].modified then
      pcall(vim.api.nvim_buf_call, bufnr, function() vim.cmd "silent update" end)
    end
  end
end

local function close_new_buffers(before, keep_buf)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if not before[bufnr] and is_real_file_buffer(bufnr) and bufnr ~= keep_buf and not vim.bo[bufnr].modified then
      pcall(vim.api.nvim_buf_delete, bufnr, {})
    end
  end
end

function M.rename_save_and_cleanup()
  local bufnr = vim.api.nvim_get_current_buf()
  local winid = vim.api.nvim_get_current_win()
  local current_name = vim.fn.expand "<cword>"

  local client = nil
  for _, c in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
    if c.supports_method and c:supports_method "textDocument/rename" then
      client = c
      break
    end
  end

  if not client then
    vim.notify("No LSP rename available here", vim.log.levels.WARN)
    return
  end

  local before = {}
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if is_real_file_buffer(b) then before[b] = true end
  end

  vim.ui.input({ prompt = "Rename to: ", default = current_name }, function(new_name)
    if not new_name or new_name == "" or new_name == current_name then return end

    local pos = vim.lsp.util.make_position_params(winid, client.offset_encoding)
    local params = {
      textDocument = pos.textDocument,
      position = pos.position,
      newName = new_name,
    }

    client:request("textDocument/rename", params, function(err, result)
      if err then
        vim.schedule(function() vim.notify(("Rename failed: %s"):format(err.message), vim.log.levels.ERROR) end)
        return
      end

      if not result then
        vim.schedule(function() vim.notify("Rename returned no changes", vim.log.levels.WARN) end)
        return
      end

      vim.schedule(function()
        vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)
        save_all_real_files()
        close_new_buffers(before, bufnr)

        if vim.api.nvim_win_is_valid(winid) and vim.api.nvim_buf_is_valid(bufnr) then
          pcall(vim.api.nvim_set_current_win, winid)
          if vim.api.nvim_win_get_buf(winid) ~= bufnr then pcall(vim.api.nvim_win_set_buf, winid, bufnr) end
        end
      end)
    end, bufnr)
  end)
end

function M.strip_trailing_whitespace_all_buffers()
  local current = vim.api.nvim_get_current_buf()

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" and vim.bo[buf].buftype == "" then
        vim.api.nvim_buf_call(buf, function()
          vim.cmd [[silent! %s/\s\+$//e]]
          vim.cmd "silent update"
        end)
      end
    end
  end

  vim.api.nvim_set_current_buf(current)
  vim.notify "Trailing whitespace removed"
end

function M.strip_trailing_whitespace_current_buffer()
  vim.cmd [[silent! %s/\s\+$//e]]
  vim.cmd "silent update"
  vim.notify "Trailing whitespace removed"
end

return M

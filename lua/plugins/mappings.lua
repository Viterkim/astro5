---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        ["j"] = {
          function()
            local key = vim.api.nvim_replace_termcodes("<C-o>", true, false, true)
            vim.api.nvim_feedkeys(key, "n", false)
          end,
          desc = "Jump Back",
        },
        ["J"] = {
          function()
            local key = vim.api.nvim_replace_termcodes("<C-i>", true, false, true)
            vim.api.nvim_feedkeys(key, "n", false)
          end,
          desc = "Jump Forward",
        },
        ["l"] = { "o<esc>", desc = "New Line Below" },
        ["r"] = { "<C-u>", desc = "Page Up" },
        ["s"] = { "<C-d>", desc = "Page Down" },
        ["S"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["R"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Prev buffer" },
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        ["gd"] = { function() vim.lsp.buf.definition() end, desc = "LSP Definition" },
        ["gy"] = { function() vim.lsp.buf.type_definition() end, desc = "LSP Type Definition" },
        ["grr"] = { function() require("snacks").picker.lsp_references() end, desc = "Show References" },
        ["gI"] = { function() vim.lsp.buf.implementation() end, desc = "LSP Implementation" },
        ["ø"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
        ["<leader>if"] = { function() vim.lsp.buf.code_action() end, desc = "LSP Fixes" },
        ["<leader>id"] = { function() vim.diagnostic.open_float() end, desc = "Float diagnostics" },
        ["<leader>ic"] = {
          function()
            vim.diagnostic.open_float()
            vim.diagnostic.open_float()
            vim.cmd "normal! ggVGy"
            vim.cmd "close"
          end,
          desc = "Copy diagnostics",
        },
        ["<leader>ii"] = { function() require("snacks").picker.diagnostics() end, desc = "All diagnostics" },
        ["<leader>ir"] = { function() require("snacks").picker.lsp_references() end, desc = "Show References" },
        ["<leader>ff"] = { function() require("snacks").picker.files() end, desc = "Find Files" },
        ["<leader>fw"] = { function() require("snacks").picker.grep() end, desc = "Find Words" },
        ["<leader>iy"] = { "<cmd>let @+=expand('%:~:.')<cr>", desc = "Copy relative path" },
        ["<leader>ix"] = { "<cmd>e ++ff=unix<cr>", desc = "Fix windows endlines" },
        ["<leader>ib"] = { "<cmd>RustLsp debug<cr>", desc = "Debug Function" },
        ["<leader>ip"] = { "<cmd>AerialPrev<cr><cmd>RustLsp debug<cr>", desc = "Debug Prev Func" },
        ["<leader>io"] = { function() require("crates").show_features_popup() end, desc = "Crate Features" },
        ["<leader>iu"] = { "<cmd>AerialNavOpen<cr>", desc = "Aerial Nav" },
        ["<leader>is"] = {
          "<cmd>AerialPrev<cr><cmd>RustLsp hover actions<cr><cmd>RustLsp hover actions<cr>",
          desc = "Hover Actions",
        },
        ["<leader>it"] = {
          function()
            vim.lsp.buf.hover()
            vim.lsp.buf.hover()
          end,
          desc = "Hover Enter",
        },
        ["<leader>ti"] = { function() require("neotest").output.open { enter = true } end, desc = "Neotest Output" },
        ["<leader>q"] = { "<cmd>q<CR>", desc = "Quit window" },
        ["<leader>,a"] = { '<cmd>lua require("spectre").open()<CR>', desc = "Spectre" },
        ["<leader>,w"] = { '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Spectre Word" },
        ["<leader>,p"] = {
          '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
          desc = "Spectre File",
        },
        ["__"] = { ":w<cr>", desc = "Save File" },
        ["<Backspace>"] = { "x", desc = "Delete char" },
        ["de"] = { "<S-v>ygvd", desc = "Cut Line" },
        ["<S-Up>"] = { "<cmd>m-2<cr>", desc = "Move line up" },
        ["<S-Down>"] = { "<cmd>m+<cr>", desc = "Move line down" },
        ["<S-l>"] = { "<cmd>:call vm#commands#add_cursor_up(0, 1)<cr>", desc = "Multicursor up" },
        ["<S-u>"] = { "<cmd>:call vm#commands#add_cursor_down(0, 1)<cr>", desc = "Multicursor down" },
        ["H"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move left" },
        ["h"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move right" },
        ["k"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move down" },
        ["K"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move up" },
        ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
        ["<C-y>"] = {
          function()
            local new_val = not vim.diagnostic.config().virtual_lines
            vim.diagnostic.config { virtual_lines = new_val }
          end,
          desc = "Toggle lsp_lines",
        },
        ["<C-b>"] = { "<esc>$a;<esc>", desc = "Insert ; at end" },
        ["<C-t>"] = { "<esc>", desc = "Escape" },
      },
      i = {
        ["<C-y>"] = {
          function()
            local new_val = not vim.diagnostic.config().virtual_lines
            vim.diagnostic.config { virtual_lines = new_val }
          end,
          desc = "Toggle lsp_lines",
        },
        ["<C-b>"] = { "<esc>$a;<esc>:w<cr>", desc = "Insert ; and save" },
        ["<C-s>"] = { "<esc>:w<cr>a", desc = "Save File" },
        ["<C-t>"] = { "<esc>", desc = "Normal Mode" },
        ["<C-p>"] = { "<esc>p", desc = "Paste" },
        ["<C-f>"] = { "<esc>P", desc = "Paste before" },
        ["<C-d>"] = { function() require("lsp_signature").toggle_float_win() end, desc = "LSP Signature" },
        ["__"] = { "<esc>:w<cr>", desc = "Save & Normal" },
        ["_("] = { "_", desc = "Literal underscore" },
      },
      v = {
        ["r"] = { "<C-u>" },
        ["s"] = { "<C-d>" },
        ["j"] = { "<esc>", desc = "Normal Mode" },
        ["<S-Up>"] = { "<cmd>m-2<cr>", desc = "Move line up" },
        ["<S-Down>"] = { "<cmd>m+<cr>", desc = "Move line down" },
        ["<C-y>"] = {
          function()
            local new_val = not vim.diagnostic.config().virtual_lines
            vim.diagnostic.config { virtual_lines = new_val }
          end,
          desc = "Toggle lsp_lines",
        },
        ["<C-t>"] = { "<esc>", desc = "Normal Mode" },
        ["<C-b>"] = { "<esc>$a;<esc>", desc = "Insert ;" },
        ["__"] = { "<esc>:w<cr>", desc = "Save & Normal" },
        ["<Backspace>"] = { "x", desc = "Delete" },
        ["o"] = { "ygvd", desc = "Cut" },
        ["c"] = { "ygv", desc = "Copy" },
      },
    },
  },
}

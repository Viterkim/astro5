return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["j"] = { "<C-o>", desc = "Jump Back" },
          ["J"] = { "<C-i>", desc = "Jump Forward" },
          ["l"] = { "o<esc>", desc = "New Line Below" },
          ["r"] = { "<C-u>", desc = "Page Up" },
          ["s"] = { "<C-d>", desc = "Page Down" },

          -- Splits
          ["H"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move left split" },
          ["h"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move right split" },
          ["k"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move down split" },
          ["K"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move up split" },

          -- Buffers
          ["S"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["R"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

          -- Shift Movements
          ["<S-Up>"] = { "<cmd>m-2<cr>", desc = "Move line up" },
          ["<S-Down>"] = { "<cmd>m+<cr>", desc = "Move line down" },

          -- Custom Edits
          ["<Bs>"] = { "x", desc = "Delete Char" },
          ["de"] = { "<S-v>ygvd", desc = "Cut Line" },
          ["__"] = { ":w<cr>", desc = "Save File" },
          ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
          ["<C-b>"] = { "<esc>$a;<esc>", desc = "Insert ; at end" },
          ["<C-t>"] = { "<esc>", desc = "Escape spam" },

          -- Plugins: Visual Multi
          ["<S-l>"] = { "<cmd>:call vm#commands#add_cursor_up(0, 1)<cr>", desc = "Multicursor up" },
          ["<S-u>"] = { "<cmd>:call vm#commands#add_cursor_down(0, 1)<cr>", desc = "Multicursor down" },

          -- Plugins: Spectre
          ["<leader>,a"] = { '<cmd>lua require("spectre").open()<CR>', desc = "Spectre" },
          ["<leader>,w"] = { '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Spectre Word" },
          ["<leader>,p"] = {
            '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
            desc = "Spectre File",
          },

          -- Plugins: Utilities
          ["<leader>iy"] = { "<cmd>let @+=expand('%:~:.')<cr>", desc = "Copy relative path" },
          ["<leader>ix"] = { "<cmd>e ++ff=unix<cr>", desc = "Fix windows endlines" },
          ["<leader>q"] = { "<cmd>q<CR>", desc = "Quit window" },

          -- Plugins: Testing
          ["<leader>ti"] = { function() require("neotest").output.open { enter = true } end, desc = "Neotest Output" },

          -- Plugins: Telescope (General)
          ["grr"] = { function() require("telescope.builtin").lsp_references() end, desc = "Show References" },
          ["<leader>ii"] = { function() require("telescope.builtin").diagnostics() end, desc = "All diagnostics" },
          ["<leader>ir"] = { function() require("telescope.builtin").lsp_references() end, desc = "Show References" },

          -- Toggles
          ["<C-y>"] = { function() require("lsp_lines").toggle() end, desc = "Toggle lsp_lines" },

          -- i stuff
          ["<leader>if"] = { function() vim.lsp.buf.code_action() end, desc = "LSP Fixes" },
          ["<leader>id"] = { function() vim.diagnostic.open_float() end, desc = "Float diagnostics" },
          ["<leader>it"] = {
            function()
              vim.lsp.buf.hover()
              vim.lsp.buf.hover()
            end,
            desc = "Hover enter",
          },
          ["ø"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol" },

          -- Rust / Crate specific
          ["<leader>ib"] = { "<cmd>RustLsp debug<cr>", desc = "Debug Function" },
          ["<leader>is"] = {
            "<cmd>AerialPrev<cr><cmd>RustLsp hover actions<cr><cmd>RustLsp hover actions<cr>",
            desc = "Hover Actions",
          },
          ["<leader>io"] = { function() require("crates").show_features_popup() end, desc = "Crate Features" },

          -- Aerial specific
          ["<leader>ip"] = { "<cmd>AerialPrev<cr><cmd>RustLsp debug<cr>", desc = "Debug Prev Func" },
          ["<leader>iu"] = { "<cmd>AerialNavOpen<cr>", desc = "Aerial Nav" },

          -- Diagnostics Copy Hack
          ["<leader>ic"] = {
            function()
              vim.diagnostic.open_float()
              vim.diagnostic.open_float()
              vim.cmd "normal! ggVGy"
              vim.cmd "close"
            end,
            desc = "Copy diagnostics",
          },
        },
        -- Insert Mode
        i = {
          ["<C-y>"] = { function() require("lsp_lines").toggle() end, desc = "Toggle lsp_lines" },
          ["<C-b>"] = { "<esc>$a;<esc>:w<cr>", desc = "Insert ; and save" },
          ["<C-s>"] = { "<esc>:w<cr>a", desc = "Save File" },
          ["<C-t>"] = { "<esc>", desc = "Normal mode" },
          ["<C-p>"] = { "<esc>p", desc = "Paste" },
          ["<C-f>"] = { "<esc>P", desc = "Paste before" },
          ["<C-d>"] = { function() require("lsp_signature").toggle_float_win() end, desc = "Toggle signature" },
          ["__"] = { "<esc>:w<cr>", desc = "Save & Normal" },
          ["_("] = { "_", desc = "Literal Underscore" },
        },
        -- Visual Mode
        v = {
          ["r"] = { "<C-u>" },
          ["s"] = { "<C-d>" },
          ["<S-Up>"] = { "<cmd>m-2<cr>", desc = "Move line up" },
          ["<S-Down>"] = { "<cmd>m+<cr>", desc = "Move line down" },
          ["<C-y>"] = { function() require("lsp_lines").toggle() end, desc = "Toggle lsp_lines" },
          ["<C-t>"] = { "<esc>", desc = "Normal mode" },
          ["j"] = { "<esc>", desc = "Normal mode" },
          ["<C-b>"] = { "<esc>$a;<esc>", desc = "Insert ;" },
          ["__"] = { "<esc>:w<cr>", desc = "Save & Normal" },
          ["<Bs>"] = { "x", desc = "Delete" },
          ["o"] = { "ygvd", desc = "Cut" },
          ["c"] = { "ygv", desc = "Copy selection" },
        },
      },
    },
  },
}

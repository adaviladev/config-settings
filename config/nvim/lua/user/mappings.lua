local utils = require "user.utils"

return {
  -- first key is the mode
  n = {
    ["<localleader>m"] = {
      function()
        vim.notify('using a buffer keymap', 3)
      end,
      desc = 'Use a localleader keymap',
    },
    ["<leader>W"] = { "<cmd>wa<cr>", desc = "Save all" },
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["<leader>c"] = {
      function()
        local bufs = vim.fn.getbufinfo({ buflisted = true })
        require("astronvim.utils.buffer").close(0)
        if require("astronvim.utils").is_available("alpha-nvim") and not bufs[2] then
          require("alpha").start(true)
        end
      end,
      desc = "Close buffer",
    },
    -- Bookmarks
    ["<leader>fS"] = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = "Search for symbol in workspace" },
    -- Grapple
    ["<leader>m"] = { name = "󰓾 Handle File Marks" },
    ["<leader>'"] = { name = "󰓾 Jump to File Marks" },
    -- ["<leader>f'"] = { function () require('grapple').popup_tags() end, desc = "List all marks"},
    ["<leader>mf"] = { function() require('grapple').popup_tags() end, desc = "List all tags" },
    ["<leader>mF"] = { function() require('grapple').popup_scopes() end, desc = "List all scopes" },
    ["<leader>ma"] = { function() require("grapple").tag() end, desc = "Add Grapple tag to file" },
    ["<leader>md"] = { function() require("grapple").untag() end, desc = "Remove file from Grapple tag list" },

    ["<leader>'t"] = { function() require("grapple").select({ key = "test" }) end, desc = "Jump to the [test] tag" },
    ["<leader>mt"] = { function() require("grapple").tag({ key = "test" }) end, desc = "Tag as [test]" },
    ["<leader>'s"] = { function() require("grapple").select({ key = "subject" }) end, desc = "Jump to the [subject] tag" },
    ["<leader>ms"] = { function() require("grapple").tag({ key = "subject" }) end, desc = "Tag as [subject]" },
    ["<leader>'w"] = { function() require("grapple").select({ key = "primary" }) end, desc = "Jump to [primary] tag" },
    ["<leader>mw"] = { function() require("grapple").tag({ key = "primary" }) end, desc = "Tag as [primary]" },
    ["<leader>'e"] = { function() require("grapple").select({ key = "secondary" }) end, desc = "Jump to [secondary] tag" },
    ["<leader>me"] = { function() require("grapple").tag({ key = "secondary" }) end, desc = "Tag as [secondary]" },
    ["<leader>'r"] = { function() require("grapple").select({ key = "tertiary" }) end, desc = "Jump to [tertiary] tag" },
    ["<leader>mr"] = { function() require("grapple").tag({ key = "tertiary" }) end, desc = "Tag as [tertiary]" },
    -- ["<leader>ml"] = { function () require("harpoon.ui").nav_next() end, desc = "Navigate to previous harpoon mark" },
    -- ["<leader>mh"] = { function () require("harpoon.ui").nav_prev() end, desc = "Navigate to next harpoon mark" },
    -- ISwap
    ["Q"] = { "<cmd>ISwapWith<cr>" },
    [">p"] = { "<cmd>ISwapWithRight<cr>", desc = "Swap node with right" },
    ["<p"] = { "<cmd>ISwapWithLeft<cr>", desc = "Swap node with left" }, -- better search
    n = { utils.better_search "nzz", desc = "Next search" },
    N = { utils.better_search "Nzz", desc = "Previous search" },         -- quick save
    -- NeoTeset
    ["<F4>"] = { name = "NeoTest", },
    ["<F4>n"] = { function() require("neotest").run.run() end, desc = "Run nearest test" },
    ["<F4>f"] = { function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test the entire file" },
    ["<F4>d"] = { function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
    ["<F4>e"] = { function() require("neotest").run.stop() end, desc = "Stop nearest test" },
    ["<F4>a"] = { function() require("neotest").run.attach() end, desc = "Attach to the nearest test" },
    ["<F4>o"] = { function() require("nejotest").output_panel.toggle() end, desc = "View the output" },
    ["<F4>s"] = { function() require("neotest").summary.toggle() end, desc = "View the output" },
    ["gr"] = { "<cmd>Telescope lsp_references<cr>", desc = "Go to references" },
    -- Telescope
    ["<leader>fo"] = { function() require("telescope.builtin").oldfiles({ cwd_only = true }) end, desc = "Find history" },
    ['<leader>fd'] = { '<cmd>Telescope dir live_grep<CR>', desc = 'Find words in directory' },
    ['<leader>fe'] = { '<cmd>Telescope env<CR>', desc = 'Find env values' },
    X = { "x~", desc = "Delete current character and capitalize the next" },
    ["<leader>/"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)<cr>j",
      desc = "Toggle comment line",
    },
    -- Copying
    ['<localleader>y'] = { name = 'Copy...' },
    ['<localleader>yp'] = { function() vim.fn.setreg('+', vim.fn.expand('%:p:.')) end, desc = 'Copy file path' },
    ['<localleader>yd'] = { function() vim.fn.setreg('+', vim.fn.expand('%:h')) end, desc = 'Copy directory path' },
    ['<localleader>yf'] = { function() vim.fn.setreg('+', vim.fn.expand('%:t')) end, desc = 'Copy file name' },
    ['<localleader>yg'] = {
      function()
        vim.fn.setreg('+', vim.fn.expand('%:t'))
      end,
      desc = 'Copy file name'
    },
  },
  i = {
  },
  v = {
    ["<"] = { "<gv", desc = "Unindent without losing selection" },
    [">"] = { ">gv", desc = "Indent without losing selection" },
    ["p"] = { '"_dP', desc = "Paste yanked text without losing the original contents" },
    ["y"] = { "myy`y", desc = "Yank in visual mode without losing cursor position" },
    ["<leader>/"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>j",
      desc = "Toggle comment for selection",
    }
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}

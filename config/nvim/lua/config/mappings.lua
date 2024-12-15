local astro = require "astrocore"
local utils = require "helpers.utils"
local ls = require "luasnip"

local function setFileTag(tagName)
  return {
    function()
      local grapple = require "grapple"
      if not grapple.exists { name = tagName } then
        grapple.tag { name = tagName }
      else
        local tag = grapple.find { name = tagName }
        if tag == nil then return end

        vim.ui.select({
          "yes",
          "no",
        }, { prompt = "Overwrite [" .. tag.name .. "]" }, function(selection)
          if selection ~= nil and selection == "yes" then grapple.tag { name = tagName } end
        end)
      end
    end,
    desc = "Tag as [" .. tagName .. "]",
  }
end

local function jumpToFileTag(tagName)
  return {
    function()
      require("grapple").select { name = tagName }
    end,
    desc = "Jump to the [" .. tagName .. "] tag",
  }
end

return {
  -- first key is the mode
  n = {
    ["<A-j>"] = { "5j" },
    ["<A-k>"] = { "5k" },
    ["<C-Tab>"] = { "gt", desc = "Go to next tab" },
    ["<C-S-Tab>"] = { "gT", desc = "Go to previous tab" },
    ["<F3>"] = { function() vim.cmd('TermExec cmd="dock deno run ' .. vim.fn.expand('%:t') .. '"' ) end, desc = "Run current AoC file" },

    ["<Leader><Leader>e"] = { "<cmd>e<CR>", desc = "Reload the file"},
    ["<Leader><Leader>s"] = {
      function()
        local file_type = vim.bo.filetype
        local files = vim.split(vim.fn.glob("~/.config/nvim/snippets/" .. file_type .. "/*"), "\n")
        for _, file in pairs(files) do
          require("luasnip.loaders").reload_file(file)
        end
      end,
    },
    ["<Leader>uG"] = {
      '<cmd>Gitsigns toggle_current_line_blame<CR>',
      desc = "Toggle current line blame",
    },
    ["<Leader>un"] = {
      function() vim.o.relativenumber = vim.o.relativenumber ~= true end,
      desc = "Toggle relativenumber",
    },
    ["<Leader>W"] = { "<cmd>wa<cr>", desc = "Save all" },
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<Leader>bD"] = {
      function()
        require("astroui.status").heirline.buffer_picker(function(bufnr) require("astroui.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<Leader>b"] = { name = "Buffers" },
    ["<Leader>c"] = {
      function()
        local bufs = vim.fn.getbufinfo { buflisted = true }
        require("astrocore.buffer").close(0)
        if require("astrocore").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
      end,
      desc = "Close buffer",
    },
    -- Grapple
    ["<Leader>m"] = { name = "󰓾 Handle file tags" },
    ["<Leader>'"] = { name = "󰓾 Jump to file tags" },
    ["<Leader>mf"] = { function() require("grapple").open_tags() end, desc = "List all tags" },
    ["<Leader>mT"] = { "<cmd>Telescope grapple tags", desc = "List all tags" },
    ["<Leader>mF"] = { function() require("grapple").open_loaded() end, desc = "List all scopes" },
    ["<Leader>ma"] = { function() require("grapple").tag() end, desc = "Add Grapple tag to file" },
    ["<Leader>md"] = { function() require("grapple").untag() end, desc = "Remove file from Grapple tag list" },

    ["<Leader>mt"] = setFileTag "test",
    ["<Leader>'t"] = jumpToFileTag "test",
    ["<Leader>ms"] = setFileTag "subject",
    ["<Leader>'s"] = jumpToFileTag "subject",
    ["<Leader>mw"] = setFileTag "primary",
    ["<Leader>'w"] = jumpToFileTag "primary",
    ["<Leader>me"] = setFileTag "secondary",
    ["<Leader>'e"] = jumpToFileTag "secondary",
    ["<Leader>mr"] = setFileTag "tertiary",
    ["<Leader>'r"] = jumpToFileTag "tertiary",
    ["<Leader>mu"] = setFileTag "scratch",
    ["<Leader>'u"] = jumpToFileTag "scratch",
    ["<Leader>ml"] = setFileTag "log",
    ["<Leader>'l"] = jumpToFileTag "log",

    -- ISwap
    ["Q"] = { "<cmd>ISwapWith<cr>" },
    [">p"] = { "<cmd>ISwapWithRight<cr>", desc = "Swap node with right" },
    ["<p"] = { "<cmd>ISwapWithLeft<cr>", desc = "Swap node with left" }, -- better search
    n = { utils.better_search "nzz", desc = "Next search" },
    N = { utils.better_search "Nzz", desc = "Previous search" }, -- quick save

    -- CLI TUIs
    ["<F8>"] = { name = "CLI TUIs" },
    ["<Leader>t?"] = { function() astro.toggle_term_cmd({ direction = 'float', cmd = 'btm' }) end, desc = "Toggleterm Btm" },
    ["<Leader>dt"] = {
      function() astro.toggle_term_cmd({ direction = 'float', cmd = 'dart tinker' }) end,
      desc = "Toggleterm Artisan for current Docker container",
    },
    ["<Leader>db"] = {
      function() astro.toggle_term_cmd({ direction = 'float', cmd = 'dbash' }) end,
      desc = "Toggleterm Artisan Tinker for current Docker container",
    },
    ["<Leader>tg"] = { function() astro.toggle_term_cmd({ direction = 'float', cmd = "gh dash"} ) end, desc = "Toggleterm Github Dash" },
    ["<Leader>tn"] = { function() astro.toggle_term_cmd({ direction = 'float', cmd = "lazynpm"} ) end, desc = "Toggleterm LazyNPM" },
    ["<Leader>ty"] = { function() astro.toggle_term_cmd({ direction = 'float', cmd = "yazi"} ) end, desc = "Toggleterm Yazi" },
    ["<F8>f"] = { "F>ldiwi<BS><BS>['']<Esc>hhp", desc = "Class property to array key" },

    -- NeoTeset
    ["<F4>"] = { name = "Testing" },
    ["<F4><F4>"] = {
      function() require("php-dev-tools.test_utils").test_last_test() end,
      desc = "Rerun the previous test",
    },
    ["<F4>n"] = { function() require("php-dev-tools.test_utils").test_nearest_method() end, desc = "Run nearest test" },
    ["<F4>f"] = {
      function() require("php-dev-tools.test_utils").test_current_file() end,
      desc = "Test the entire file",
    },
    ["<F4>g"] = { function() require("php-dev-tools.test_utils").test_group() end, desc = "Select a group to test" },

    -- Telescope
    ["<Leader>fo"] = {
      function() require("telescope.builtin").oldfiles({ cwd_only = true }) end,
      desc = "Find history",
    },
    ["<Leader>fH"] = {
      function()
        vim.ui.select(
          {
            'vendor',
            'node_modules',
          },
          {
            prompt = 'Select an ignored directory:',
          },
          function (selection)
            require("telescope.builtin").find_files {
              prompt_title = selection .. "Files",
              cwd = vim.fn.getcwd() .. "/" .. selection,
              follow = true,
            }
          end
        )
      end,
      desc = "Find in node_modules",
    },
    ["<Leader>fd"] = { "<cmd>Telescope dir live_grep<CR>", desc = "Find words in directory" },
    ["<Leader>fe"] = { "<cmd>Telescope telescope-env env_values theme=dropdown<CR>", desc = "Find env values" },
    ["<Leader>f_"] = { "<cmd>ScratchOpen<cr>", desc = "Open a Scratch file" },
    ["<Leader>fs"] = { "<cmd>Telescope luasnip<cr>", desc = "Search for snippets" },
    ["<Leader>fS"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Search for symbol in workspace" },
    ["<Leader>ff"] = { function() require('config.telescope.multigrep').live_multigrep() end, desc = "Search for symbol in workspace" },
    ["<Leader>fl"] = { name = "Laravel" },
    ["<Leader>fla"] = { "<cmd>Telescope laravel artisan<CR>", desc = "Laravel artisan commands" },
    ["<Leader>flr"] = { "<cmd>Telescope laravel routes<CR>", desc = "Laravel artisan routes" },

    -- Laravel.nvim
    ['<Leader>L'] = { name = "Laravel.nvim mappings" },
    ['<Leader>Lr'] = { "<cmd>Laravel routes<cr>", desc = "Laravel routes" },
    ['<Leader>La'] = { "<cmd>Laravel artisan<cr>", desc = "Laravel artisan" },
    ['<Leader>Lc'] = { "<cmd>Laravel commands<cr>", desc = "Laravel commands" },
    ['<Leader>Lm'] = { "<cmd>Laravel make<cr>", desc = "Laravel routes" },

    -- Notify
    ["<Leader>uD"] = { function() require("notify").dismiss() end, desc = "Dismiss all displayed notifications" },

    X = { "x~", desc = "Delete current character and capitalize the next" },
    ["<C-i>"] = { "<C-i>zz", desc = "Jump forward and center" },
    ["<C-o>"] = { "<C-o>zz", desc = "Jump backward and center" },

    ["<LocalLeader>e"] = { "<cmd>e<CR>",desc = "Copy file path" },

    -- Copying
    ["<LocalLeader>y"] = { name = "󰆏 Copy..." },
    ["<LocalLeader>yp"] = { function() vim.fn.setreg("+", vim.fn.expand "%:p:.") end, desc = "Copy file path" },
    ["<LocalLeader>yd"] = { function() vim.fn.setreg("+", vim.fn.expand "%:h") end, desc = "Copy directory path" },
    ["<LocalLeader>yf"] = { function() vim.fn.setreg("+", vim.fn.expand "%:t:r") end, desc = "Copy file name" },

    -- Phpactor.nvim
    ['<LocalLeader>p'] = { name = "Phpactor.nvim mappings" },
    ['<LocalLeader>pc'] = { '<cmd>PhpactorContextMenu<cr>', desc = "Context Menu" },
    ['<LocalLeader>pt'] = { '<cmd>PhpactorTransform<cr>', desc = "Transform file" },

    -- Scratch
    ["<C-n>"] = {
      "<cmd>Scratch<CR>",
      desc = "Open new scratch file",
    },

    -- TreeSJ
    ["gS"] = {
      function() require("treesj").split() end,
      desc = "TreeSJ split",
    },
    ["gJ"] = { function() require("treesj").join() end, desc = "TreeSJ join" },

    -- Git
    ["<Leader>gB"] = { "<cmd>G blame<cr>", desc = "Commit annotations" },

    ["ga"] = { "GA", desc = "Start inserting at the end of the last line" },
    ["go"] = { "Go", desc = "Start inserting after the last line" },

    -- Undotree
    ["<Leader>z"] = { name = "Undotree" },
    ["<Leader>zz"] = { function() require("undotree").toggle() end, desc = "Toggle Undotree" },
  },
  i = {
    -- Luasnip
    ["<C-k>"] = {
      function()
        if ls.jumpable(-1) then ls.jump(-1) end
      end,
      desc = "Jump to previous snippet",
      silent = true,
    },
    ["<C-j>"] = {
      function()
        if ls.jumpable() then ls.jump(1) end
      end,
      desc = "Jump to next snippet",
      silent = true,
    },
    ["<C-h>"] = {
      function()
        if ls.choice_active() then ls.change_choice(-1) end
      end,
      desc = "Cycle through active choices",
    },
    ["<C-l>"] = {
      function()
        if ls.choice_active() then ls.change_choice(1) end
      end,
      desc = "Cycle through active choices",
    },
  },
  v = {
    ["<"] = { "<gv", desc = "Unindent without losing selection" },
    [">"] = { ">gv", desc = "Indent without losing selection" },
    ["p"] = { '"_dP', desc = "Paste yanked text without losing the original contents" },
    ["y"] = { "ymy", desc = "Yank in visual mode without losing cursor position" },
    ["<Leader>/"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>j",
      desc = "Toggle comment for selection",
    },
  },
  t = {
    -- setting a mapping to false will disable it
    ["<F8>"] = { "<C-\\><C-n>" },
  },
}

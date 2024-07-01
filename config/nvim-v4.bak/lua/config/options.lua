return {
  opt = { -- vim.opt.<key>
    autoread = true,
    number = true, -- sets vim.opt.number
    relativenumber = true, -- sets vim.opt.relativenumber
    scrolloff = 8,
    spell = true, -- sets vim.opt.spell
    spelloptions = 'camel',
    signcolumn = 'yes:1', -- sets vim.opt.signcolumn to auto
    whichwrap = 'b,s,<,>',
    wrap = true, -- sets vim.opt.wrap
  },
  g = { -- vim.g.<key>
    -- configure global vim variables (vim.g)
    -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
    -- This can be found in the `lua/lazy_setup.lua` file
    autoformat_enabled = false,
    autopairs_enabled = true,
    cmp_enabled = true,
    diagnostics_mode = 1,
    format_on_save = false,
    icons_enabled = true,
    resession_enabled = false,
    ui_notifications_enabled = false, -- disable notifications when toggling UI elements
  },
}

local wezterm = require('wezterm')
local M = {}

function M.setup(config)
  config.font = wezterm.font('JetBrainsMono Nerd Font', {
    weight = 'Regular',
  })
  config.font_size = 16.0
end

return M

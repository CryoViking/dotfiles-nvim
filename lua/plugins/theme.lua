local opt = vim.opt

opt.relativenumber = false

-- This is for nord if I ever decide to enable it.
vim.g.nord_bold = false
vim.g.nord_italic = false
vim.g.nord_disable_background = true

return {
  -- my theme <3
  {
    "cryo_themes",
    dir = "~/.config/nvim/lua/plugins/themes/cryo_themes.nvim",
    config = function()
      local hostname = vim.fn.hostname()
      -- print(hostname) -- uncomment to get hostname of machine
      if hostname == "CryoForge.local" then
        require("cryo_themes").setup({
          style = "fallout4_enhanced",
          transparent = true,
        })
        vim.cmd.colorscheme("cryo_themes-fallout4_enhanced")
      elseif hostname == "CryoBeast" then
        require("cryo_themes").setup({
          style = "cyberpunk",
          transparent = true,
        })
        vim.cmd.colorscheme("cryo_themes-cyberpunk")
      end
    end,
  },
}

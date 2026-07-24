local opt = vim.opt

opt.relativenumber = false

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
          style = "sleeping_forest",
          transparent = true,
          styles = {
            comments = { italic = true },
          },
        })
        vim.cmd.colorscheme("cryo_themes-sleeping_forest")
      elseif hostname == "CryoGrimiore.local" then
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

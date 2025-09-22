local opt = vim.opt

opt.relativenumber = false

-- This is for nord if I ever decide to enable it.
vim.g.nord_bold = false
vim.g.nord_italic = false
vim.g.nord_disable_background = true

return {
  -- {
  --   "LazyVim/LazyVim",
  -- dependencies = {
  --   {
  --     dir = "~/.config/nvim/lua/plugins/themes/cryoviking.nvim",
  --     lazy = false,
  --   },
  -- },
  -- opts = {
  --   colorscheme = "cryoviking",
  -- },
  -- },
  -- {
  --   "~/.config/nvim/lua/plugins/themes/cryoviking.nvim",
  --   config = function()
  --     require("cryoviking").setup({
  --       transparent_mode = true,
  --     })
  --   end,
  -- },
  -- ====================================================
  -- Kanagawa Theme
  -- ====================================================
  {
    "rebelot/kanagawa.nvim",
    opts = {
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {
          cryo_matte_cyan = "#0eb8be",
        },
        theme = {
          wave = {},
          lotus = {},
          dragon = {},
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors) -- add/modify highlights
        local theme = colors.theme
        local palette = colors.palette
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = "none" },
          TelescopePromptBorder = { bg = "none", fg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { bg = "none", fg = theme.ui.fg_dim },
          TelescopeResultsBorder = { bg = "none", fg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = "none" },
          TelescopePreviewBorder = { bg = "none", fg = theme.ui.bg_dim },

          Constant = { fg = palette.cryo_matte_cyan },
          -- @keyword.return  ; things like return
          ["@keyword.return"] = { fg = palette.oniViolet },
          -- @constant.builtin ; built-in constant values
          ["@constant.builtin"] = { link = "Constant" },

          Macro = { fg = palette.waveAqua2 },
          -- @function.macro   ; preprocessor macros
          ["@function.macro"] = { link = "Macro" },

          -- Override boolean colour
          Boolean = { fg = palette.cryo_matte_cyan },
          ["@boolean"] = { link = "Boolean" },
        }
      end,
      theme = "wave", -- Load "wave" theme when 'background' option is not set
      background = { -- map the value of 'background' option to a theme
        dark = "dragon", -- try "dragon" !
        light = "lotus",
      },
    },
  },
  -- ====================================================
  -- Evergarden Theme
  -- ====================================================
  {
    "comfysage/evergarden",
    opts = {
      transparent_background = true,
      contrast_dark = "hard", -- 'hard'|'medium'|'soft'
      overrides = {}, -- add custom overrides
    },
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      transparent_background = true,
      terminalColors = true,
    },
  },
  {
    "shaunsingh/nord.nvim",
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        dark_variant = "moon",
        dim_inactive_windows = false,

        enable = {
          terminal = true,
        },

        styles = {
          bold = false,
          italic = false,
          transparency = true,
        },
      })

      -- if require("rose-pine").enable.terminal == true then
      --   vim.g.terminal_color_0 = "#232136"
      --   vim.g.terminal_color_1 = "#2a273f"
      --   vim.g.terminal_color_2 = "#393552"
      --   vim.g.terminal_color_3 = "#6e6a86"
      --   vim.g.terminal_color_4 = "#908caa"
      --   vim.g.terminal_color_5 = "#e0def4"
      --   vim.g.terminal_color_6 = "#e0def4"
      --   vim.g.terminal_color_7 = "#56526e"
      --   vim.g.terminal_color_8 = "#eb6f92"
      --   vim.g.terminal_color_9 = "#f6c177"
      --   vim.g.terminal_color_10 = "#ea9a97"
      --   vim.g.terminal_color_11 = "#3e8fb0"
      --   vim.g.terminal_color_12 = "#9ccfd8"
      --   vim.g.terminal_color_13 = "#c4a7e7"
      --   vim.g.terminal_color_14 = "#f6c177"
      --   vim.g.terminal_color_15 = "#56526e"
      -- end
    end,
  },
  {
    "Shadorain/shadotheme",
  },
  {
    "2giosangmitom/nightfall.nvim",
    lazy = false,
    priority = 1000,
    opts = {}, -- Add custom configuration here
    config = function(_, opts)
      require("nightfall").setup({
        integrations = {
          mini = { enabled = true, icons = true }, -- Enable support for mini.nvim
          native_lsp = { enabled = true, semantic_tokens = true },
          snacks = {
            enabled = true,
            dashboard = true,
            indent = true,
            picker = true,
          },
          blink = { enabled = true },
          flash = { enabled = true },
          fzf = {
            enabled = true,
            style = "borderless", -- or "bordered"
          },
          lazy = { enabled = true },
          treesitter = { enabled = true, context = true },
          render_markdown = { enabled = true },
          which_key = { enabled = true },
          noice = { enabled = true },
          neo_tree = { enabled = true },
          telescope = {
            enabled = true,
          },
          nvim_cmp = { enabled = true },
        },
      })
      -- vim.cmd("colorscheme nightfall") -- Choose from: nightfall, deeper-night, maron, nord
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "kanagawa",
      -- colorscheme = "evergarden",
      -- colorscheme = "nordfox",
      -- colorscheme = "nord",
      -- colorscheme = "rose-pine-moon",
      --   colorscheme = function()
      --     vim.cmd.colorscheme("shado")
      --     local function hl(...)
      --       vim.api.nvim_set_hl(0, ...)
      --     end
      --
      --     hl("Normal", { bg = "none" })
      --     hl("NormalFloat", { bg = "none" })
      --     hl("LineNr", { fg = "#505079", bg = "none" })
      --
      --     -- hl(0, "BufferLineFill", { fg = "#ffffff" })
      --     -- hl(0, "BufferLineBackground", { fg = "#ffffff" })
      --     -- hl(0, "BufferLineBufferSelected", { bold = true })
      --     -- hl(0, "BufferLineSeparator", { bg = "NONE", fg = "NONE" })
      --     -- hl(0, "BufferLineSeparatorSelected", {})
      --   end,
      -- },
      -- colorscheme = function()
      --   vim.cmd.colorscheme("kanagawa")
      --   local function hl(...)
      --     vim.api.nvim_set_hl(0, ...)
      --   end
      --   hl("Normal", { bg = "none" })
      --   hl("NormalFloat", { bg = "none" })
      --   hl("LineNr", { fg = "#505079", bg = "none" })
      --
      --   hl("BufferLineFill", { fg = "#ffffff" })
      --   hl("BufferLineBackground", { fg = "#ffffff", bg = "NONE" })
      --   hl("BufferLineBufferSelected", { bold = true })
      --   hl("BufferLineSeparator", { bg = "NONE", fg = "NONE" })
      --   hl("BufferLineSeparatorSelected", {})
      -- end,
      colorscheme = function()
        require("catppuccin").setup({
          flavour = "auto", -- latte, frappe, macchiato, mocha
          background = { -- :h background
            light = "latte",
            dark = "mocha",
          },
          transparent_background = false, -- disables setting the background color.
          float = {
            transparent = false, -- enable transparent floating windows
            solid = false, -- use solid styling for floating windows, see |winborder|
          },
          show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
          term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
          dim_inactive = {
            enabled = false, -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15, -- percentage of the shade to apply to the inactive window
          },
          no_italic = false, -- Force no italic
          no_bold = false, -- Force no bold
          no_underline = false, -- Force no underline
          styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
            -- miscs = {}, -- Uncomment to turn off hard-coded styles
          },
          color_overrides = {},
          custom_highlights = {},
          default_integrations = true,
          auto_integrations = false,
          integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = false,
            mini = {
              enabled = true,
              indentscope_color = "",
            },
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
          },
        })

        -- setup must be called before loading
        vim.cmd.colorscheme("catppuccin")
      end,
    },
  },
}

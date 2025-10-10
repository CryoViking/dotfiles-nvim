vim.o.scrolloff = 15

local update_quick_links = require("plugins.functions.update_quick_links")
vim.api.nvim_create_user_command("UpdateQuickLinks", update_quick_links.func, {
  desc = "Update the Quick Links section with all ### headers",
})

local create_word_link = require("plugins.functions.create_word_link")
vim.api.nvim_create_user_command("CreateWordLink", create_word_link.func, {
  desc = "Create a word link at the current cursor place to a header with the same word",
})

return {
  {
    "mason.nvim",
    { "mason-org/mason-lspconfig.nvim", config = function() end },
  },
  {
    "norcalli/nvim-colorizer.lua",
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        -- Global settings
        winopts = {
          height = 0.85,
          width = 0.80,
          row = 0.35,
          col = 0.50,
          border = "rounded",
          preview = {
            default = "bat",
            border = "border",
            wrap = "nowrap",
            hidden = "nohidden",
            vertical = "down:45%",
            horizontal = "right:50%",
            layout = "flex",
            flip_columns = 120,
          },
        },
        keymap = {
          fzf = {
            ["ctrl-q"] = "select-all+accept",
          },
        },
      })
    end,
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>tt", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
    },
  },
  {
    "folke/lazydev.nvim",
    opts = {
      library = {},
    },
  },
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "enter", -- Use custom preset
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = { documentation = { auto_show = false } },

      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
  -- SECTION: Configure NeoTree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_hidden = true,
          hide_by_name = {},
          hide_by_pattern = {},
          never_show = { -- completely prevent these directories from showing
            "bin",
            "obj",
          },
        },
      },
      follow_current_file = {
        enabled = false, -- This will find and focus the file in the active buffer every time
        --               -- the current file is changed while the tree is open.
        leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
  },
}

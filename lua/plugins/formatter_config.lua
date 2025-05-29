vim.g.OmniSharp_highlighting = 0

return {
  {
    "OmniSharp/omnisharp-vim",
  },
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  {
    "stevearc/conform.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      -- Leader, Code, Format
      {
        "<leader>cF",
        mode = { "n", "v" },
        function()
          require("conform").format({ formatters = { "injected" } })
        end,
        desc = "Format injected languages from lsp",
      },
    },
    opts = {
      default_format_opts = {
        timeout_ms = 5000,
        async = false,
        quiet = false,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        c = { "clang-format" },
        zig = { "zigfmt" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
    },
  },
  -- require("conform").setup({
  --   formatters_by_ft = {
  --     swift = { "swiftformat_ext" },
  --   },
  --   format_on_save = {
  --     timeout_ms = 500,
  --     lsp_fallback = true,
  --   },
  --   log_level = vim.log.levels.WARN,
  --   formatters = {
  --     swiftformat_ext = {
  --       command = "swiftformat",
  --       args = function(self, ctx)
  --         return { "--config", "~/.config/nvim/formatting/swiftformat", "--stdinpath", "$FILENAME" }
  --       end,
  --       range_args = function(self, ctx)
  --         return {
  --           "--config",
  --           "~/.config/nvim/.swiftformat",
  --           "--linerange",
  --           ctx.range.start[1] .. "," .. ctx.range["end"][1],
  --         }
  --       end,
  --       stdin = true,
  --       condition = function(self, ctx)
  --         return vim.fs.basename(ctx.filename) ~= "README.md"
  --       end,
  --     },
  --   },
  -- }),
}

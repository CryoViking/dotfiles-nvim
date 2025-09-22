require("fzf-lua").setup({
  "telescope", -- Use telescope-like defaults

  winopts = {
    height = 0.85,
    width = 0.80,
    row = 0.35,
    col = 0.50,
    border = "rounded",
    preview = {
      default = "bat", -- Use bat for syntax highlighting
      border = "border",
      wrap = "nowrap",
      hidden = "nohidden",
      vertical = "down:45%",
      horizontal = "right:50%",
      layout = "flex",
      flip_columns = 120,
    },
  },

  -- Configure individual pickers
  files = {
    prompt = "Files❯ ",
    multiprocess = true, -- run command in a separate process
    git_icons = true, -- show git status icons
    file_icons = true, -- show file icons
    color_icons = true, -- colorize file icons
    find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
    rg_opts = "--color=never --files --hidden --follow -g '!.git'",
    fd_opts = "--color=never --type f --hidden --follow --exclude .git",
  },

  grep = {
    prompt = "Rg❯ ",
    input_prompt = "Grep For❯ ",
    multiprocess = true,
    git_icons = true,
    file_icons = true,
    color_icons = true,
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
    grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
  },

  buffers = {
    prompt = "Buffers❯ ",
    file_icons = true,
    color_icons = true,
    sort_lastused = true,
  },

  git = {
    status = {
      prompt = "GitStatus❯ ",
      preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
    },
    commits = {
      prompt = "Commits❯ ",
      preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
    },
    bcommits = {
      prompt = "BCommits❯ ",
      preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
    },
    branches = {
      prompt = "Branches❯ ",
    },
  },

  lsp = {
    prompt_postfix = "❯ ",
    symbols = {
      symbol_style = 1, -- for nerd font users
      symbol_hl_prefix = "CmpItemKind",
    },
  },

  keymap = {
    builtin = {
      ["<F1>"] = "toggle-help",
      ["<F2>"] = "toggle-fullscreen",
      ["<F3>"] = "toggle-preview-wrap",
      ["<F4>"] = "toggle-preview",
      ["<F5>"] = "toggle-preview-ccw",
      ["<F6>"] = "toggle-preview-cw",
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    },
    fzf = {
      ["ctrl-q"] = "select-all+accept",
      ["ctrl-u"] = "unix-line-discard",
      ["ctrl-f"] = "half-page-down",
      ["ctrl-b"] = "half-page-up",
      ["ctrl-a"] = "beginning-of-line",
      ["ctrl-e"] = "end-of-line",
      ["alt-a"] = "toggle-all",
      ["alt-d"] = "deselect-all",
    },
  },
})

return {}

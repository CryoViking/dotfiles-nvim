require("lazydev").setup({
  library = { "nvim-dap-ui" },
})

return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "Cliffback/netcoredbg-macOS-arm64.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      require("netcoredbg-macOS-arm64").setup(dap)

      -- Helper function to show help documentation
      local function show_dbg_conf_help()
        local commands_text = [[
╔════════════════════════════════════════════════════════════════╗
║                  .dbg_conf.json Configuration                  ║
╚════════════════════════════════════════════════════════════════╝

Commands:
  :DapShowHelp       - Show this help
  :DapCreateTemplate - Create a template .dbg_conf.json
  
Keymaps:
  <leader>dh  - Show this help
  <leader>dc  - Start/continue debugging
  <leader>dn  - Step over
  <leader>di  - Step into
  <leader>do  - Step out
  <leader>db  - Toggle breakpoint
  <leader>dB  - Set conditional breakpoint
  <leader>dt  - Terminate debugging
  <leader>dr  - Open REPL

Navigation:
  Press 'C' for Commands, 'D' for Description
  Press 'q' or <Esc> to close
]]

        local description_text = [[
╔════════════════════════════════════════════════════════════════╗
║                  .dbg_conf.json Configuration                  ║
╚════════════════════════════════════════════════════════════════╝

Create a .dbg_conf.json file in your solution directory (next to .sln)

Example .dbg_conf.json:
{
  "profiles": [
    {
      "name": "MyApp - Debug",
      "type": "coreclr",
      "request": "launch",
      "preBuildCommand": "dotnet cake --target=Build",
      "program": "./src/MyApp/bin/Debug/net8.0/MyApp.dll",
      "args": ["--environment", "Development"],
      "cwd": "${workspaceFolder}",
      "stopAtEntry": false
    },
    {
      "name": "MyApp - Attach",
      "type": "coreclr",
      "request": "attach"
    }
  ]
}

Available fields:
  name              - Profile name shown in debugger menu
  type              - "coreclr" for .NET
  request           - "launch" or "attach"
  preBuildCommand   - Command to run before debugging (optional)
  program           - Path to .dll file (for launch)
  args              - Array of command-line arguments (optional)
  cwd               - Working directory (optional)
  stopAtEntry       - Break at entry point (optional)

Variables:
  ${workspaceFolder} - Expands to solution directory

Navigation:
  Press 'c' for Commands, 'd' for Description
  Press 'q' or <Esc> to close
]]

        local buf = vim.api.nvim_create_buf(false, true)
        local ns_id = vim.api.nvim_create_namespace("dap_help_tabs")
        local current_tab = 1

        local function apply_syntax_highlighting(lines, start_line)
          -- Highlight headers (lines starting with specific patterns after the box)
          for i, line in ipairs(lines) do
            local line_num = start_line + i - 1

            -- Box drawing characters
            if line:match("^[╔╚═║╗╝]+$") or line:match("^║.*║$") then
              vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, 0, {
                end_col = #line,
                hl_group = "FloatBorder",
              })
            end

            -- Section headers (Commands:, Keymaps:, etc.)
            if line:match("^[^:]+:$") then
              vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, 0, {
                end_col = #line,
                hl_group = "@keyword",
              })
            end

            -- Command names (:DapShowHelp, etc.)
            local cmd_start, cmd_end = line:find(":%w+")
            if cmd_start then
              vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, cmd_start - 1, {
                end_col = cmd_end,
                hl_group = "@function.builtin",
              })
            end

            -- Key bindings (<leader>dc, etc.)
            local key_start, key_end = line:find("<[%w>]+>")
            if key_start then
              vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, key_start - 1, {
                end_col = key_end,
                hl_group = "@string.special",
              })
            end

            -- JSON syntax in example
            if current_tab == 2 then
              -- JSON keys (strings followed by colon)
              for match_start in line:gmatch('"([^"]+)"%s*:') do
                local json_key_start = line:find('"' .. match_start .. '"')
                if json_key_start then
                  vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, json_key_start - 1, {
                    end_col = json_key_start + #match_start,
                    hl_group = "@property",
                  })
                end
              end

              -- JSON string values
              for match in line:gmatch(':%s*"([^"]*)"') do
                local val_start = line:find('"%s*' .. vim.pesc(match) .. '"', line:find(":"))
                if val_start then
                  vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, val_start - 1, {
                    end_col = val_start + #match + 1,
                    hl_group = "@string",
                  })
                end
              end

              -- JSON booleans
              for match in line:gmatch("%s(true|false)%s*[,}]") do
                local bool_start = line:find(match)
                if bool_start then
                  vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, bool_start - 1, {
                    end_col = bool_start + #match - 1,
                    hl_group = "@boolean",
                  })
                end
              end

              -- JSON brackets
              for char_idx = 1, #line do
                local char = line:sub(char_idx, char_idx)
                if char:match("[%[%]{}]") then
                  vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, char_idx - 1, {
                    end_col = char_idx,
                    hl_group = "@punctuation.bracket",
                  })
                end
              end
            end

            -- Field descriptions (lines with " - ")
            local dash_pos = line:find(" %- ")
            if dash_pos then
              -- Field name before dash
              local field_start = line:find("%S")
              if field_start and field_start < dash_pos then
                vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, field_start - 1, {
                  end_col = dash_pos - 1,
                  hl_group = "@variable.member",
                })
              end
              -- Description after dash
              vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, dash_pos + 2, {
                end_col = #line,
                hl_group = "@comment",
              })
            end

            -- Variables (${...})
            local var_start, var_end = line:find("%${[^}]+}")
            if var_start then
              vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, var_start - 1, {
                end_col = var_end,
                hl_group = "@variable.parameter",
              })
            end
          end
        end
        local function show_tab(tab_num)
          current_tab = tab_num
          local content = tab_num == 1 and commands_text or description_text

          -- Create tab indicator with visible spacing
          local tab_indicator = "  [C]ommands  │  [D]escription  "

          local lines = vim.split(content, "\n")
          table.insert(lines, 1, tab_indicator)
          table.insert(lines, 2, "")

          vim.bo[buf].modifiable = true
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          vim.bo[buf].modifiable = false

          -- Clear existing highlights
          vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)

          -- Highlight tabs with proper styling
          local tab_inactive_bg = "TabLine" -- Soft color for inactive tab
          local tab_active_bg = "PmenuSel" -- Hard color for active tab (popup menu selected)
          local tab_fill_bg = "TabLineFill" -- Background color for spacing

          -- Background for spacing/separator areas (same as main background)
          vim.api.nvim_buf_set_extmark(buf, ns_id, 0, 0, {
            end_col = #tab_indicator,
            hl_group = tab_fill_bg,
          })

          -- Highlight inactive and active tabs
          if tab_num == 1 then
            -- Commands tab is active
            vim.api.nvim_buf_set_extmark(buf, ns_id, 0, 1, {
              end_col = 13,
              hl_group = tab_active_bg,
            })
            -- Description tab is inactive
            vim.api.nvim_buf_set_extmark(buf, ns_id, 0, 18, {
              end_col = 33,
              hl_group = tab_inactive_bg,
            })
          else
            -- Commands tab is inactive
            vim.api.nvim_buf_set_extmark(buf, ns_id, 0, 1, {
              end_col = 13,
              hl_group = tab_inactive_bg,
            })
            -- Description tab is active
            vim.api.nvim_buf_set_extmark(buf, ns_id, 0, 18, {
              end_col = 33,
              hl_group = tab_active_bg,
            })
          end

          -- Apply syntax highlighting to content
          apply_syntax_highlighting(lines, 0)
        end

        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].bufhidden = "wipe"
        vim.bo[buf].filetype = "dap-help"

        local width = 80
        local height = 40
        local win = vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = width,
          height = height,
          col = (vim.o.columns - width) / 2,
          row = (vim.o.lines - height) / 2,
          style = "minimal",
          border = "rounded",
        })

        -- Set window options for floating window styling
        vim.wo[win].winhl = "Normal:NormalFloat,FloatBorder:FloatBorder"
        vim.wo[win].winblend = 0
        -- Show initial tab (Commands)
        show_tab(1)

        -- Set up keymaps
        vim.api.nvim_buf_set_keymap(buf, "n", "C", "", {
          silent = true,
          callback = function()
            show_tab(1)
          end,
        })
        vim.api.nvim_buf_set_keymap(buf, "n", "D", "", {
          silent = true,
          callback = function()
            show_tab(2)
          end,
        })
        vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":close<CR>", { silent = true })
      end

      -- Function to find .sln directory
      local function find_sln_dir()
        local current_dir = vim.fn.getcwd()
        local sln_file = vim.fn.glob(current_dir .. "/*.sln")

        if sln_file ~= "" then
          return current_dir
        end

        -- Search parent directories
        local path = vim.fn.expand("%:p:h")
        while path ~= "/" do
          sln_file = vim.fn.glob(path .. "/*.sln")
          if sln_file ~= "" then
            return path
          end
          path = vim.fn.fnamemodify(path, ":h")
        end

        return nil
      end

      -- Function to create template .dbg_conf.json
      local function create_dbg_conf_template(sln_dir)
        local template = {
          profiles = {
            {
              name = "Launch - Debug",
              type = "coreclr",
              request = "launch",
              preBuildCommand = "dotnet cake --target=Build",
              program = "./bin/Debug/net8.0/YourApp.dll",
              args = {},
              cwd = "${workspaceFolder}",
              stopAtEntry = false,
            },
            {
              name = "Attach to Process",
              type = "coreclr",
              request = "attach",
            },
          },
        }

        local config_path = sln_dir .. "/.dbg_conf.json"
        local file = io.open(config_path, "w")

        if file then
          file:write(vim.fn.json_encode(template))
          file:close()
          vim.notify("Created template .dbg_conf.json at: " .. config_path, vim.log.levels.INFO)
          vim.cmd("edit " .. config_path)
        else
          vim.notify("Failed to create .dbg_conf.json", vim.log.levels.ERROR)
        end
      end

      -- Function to load .dbg_conf.json (called lazily when debugging starts)
      local function load_debug_config()
        local sln_dir = find_sln_dir()
        if not sln_dir then
          vim.notify("No .sln file found in directory tree", vim.log.levels.WARN)
          return nil
        end

        local config_path = sln_dir .. "/.dbg_conf.json"
        local file = io.open(config_path, "r")

        if not file then
          vim.notify("No .dbg_conf.json found. Run :DapShowHelp for setup instructions", vim.log.levels.WARN)

          -- Ask if they want to see help
          vim.schedule(function()
            local choice = vim.fn.confirm(
              "No .dbg_conf.json found. Would you like to:",
              "&See instructions\n&Create template\n&Cancel",
              1
            )

            if choice == 1 then
              show_dbg_conf_help()
            elseif choice == 2 then
              create_dbg_conf_template(sln_dir)
            end
          end)

          return nil
        end

        local content = file:read("*a")
        file:close()

        local ok, config = pcall(vim.json.decode, content)
        if not ok then
          vim.notify("Error parsing .dbg_conf.json: " .. config, vim.log.levels.ERROR)
          vim.schedule(function()
            local choice = vim.fn.confirm("Invalid .dbg_conf.json format. See help?", "&Yes\n&No", 1)
            if choice == 1 then
              show_dbg_conf_help()
            end
          end)
          return nil
        end

        return config, sln_dir
      end

      -- Setup C# configurations with lazy loading
      local configs_loaded = false

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            -- Only load config when user actually tries to debug
            if not configs_loaded then
              local config, sln_dir = load_debug_config()

              if config and config.profiles then
                -- Dynamically rebuild configurations with loaded profiles
                dap.configurations.cs = {}

                for _, profile in ipairs(config.profiles) do
                  local dap_config = {
                    type = profile.type or "coreclr",
                    name = profile.name,
                    request = profile.request or "launch",
                  }

                  if profile.request == "launch" then
                    dap_config.program = function()
                      -- Run pre-build command if specified
                      if profile.preBuildCommand then
                        print("Running: " .. profile.preBuildCommand)
                        local result = vim.fn.system("cd " .. sln_dir .. " && " .. profile.preBuildCommand)
                        if vim.v.shell_error ~= 0 then
                          vim.notify("Build failed: " .. result, vim.log.levels.ERROR)
                          return nil
                        end
                        vim.notify("Build completed successfully", vim.log.levels.INFO)
                      end

                      -- Expand variables in program path
                      local program = profile.program:gsub("${workspaceFolder}", sln_dir)

                      -- Make path absolute if relative
                      if not program:match("^/") then
                        program = sln_dir .. "/" .. program
                      end

                      return program
                    end

                    if profile.args then
                      dap_config.args = profile.args
                    end

                    if profile.cwd then
                      dap_config.cwd = profile.cwd:gsub("${workspaceFolder}", sln_dir)
                    else
                      dap_config.cwd = sln_dir
                    end

                    if profile.stopAtEntry then
                      dap_config.stopAtEntry = profile.stopAtEntry
                    end
                  elseif profile.request == "attach" then
                    dap_config.processId = require("dap.utils").pick_process
                  end

                  table.insert(dap.configurations.cs, dap_config)
                end

                configs_loaded = true

                -- Restart the configuration selection with newly loaded profiles
                vim.schedule(function()
                  dap.continue()
                end)

                return nil -- Cancel this first attempt
              end
            end

            -- Fallback if no config found or already loaded
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
        },
      }

      -- Create user commands
      vim.api.nvim_create_user_command("DapShowHelp", show_dbg_conf_help, {})
      vim.api.nvim_create_user_command("DapCreateTemplate", function()
        local sln_dir = find_sln_dir()
        if sln_dir then
          create_dbg_conf_template(sln_dir)
        else
          vim.notify("No .sln file found in directory tree", vim.log.levels.WARN)
        end
      end, {})

      -- Global keymap for help
      vim.keymap.set("n", "<leader>dh", show_dbg_conf_help, { desc = "Show DAP help" })

      -- Function to set debug keymaps (only active during debug session)
      local function set_debug_keymaps()
        local opts = { buffer = true, silent = true }
        vim.keymap.set("n", "<leader>dc", dap.continue, opts)
        vim.keymap.set("n", "<leader>dn", dap.step_over, opts)
        vim.keymap.set("n", "<leader>di", dap.step_into, opts)
        vim.keymap.set("n", "<leader>do", dap.step_out, opts)
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
        vim.keymap.set("n", "<leader>dB", function()
          dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, opts)
        vim.keymap.set("n", "<leader>dt", dap.terminate, opts)
        vim.keymap.set("n", "<leader>dr", dap.repl.open, opts)
      end

      -- Function to clear debug keymaps
      local function clear_debug_keymaps()
        local opts = { buffer = true }
        pcall(vim.keymap.del, "n", "<leader>dc", opts)
        pcall(vim.keymap.del, "n", "<leader>dn", opts)
        pcall(vim.keymap.del, "n", "<leader>di", opts)
        pcall(vim.keymap.del, "n", "<leader>do", opts)
        pcall(vim.keymap.del, "n", "<leader>db", opts)
        pcall(vim.keymap.del, "n", "<leader>dB", opts)
        pcall(vim.keymap.del, "n", "<leader>dt", opts)
        pcall(vim.keymap.del, "n", "<leader>dr", opts)
      end

      -- Set keymaps when debugging starts
      dap.listeners.after.event_initialized["dap_keymaps"] = function()
        set_debug_keymaps()
      end

      -- Clear keymaps when debugging ends
      dap.listeners.before.event_terminated["dap_keymaps"] = function()
        clear_debug_keymaps()
      end

      dap.listeners.before.event_exited["dap_keymaps"] = function()
        clear_debug_keymaps()
      end
    end,
  },
}

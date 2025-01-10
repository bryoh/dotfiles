return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- DAP setup for debugging
      local dap = require('dap')

      -- Python DAP (debugpy)
      require('dap-python').setup('~/miniconda3/envs/idebugpy/bin/ipython', {
        include_configs = true,
      })
      dap.defaults.python = {
        env = { PYTHONBREAKPOINT = "ipdb.set_trace" },
      }

      -- Keymaps
      local get_args = function() return vim.fn.input('Args: ') end
      local keys = {
        { "<localleader>d", "", desc = "+debug", mode = {"n", "v"} },
        { "<localleader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<localleader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<F5>", function() require("dap").continue() end, desc = "Continue" },
        { "<localleader>dc", function() require("dap").continue() end, desc = "Continue" },
        { "<localleader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
        { "<localleader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<localleader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
        { "<localleader>di", function() require("dap").step_into() end, desc = "Step Into" },
        { "<F7>", function() require("dap").step_into() end, desc = "Step Into" },
        { "<localleader>dj", function() require("dap").down() end, desc = "Down" },
        { "<localleader>dk", function() require("dap").up() end, desc = "Up" },
        { "<localleader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<localleader>dO", function() require("dap").step_out() end, desc = "Step Out" },
        { "<localleader>do", function() require("dap").step_over() end, desc = "Step Over" },
        { "<F8>", function() require("dap").step_over() end, desc = "Step Over" },
        { "<localleader>dp", function() require("dap").pause() end, desc = "Pause" },
        { "<localleader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
        { "<localleader>ds", function() require("dap").session() end, desc = "Session" },
        { "<localleader>dt", function() require("dap").terminate() end, desc = "Terminate" },
        { "<localleader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      }
      for _, key in ipairs(keys) do
        if type(key.mode) == "table" then
          for _, m in ipairs(key.mode) do
            if type(key[2]) == "function" then
              vim.keymap.set(m, key[1], key[2], { noremap = true, silent = true, desc = key.desc })
            else
              vim.api.nvim_set_keymap(m, key[1], key[2] or "", { noremap = true, silent = true, desc = key.desc })
            end
          end
        else
          if type(key[2]) == "function" then
            vim.keymap.set(key.mode or 'n', key[1], key[2], { noremap = true, silent = true, desc = key.desc })
          else
            vim.api.nvim_set_keymap(key.mode or 'n', key[1], key[2] or "", { noremap = true, silent = true, desc = key.desc })
          end
        end
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-lua/plenary.nvim", "nvim-neotest/nvim-nio"},
    config = function()
      require("dapui").setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸"},
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
        },
        element_mappings = {},
        expand_lines = true,
        force_buffers = true,
        layouts = {
          {
             -- Left sidebar layout for Breakpoints, Stacks, and Watches
              elements = {
                { id = "scopes", size = 0.25 },  -- Displays variable scopes
                { id = "breakpoints", size = 0.25 },  -- Lists all breakpoints
                { id = "stacks", size = 0.25 },  -- Shows call stacks
                { id = "watches", size = 0.25 },  -- Watch expressions for variables
              },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.7 },
              { id = "console", size = 0.3},
            },
            size = 10,
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.8,
          max_width = 0.5,
          border = "rounded",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        controls = {
          enabled = true,
          element = "repl",
        },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        },
      })

      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"},
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "python", "cpp", "cppdbg", "lldb", "bash", "codelldb", "chrome", "coreclr", "delve", "firefox", "go", "java", "js", "kotlin", "node2", "php", "pwa-chrome", "pwa-msedge", "pwa-node", "pwa-firefox", "ruby", "rust", "swift", "typescript", "vscode-js-debug" },
        automatic_installation = true,
      })
      local dap = require('dap')
      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode-10',
        name = 'lldb'
      }
            -- cppdbg Adapter
      dap.adapters.cppdbg = {
          id = 'cppdbg',
          type = 'executable',
          command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7", -- Ensure this path is correct
      }
      dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
              command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
              args = { "--port", "${port}" },
          },
      }
      dap.configurations.cpp = {
          {
              name = "Launch with vscode lldb-vscode-10",
              type = "lldb",
              request = "launch",
              program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = '${workspaceFolder}',
              stopOnEntry = false,
              args = {},
          },
      } 
    end,
  },
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {},
    event = 'VeryLazy',
    keys = {
      { "<localleader>v", "", desc = "+eVironment", mode = {"n", "v"} },
      { '<localleader>vs', '<cmd>VenvSelect<cr>' },
      { '<localleader>vc', '<cmd>VenvSelectCached<cr>' },
    },
  }
}

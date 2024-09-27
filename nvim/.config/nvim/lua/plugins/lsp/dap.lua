return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- DAP setup for debugging
      local dap = require('dap')

      -- Python DAP (debugpy)
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

      -- Keymaps
      -- stylua: ignore
      local get_args = function() return vim.fn.input('Args: ') end
      local keys = {
        { "<leader>d", "", desc = "+debug", mode = {"n", "v"} },
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<F5>", function() require("dap").continue() end, desc = "Continue" },
        { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
        { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
        { "<F7>", function() require("dap").step_into() end, desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end, desc = "Down" },
        { "<leader>dk", function() require("dap").up() end, desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
        { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
        { "<F8>", function() require("dap").step_over() end, desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end, desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
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
            elements = {
              { id = "scopes", size = 0.50 }, -- 50% for scopes
              { id = "breakpoints", size = 0.20 }, -- 20% for breakpoints
              { id = "stacks", size = 0.10 }, -- 10% for stacks
              { id = "watches", size = 0.20 }, -- 20% for watches
            },
            size = 40, -- Set the height/width for this layout
            position = "left", -- Position: "left", "right", "top", "bottom"
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom", -- Position this layout at the bottom
          },
        },
        floating = {
          max_height = 0.9,
          max_width = 0.5,
          border = "rounded", -- Change the border type
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        controls = {
          enabled = true,
          element = "repl",
          --icons = {
          --  pause = "⏸",
          --  play = "▶",
          --  step_into = "⏎",
          --  step_over = "⏭",
          --  step_out = "⏮",
          --  step_back = "b",
          --  run_last = "▶▶",
          --  terminate = "⏹",
          --},
        },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
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
        ensure_installed = { "python", "cpp", "lldb", "bash", "codelldb", "chrome", "coreclr", "delve", "firefox", "go", "java", "js", "kotlin", "node2", "php", "pwa-chrome", "pwa-msedge", "pwa-node", "pwa-firefox", "ruby", "rust", "swift", "typescript", "vscode-js-debug" },
        automatic_installation = true,
      })
      local dap = require('dap')
      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/lib/llvm-10/bin/lldb-vscode', -- Adjust this path if necessary
        name = 'lldb'
      }
      -- C++ DAP (cpptools)
      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7", -- Mason-installed cpptools
      }

      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description =  'enable pretty printing',
              ignoreFailures = false
            },
          },
        },
      }
    end,
  },
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    },
    event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
    },
  }
}

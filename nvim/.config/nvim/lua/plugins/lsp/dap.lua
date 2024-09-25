return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- DAP setup for debugging
      local dap = require('dap')

      -- Python DAP (debugpy)
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

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
          cwd = '\\${workspaceFolder}',
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
      -- Keymaps
      -- stylua: ignore
      local get_args = function() return vim.fn.input('Args: ') end
      local keys = {
        { "<leader>d", "", desc = "+debug", mode = {"n", "v"} },
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
        { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end, desc = "Down" },
        { "<leader>dk", function() require("dap").up() end, desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
        { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
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
      require("dapui").setup()
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
    end,
  },
  --[[ {
    "ellisonleao/dotenv.nvim",
    config = function()
      require('dotenv').setup({
        enable_on_load = true,
        verbose = true,
      })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local dap_python = require('dap-python')
      --
      -- Function to get the Python interpreter path
      local function get_python_path()
        local venv_path = os.getenv('VIRTUAL_ENV')
        if venv_path then
          return venv_path .. '/bin/python'
        else
          return '/usr/bin/python' -- Default system Python
        end
      end
      dap_python.setup(get_python_path())
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = get_python_path,
      })
    end,
  }, ]]
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

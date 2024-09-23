return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require('dap')

      -- C++ configuration
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input('/usr/lib/llvm-10/bin/lldb-vscode', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }

      -- Keymaps
      vim.api.nvim_set_keymap('n', '<leader>c<F5>', '<cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>c<space>', '<cmd>lua require"dap".step_over()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ci', '<cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>co', '<cmd>lua require"dap".step_out()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>cb', '<cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>cq', '<cmd>lua require"dap".terminate()<CR>', { noremap = true, silent = true })
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
  {
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
  },
}

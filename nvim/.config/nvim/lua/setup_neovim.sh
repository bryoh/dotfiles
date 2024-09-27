#!/bin/bash

# Complete Neovim setup script
# This script will install system dependencies, set up Neovim, install plugins,
# symlink configuration files using stow, and create .lua plugin configuration files.

# Ensure the script is being run from the correct directory
DOTFILES_DIR=$(dirname "$0")
cd "$DOTFILES_DIR/.." || exit

# Function to display a message with a border
function print_message() {
  echo "==========================="
  echo "$1"
  echo "==========================="
}

# Ensure stow and make are installed (dependencies)
function install_dependencies() {
  print_message "Installing system dependencies..."
  sudo apt update
  sudo apt install -y stow make neovim git curl build-essential \
    python3 python3-pip python3-venv virtualenvwrapper \
    unzip ripgrep fd-find
}

# Symlink the dotfiles using stow
function symlink_dotfiles() {
  print_message "Symlinking Neovim configuration with stow..."
  stow -v -t "$HOME" nvim
}

# Remove symlinks (cleanup function if needed)
function remove_symlinks() {
  print_message "Removing Neovim symlinks..."
  stow -vD -t "$HOME" nvim
}

# Install and set up Neovim with LazyVim
function setup_neovim() {
  print_message "Installing Neovim and setting up LazyVim..."
  git clone https://github.com/LazyVim/starter ~/.config/nvim || {
    echo "LazyVim already installed, skipping..."
  }
  nvim --headless +qall
}

# Create individual .lua plugin files
PLUGIN_DIR="$HOME/.config/nvim/lua/plugins"
LSP_DIR="$PLUGIN_DIR/lsp"

function create_mason_lua() {
  print_message "Creating mason.lua plugin file..."
  mkdir -p "$LSP_DIR"
  cat <<EOF >"$LSP_DIR/mason.lua"
-- ~/.config/nvim/lua/plugins/lsp/mason.lua
return {
  -- Mason to manage LSP, DAP, and linters/formatters
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim", -- For LSP configuration
      "jay-babu/mason-nvim-dap.nvim",      -- For DAP (Debug Adapter Protocol) configuration
      "jose-elias-alvarez/null-ls.nvim",   -- For formatters and linters
      "jay-babu/mason-null-ls.nvim",       -- Integration of mason with null-ls
      "neovim/nvim-lspconfig",             -- LSP support
    },
    config = function()
      -- Mason setup
      require("mason").setup()

      -- Mason LSPConfig setup
      require("mason-lspconfig").setup({
        ensure_installed = { 
          "pyright",       -- Python
          "clangd",        -- C++
          "html",          -- HTML
          "cssls",         -- CSS
          "tailwindcss",   -- TailwindCSS
          "svelte",        -- Svelte
          "lua_ls",        -- Lua
          "graphql",       -- GraphQL
          "emmet_ls",      -- Emmet (HTML/CSS snippets)
          "prismals",      -- Prisma
          "tsserver",      -- TypeScript/JavaScript (Node.js)
          "jdtls",         -- Java
          "gopls",         -- Go
          "rust_analyzer", -- Rust
          "bashls",        -- Bash
          "dockerls",      -- Docker
          "jsonls",        -- JSON
          "yamlls",        -- YAML
          "vuels",         -- Vue.js
          "phpactor",      -- PHP
          "dartls",        -- Dart
        }, -- LSP servers for various languages
      })

      -- Mason Null-LS setup for formatters and linters
      require("mason-null-ls").setup({
        ensure_installed = {
          "prettier",   -- For JavaScript, CSS, HTML, JSON formatting
          "stylua",     -- For Lua formatting
          "eslint_d",   -- For JavaScript/TypeScript linting
          "shfmt",      -- For shell script formatting
          "black",      -- For Python formatting
          "isort",      -- For Python imports sorting
          "shellcheck", -- For shell script linting
          "gofmt",      -- For Go formatting
          "rustfmt",    -- For Rust formatting
          "java_formatter", -- For Java formatting
          "phpcsfixer", -- For PHP formatting
          "yamlfmt",    -- For YAML formatting
        },
        automatic_installation = true,
      })

      -- Null-LS setup for integrating external tools
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.formatting.yamlfmt,
          null_ls.builtins.formatting.phpcsfixer,
        },
      })

      -- Mason DAP setup for debuggers
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "debugpy",    -- Python debugger
          "cpptools",   -- C++ debugger
          "delve",      -- Go debugger
          "codelldb",   -- Rust debugger
          "js-debug-adapter", -- JavaScript/TypeScript debugger
          "java-debug-adapter", -- Java debugger
        },
      })

      -- Configure LSP for various languages
      local lspconfig = require("lspconfig")

      -- Python LSP
      lspconfig.pyright.setup({})

      -- C++ LSP
      lspconfig.clangd.setup({})

      -- TypeScript/JavaScript LSP
      lspconfig.tsserver.setup({})

      -- Java LSP
      lspconfig.jdtls.setup({})

      -- Go LSP
      lspconfig.gopls.setup({})

      -- Rust LSP
      lspconfig.rust_analyzer.setup({})

      -- HTML LSP
      lspconfig.html.setup({})

      -- CSS LSP
      lspconfig.cssls.setup({})

      -- Tailwind CSS LSP
      lspconfig.tailwindcss.setup({})

      -- Svelte LSP
      lspconfig.svelte.setup({})

      -- Lua LSP
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Recognize 'vim' as a global for Neovim
            },
          },
        },
      })

      -- GraphQL LSP
      lspconfig.graphql.setup({})

      -- Emmet LSP
      lspconfig.emmet_ls.setup({})

      -- Prisma LSP
      lspconfig.prismals.setup({})

      -- PHP LSP
      lspconfig.phpactor.setup({})

      -- Bash LSP
      lspconfig.bashls.setup({})

      -- Docker LSP
      lspconfig.dockerls.setup({})

      -- YAML LSP
      lspconfig.yamlls.setup({})

      -- JSON LSP
      lspconfig.jsonls.setup({})

      -- Vue.js LSP
      lspconfig.vuels.setup({})

      -- Dart LSP
      lspconfig.dartls.setup({})

      -- DAP setup for debugging
      local dap = require("dap")

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
          cwd = '\${workspaceFolder}',
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

      -- Key mappings for DAP (adjust to your preference)
      vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
      vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
      vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
      vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
      vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
      vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
      vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
      vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
      vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    end,
  },
}
EOF
}

function create_telescope_lua() {
  print_message "Creating telescope.lua plugin file..."
  mkdir -p "$PLUGIN_DIR"
  cat <<EOF >"$PLUGIN_DIR/telescope.lua"
-- ~/.config/nvim/lua/plugins/telescope.lua
local keymap = vim.keymap
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-dap.nvim",
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/" },
      },
      pickers = {
        find_files = { hidden = true },
      },
      extensions = {
        fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
        file_browser = { hijack_netrw = true },
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
      },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("ui-select")
    telescope.load_extension("dap")
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find under cursor" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
EOF
}

function create_cmp_lua() {
  print_message "Creating nvim-cmp.lua plugin file..."
  mkdir -p "$PLUGIN_DIR"
  cat <<EOF >"$PLUGIN_DIR/nvim-cmp.lua"
-- ~/.config/nvim/lua/plugins/nvim-cmp.lua
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind-nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require('luasnip.loaders.from_vscode').lazy_load()
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      },
      formatting = {
        format = require('lspkind').cmp_format({ with_text = true, maxwidth = 50 }),
      },
    })
  end,
}
EOF
}

function create_copilot_lua() {
  print_message "Creating copilot-cmp.lua plugin file..."
  mkdir -p "$PLUGIN_DIR"
  cat <<EOF >"$PLUGIN_DIR/copilot-cmp.lua"
-- ~/.config/nvim/lua/plugins/copilot-cmp.lua
return {
  "zbirenbaum/copilot.lua",
  dependencies = { "zbirenbaum/copilot-cmp" },
  config = function()
    require("copilot").setup({ suggestion = { enabled = true }, panel = { enabled = true  } })
    require("copilot_cmp").setup()
  end,
}
EOF
}

# Install Neovim plugins using Mason
function install_plugins() {
  print_message "Installing Neovim LSP servers, debuggers, and formatters using Mason..."
  nvim --headless -c 'MasonInstall pyright clangd html cssls tailwindcss svelte lua_ls graphql emmet_ls prismals tsserver jdtls gopls rust_analyzer bashls dockerls jsonls yamlls vuels phpactor dartls prettier stylua eslint_d shfmt black isort shellcheck gofmt rustfmt yamlfmt phpcsfixer debugpy cpptools delve codelldb js-debug-adapter java-debug-adapter' +qall
}

# Set up Telescope and its keymaps
function setup_telescope() {
  print_message "Setting up Telescope..."
  nvim --headless -c 'source ~/.config/nvim/lua/plugins/telescope.lua' +qall
}

# Set up nvim-cmp with LuaSnip and Copilot-cmp
function setup_cmp_and_copilot() {
  print_message "Setting up nvim-cmp with LuaSnip and Copilot..."
  nvim --headless -c 'source ~/.config/nvim/lua/plugins/nvim-cmp.lua' +qall
  nvim --headless -c 'source ~/.config/nvim/lua/plugins/copilot-cmp.lua' +qall
}

# Full installation process
function full_install() {
  install_dependencies
  symlink_dotfiles
  setup_neovim
  create_mason_lua
  create_telescope_lua
  create_cmp_lua
  create_copilot_lua
  install_plugins
  setup_telescope
  setup_cmp_and_copilot
  print_message "Neovim setup complete!"
}

# Help message to show available options
function show_help() {
  echo "Usage: ./setup_neovim.sh [OPTIONS]"
  echo ""
  echo "OPTIONS:"
  echo "  --install         Perform the full installation of Neovim"
  echo "  --symlink         Only symlink the dotfiles"
  echo "  --deps            Only install the system dependencies"
  echo "  --plugins         Install Neovim plugins"
  echo "  --telescope       Set up Telescope"
  echo "  --cmp-copilot     Set up nvim-cmp and Copilot"
  echo "  --mason-lua       Create mason.lua file"
  echo "  --telescope-lua   Create telescope.lua file"
  echo "  --cmp-lua         Create nvim-cmp.lua file"
  echo "  --copilot-lua     Create copilot-cmp.lua file"
  echo "  --remove-symlink  Remove symlinked dotfiles"
  echo "  --help            Show this help message"
}

# Parse command-line arguments
if [ "$1" == "--install" ]; then
  full_install
elif [ "$1" == "--symlink" ]; then
  symlink_dotfiles
elif [ "$1" == "--deps" ]; then
  install_dependencies
elif [ "$1" == "--plugins" ]; then
  install_plugins
elif [ "$1" == "--telescope" ]; then
  setup_telescope
elif [ "$1" == "--cmp-copilot" ]; then
  setup_cmp_and_copilot
elif [ "$1" == "--mason-lua" ]; then
  create_mason_lua
elif [ "$1" == "--telescope-lua" ]; then
  create_telescope_lua
elif [ "$1" == "--cmp-lua" ]; then
  create_cmp_lua
elif [ "$1" == "--copilot-lua" ]; then
  create_copilot_lua
elif [ "$1" == "--remove-symlink" ]; then
  remove_symlinks
else
  show_help
fi

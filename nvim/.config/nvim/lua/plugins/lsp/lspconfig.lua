return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim", -- Mason for managing LSP servers
    "williamboman/mason-lspconfig.nvim", -- Mason LSP config
    "hrsh7th/cmp-nvim-lsp", -- Autocompletion plugin
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    { "nvim-telescope/telescope.nvim", config = true }, -- Integrate with your Telescope setup
  },
  config = function()
    -- First set up mason.nvim before anything else
    require("mason").setup()

    -- Then set up mason-lspconfig
    require("mason-lspconfig").setup({
      ensure_installed = {
        "pyright", "clangd", "gopls", "jdtls", "rust_analyzer",
        "html", "cssls", "tailwindcss", "svelte", "lua_ls", "graphql",
        "emmet_ls", "prismals", "phpactor", "bashls", "dockerls",
        "yamlls", "jsonls", "vuels", "cmake",
      },
      automatic_installation = true,
    })

    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Import Telescope and actions
    local actions = require('telescope.actions')

    -- Key mappings for LSP-related actions, integrated with Telescope and additional keybindings
    local on_attach = function(client, bufnr)
      local opts = { noremap=true, silent=true, buffer=bufnr }

      -- LSP navigation with Telescope
      vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)  -- Go to definition
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)  -- Go to declaration
      vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)  -- Go to implementation
      vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)  -- Go to references

      -- Go to definition in vertical split
      vim.keymap.set('n', '<leader>vD', '<cmd>lua require("telescope.builtin").lsp_definitions{ layout_strategy = "vertical", layout_config = { width = 0.5 }, attach_mappings = function(_, map) map("i", "<CR>", actions.select_vertical); map("n", "<CR>", actions.select_vertical); return true end }<CR>', opts)

      -- Show hover documentation
      opts.desc = "Show documentation for what is under cursor"
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

      opts.desc = "See available code actions"
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- 
      -- Smart rename
      opts.desc = "Smart rename"
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Smart rename

      -- Go to previous diagnostic
      opts.desc = "Go to previous diagnostic"
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

      -- Go to next diagnostic
      opts.desc = "Go to next diagnostic"
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

      -- Restart LSP
      opts.desc = "Restart LSP"
      vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- Restart LSP

      -- Diagnostics with Telescope
      vim.keymap.set('n', '<leader>ds', '<cmd>Telescope diagnostics<CR>', opts)
    end

    -- Set up clangd for C++ development
    lspconfig.clangd.setup({
      cmd = {
        "clangd", 
        "--background-index", 
        "--clang-tidy", 
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--suggest-missing-includes",
        "--query-driver=/usr/bin/g++" -- Adjust to match your system
      },
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "c", "cpp", "objc", "objcpp" },  -- Ensure filetypes for C++ are set
    })

    -- Setup CMake for C++ projects
    lspconfig.cmake.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Setup other LSP servers
    local function setup_lsp(server_name, config)
      config = config or {}
      config.capabilities = capabilities
      config.on_attach = on_attach
      lspconfig[server_name].setup(config)
    end

    setup_lsp("pyright")
    setup_lsp("gopls")
    setup_lsp("jdtls")
    setup_lsp("rust_analyzer")
    setup_lsp("html")
    setup_lsp("cssls")
    setup_lsp("tailwindcss")
    setup_lsp("svelte")
    setup_lsp("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }, -- Recognize 'vim' as a global for Neovim
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
    setup_lsp("graphql")
    setup_lsp("emmet_ls", {
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" }
    })
    setup_lsp("prismals")
    setup_lsp("phpactor")
    setup_lsp("bashls")
    setup_lsp("dockerls")
    setup_lsp("yamlls")
    setup_lsp("jsonls")
    setup_lsp("vuels")
    setup_lsp("dartls")

    -- Diagnostic configurations
    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      update_in_insert = true,
      severity_sort = true,
    })
  end,
}

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim", -- Mason for managing LSP servers
    "mason-org/mason-lspconfig.nvim", -- Mason LSP config
    -- "hrsh7th/cmp-nvim-lsp", -- Autocompletion plugin
    { "antosha417/nvim-lsp-file-operations", config = true },
    -- { "folke/neodev.nvim", opts = {} },
    { "nvim-telescope/telescope.nvim", config = true }, -- Integrate with your Telescope setup
    { "saghen/blink.cmp" },
  },
  config = function()
    -- Set up mason-lspconfig
    require("mason-lspconfig").setup({
      ensure_installed = {
        "pyright",
        "clangd",
        "gopls",
        "jdtls",
        "rust_analyzer",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "phpactor",
        "bashls",
        "dockerls",
        "yamlls",
        "jsonls",
        "vuels",
        "cmake",
      },
      automatic_installation = true,
    })

    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Import Telescope and actions
    local actions = require("telescope.actions")

    -- Key mappings for LSP-related actions, integrated with Telescope and additional keybindings
    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- Enable inlay hints if the LSP supports it
      if client.server_capabilities.inlayHints and vim.lsp.buf.inlay_hint then
        vim.lsp.buf.inlay_hint(bufnr, true)
      end
      -- LSP navigation with Telescope
      vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- Go to definition
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- Go to declaration
      vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- Go to implementation
      vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- Go to references

      -- Show hover documentation
      opts.desc = "Show documentation for what is under cursor"
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "See available code actions"
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

      -- Smart rename
      opts.desc = "Smart rename"
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      -- Go to previous diagnostic
      opts.desc = "Go to previous diagnostic"
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

      -- Go to next diagnostic
      opts.desc = "Go to next diagnostic"
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

      -- Restart LSP
      opts.desc = "Restart LSP"
      vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

      -- Diagnostics with Telescope
      vim.keymap.set("n", "<leader>ds", "<cmd>Telescope diagnostics<CR>", opts)
    end

    -- Set up clangd for C++ development
    -- lspconfig.clangd.setup({
    --   cmd = {
    --     "clangd",
    --     "--background-index",
    --     "--clang-tidy",
    --     "--completion-style=detailed",
    --     "--header-insertion=iwyu",
    --     "--suggest-missing-includes",
    --     "--query-driver=/usr/bin/g++",
    --     "--inlay-hints=true", -- Enable inlay hints for clangd
    --   },
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   filetypes = { "c", "cpp", "objc", "objcpp" },
    -- })

    -- Set up rust_analyzer for Rust development with inlay hints
    lspconfig.rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
          checkOnSave = {
            command = "clippy",
          },
          inlayHints = {
            lifetimeElisionHints = {
              enable = true,
              useParameterNames = true,
            },
            bindingModeHints = { enable = true },
            closureReturnTypeHints = { enable = true },
          },
        },
      },
      on_attach = on_attach,
      capabilities = capabilities,
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
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
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
      virtual_text = true,
      signs = true,
      update_in_insert = true,
      severity_sort = true,
    })
  end,
}

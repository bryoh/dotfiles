return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
      "jose-elias-alvarez/null-ls.nvim",   -- For formatters and linters
      "jay-babu/mason-null-ls.nvim",       -- Integration of mason with null-ls
      "neovim/nvim-lspconfig",             -- LSP support
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
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
      },
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

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint",
        "eslint_d",
      },
    })
  end,
}

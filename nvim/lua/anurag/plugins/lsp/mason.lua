return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- Import mason
    local mason = require("mason")

    -- Import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- Import mason-tool-installer
    local mason_tool_installer = require("mason-tool-installer")

    -- Enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Configure mason-lspconfig to install LSP servers
    mason_lspconfig.setup({
      -- List of LSP servers for mason to install
      ensure_installed = {
        "clangd", -- C/C++ LSP
        "html", -- HTML LSP
        "cssls", -- CSS LSP
        "tailwindcss", -- Tailwind CSS LSP
        "svelte", -- Svelte LSP
        "lua_ls", -- Lua LSP
        "graphql", -- GraphQL LSP
        "emmet_ls", -- Emmet LSP
        "prismals", -- Prisma LSP
        "pyright", -- Python LSP
        "ts_ls", -- TypeScript LSP
      },
    })

    -- Configure mason-tool-installer to install non-LSP tools
    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- Prettier formatter
        "stylua", -- Lua formatter
        "pylint", -- Python linter
        "eslint_d", -- JavaScript/TypeScript linter
        "clang-format", -- C/C++ formatter
        "codelldb", -- C/C++/Rust debug adapter
        "jdtls", -- Java LSP
      },
    })
  end,
}

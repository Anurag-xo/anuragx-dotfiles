return {
  "neovim/nvim-lspconfig",
  event = { "FileType java" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    -- LSP keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- LSP keybindings
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Capabilities for cmp-nvim-lsp
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Set up server capabilities and diagnostics
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Configure servers via Mason
    mason_lspconfig.setup({
      handlers = {
        -- Default handler for all servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Server-specific configurations
        ["svelte"] = function()
          lspconfig.svelte.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                end,
              })
            end,
          })
        end,

        ["graphql"] = function()
          lspconfig.graphql.setup({
            capabilities = capabilities,
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
          })
        end,

        ["emmet_ls"] = function()
          lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          })
        end,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                completion = { callSnippet = "Replace" },
              },
            },
          })
        end,
        ["jdtls"] = function()
          local root_dir = lspconfig.util.root_pattern("pom.xml", "build.gradle", ".git")
          local workspace_dir = vim.fn.fnamemodify(root_dir, ":p:h:t")
          local path_to_jdtls = require("mason-registry").get_package("jdtls"):get_install_path()

          lspconfig["jdtls"].setup({
            capabilities = capabilities,
            filetypes = { "java" },
            root_dir = root_dir,
            cmd = {
              path_to_jdtls .. "/bin/jdt-language-server",
              "-data",
              vim.fn.stdpath("data") .. "/jdtls-workspace/" .. workspace_dir,
            },
            init_options = {
              bundles = {},
            },
            settings = {
              java = {
                format = {
                  enabled = true,
                  settings = {
                    url = vim.fn.stdpath("config") .. "/data/java-formatter.xml",
                    profile = "GoogleStyle",
                  },
                },
              },
            },
          })
        end,
      },
    })
  end,
}

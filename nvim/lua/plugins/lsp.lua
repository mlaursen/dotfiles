---@class LspCodeActionCommand
---@field command string
---@field title string
---@field arguments unknown[]

---@class LspCodeAction
---@field diagnostic lsp.Diagnostic[]
---@field command LspCodeActionCommand?
---@field kind lsp.CodeActionTriggerKind
---@field title string

---The isPreferred flag doesn't exist on the exhaustive-deps eslint rule for
---some reason, so here's a hacky way to allow the quickfix behavior for that
---rule
--
---@param action LspCodeAction
---@return boolean
local function is_exhaustive_deps(action)
  return action.kind == "quickfix"
      and action.command
      and action.command.command == "eslint.applySuggestion"
      and action.command.arguments[1].ruleId == "react-hooks/exhaustive-deps"
    or false
end

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    keys = {
      {
        "<space>e",
        ":Mason<cr>",
        desc = "Open mason dependencies",
      },
    },
  },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "nvim-telescope/telescope.nvim",
    },

    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        },
        tsserver = {
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
        jsonls = {
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
        -- stylelint_lsp = {
        --   filetypes = {
        --     "css",
        --     "scss",
        --   },
        -- },
      },
    },
    config = function(_, opts)
      require("mason").setup()
      local mason_lspconfig = require("mason-lspconfig")
      local lsp_config = require("lspconfig")
      local builtin = require("telescope.builtin")
      -- opts.servers.stylelint_lsp.root_dir = lsp_config.util.root_pattern("package.json", ".git")

      local lsp_capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      local function lsp_attach(client, bufnr)
        local key_opts = { buffer = bufnr, remap = false }
        local map = vim.keymap.set

        -- Keymaps
        map("n", "K", vim.lsp.buf.hover, key_opts)
        map("i", "<C-k>", vim.lsp.buf.signature_help, key_opts)
        map("n", "<c-j>", vim.diagnostic.goto_next, key_opts)
        map("n", "<c-k>", vim.diagnostic.goto_prev, key_opts)

        map("n", "gd", function()
          builtin.lsp_definitions()
        end, key_opts)
        map("n", "gD", vim.lsp.buf.declaration, key_opts)
        map("n", "gi", function()
          builtin.lsp_implementation()
        end, key_opts)
        map("n", "gr", function()
          builtin.lsp_references()
        end, key_opts)
        map("n", "fr", vim.lsp.buf.rename, key_opts)

        map({ "n", "v" }, "fi", vim.lsp.buf.code_action, key_opts)
        map("n", "fe", function()
          vim.lsp.buf.code_action({
            apply = true,
            filter = function(a)
              return a.isPreferred or is_exhaustive_deps(a)
            end,
          })
        end, { remap = false, silent = true })

        map("n", "<space>o", function()
          builtin.lsp_document_symbols()
        end, key_opts)
        map("n", "<space>s", function()
          builtin.lsp_dynamic_workspace_symbols()
        end, key_opts)

        if client.name == "tsserver" then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentHighlightProvider = false
          map("n", "fI", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = {
                only = { "source.organizeImports.ts" },
                diagnostics = {},
              },
            })
          end, key_opts)
        end
        if client.name == "eslint" then
          map("n", "fE", function()
            vim.cmd("EslintFixAll")
          end, key_opts)
        end
      end

      -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
      mason_lspconfig.setup({
        ensure_installed = {
          "cssls",
          "cssmodules_ls",
          "eslint",
          "html",
          "jsonls",
          "lua_ls",
          "graphql",
          -- "stylelint",
          -- "tailwindcss",
          -- "terraformls",
          "tsserver",
        },
      })
      mason_lspconfig.setup_handlers({
        function(server_name)
          lsp_config[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            settings = opts.servers[server_name] and opts.servers[server_name].settings or {},
          })
        end,
      })
    end,
  },
}
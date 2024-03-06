return {
  -- TODO: Uncomment once I can get this to better match coc.nvim
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        -- LSP Support
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
      },
      "williamboman/mason-lspconfig.nvim",
      "nvim-telescope/telescope.nvim",
    },

    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          settings = { Lua = { diagnostics = { globals = { "vim" } } } },
        },
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        stylelint_lsp = {
          filetypes = {
            "css",
            "scss",
          },
        },
      },
    },
    config = function(_, opts)
      require("mason").setup()
      local mason_lspconfig = require("mason-lspconfig")
      local lsp_config = require("lspconfig")
      local builtin = require("telescope.builtin")
      opts.servers.stylelint_lsp.root_dir = lsp_config.util.root_pattern("package.json", ".git")

      local lsp_capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      local lsp_attach = function(client, bufnr)
        local key_opts = { buffer = bufnr, remap = false }

        -- Keymaps
        vim.keymap.set("n", "K", vim.lsp.buf.hover, key_opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, key_opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, key_opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, key_opts)
        vim.keymap.set("n", "gr", function()
          builtin.lsp_references()
        end, key_opts)
        vim.keymap.set("n", "<c-j>", vim.diagnostic.goto_next, key_opts)
        vim.keymap.set("n", "<c-k>", vim.diagnostic.goto_prev, key_opts)
        vim.keymap.set({ "n", "v" }, "fi", vim.lsp.buf.code_action, key_opts)
        vim.keymap.set("n", "fr", vim.lsp.buf.rename, key_opts)
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, key_opts)
        vim.keymap.set("n", "fe", function()
          vim.lsp.buf.code_action({
            apply = true,
            filter = function(a)
              return a.isPreferred
            end,
          })
        end, { remap = false, silent = true })
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
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "SirVer/ultisnips",
      "quangnguyen30192/cmp-nvim-ultisnips",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "ultisnips" },
          { name = "buffer" },
          { name = "path" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<Enter>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.jump_forwards(fallback)
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.jump_backwards(fallback)
          end, { "i", "s" }),
        }),
      })
    end,
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "mason.nvim",
  --     "nvim-lua/plenary.nvim",
  --   },
  --   config = function()
  --     local null_ls = require("null-ls")
  --     local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  --
  --     null_ls.setup({
  --       root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
  --       sources = {
  --         -- null_ls.builtins.formatting.prettier,
  --         -- null_ls.builtins.diagnostics.eslint,
  --         -- null_ls.builtins.code_actions.eslint,
  --         -- null_ls.builtins.diagnostics.cspell,
  --         -- null_ls.builtins.code_actions.cspell,
  --         -- cspell.diagnostics,
  --         -- cspell.code_actions,
  --         null_ls.builtins.diagnostics.stylelint.with({
  --           filetypes = {
  --             "css",
  --             "scss",
  --           },
  --         }),
  --       },
  --       on_attach = function(client, bufnr)
  --         if client.supports_method("textDocument/formatting") then
  --           vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --           vim.api.nvim_create_autocmd("BufWritePre", {
  --             group = augroup,
  --             buffer = bufnr,
  --             callback = function()
  --               vim.lsp.buf.format({
  --                 bufnr = bufnr,
  --                 filter = function(formatClient)
  --                   return formatClient.name == "null-ls"
  --                 end,
  --               })
  --             end,
  --           })
  --         end
  --       end,
  --     })
  --   end,
  -- },
}

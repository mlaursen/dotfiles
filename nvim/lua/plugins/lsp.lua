return {
  -- TODO: Uncomment once I can get this to better match coc.nvim
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     {
  --       -- LSP Support
  --       "williamboman/mason.nvim",
  --       cmd = "Mason",
  --       build = ":MasonUpdate",
  --     },
  --     "williamboman/mason-lspconfig.nvim",
  --   },
  --   config = function(_, opts)
  --     require("mason").setup()
  --     local mason_lspconfig = require("mason-lspconfig")
  --     local lsp_config = require("lspconfig")
  --
  --     local lsp_capabilities = vim.tbl_deep_extend(
  --       "force",
  --       {},
  --       vim.lsp.protocol.make_client_capabilities(),
  --       require("cmp_nvim_lsp").default_capabilities()
  --     )
  --
  --     local lsp_attach = function(client, bufnr)
  --       local key_opts = { buffer = bufnr, remap = false }
  --
  --       -- Keymaps
  --       vim.keymap.set("n", "K", vim.lsp.buf.hover, key_opts)
  --       vim.keymap.set("n", "gd", vim.lsp.buf.definition, key_opts)
  --       vim.keymap.set("n", "gD", vim.lsp.buf.declaration, key_opts)
  --       vim.keymap.set("n", "gi", vim.lsp.buf.implementation, key_opts)
  --       vim.keymap.set("n", "gr", vim.lsp.buf.references, key_opts)
  --       vim.keymap.set("n", "<c-j>", vim.diagnostic.goto_next, key_opts)
  --       vim.keymap.set("n", "<c-k>", vim.diagnostic.goto_prev, key_opts)
  --       vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, key_opts)
  --       vim.keymap.set({ "n", "v" }, "fi", vim.lsp.buf.code_action, key_opts)
  --       vim.keymap.set("n", "fr", vim.lsp.buf.rename, key_opts)
  --       vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, key_opts)
  --
  --       if client.name == "tsserver" and client.server_capabilities then
  --         client.server_capabilities.semanticTokensProvider = nil
  --       end
  --     end
  --
  --     mason_lspconfig.setup({
  --       ensure_installed = {
  --         "cssls",
  --         "eslint",
  --         "jsonls",
  --         "lua_ls",
  --         "tsserver",
  --       },
  --     })
  --     mason_lspconfig.setup_handlers({
  --       function(server_name)
  --         lsp_config[server_name].setup({
  --           on_attach = lsp_attach,
  --           capabilities = lsp_capabilities,
  --         })
  --       end,
  --     })
  --   end,
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     {
  --       -- this is defined separately, the suggestions will only include
  --       -- ultisnips and ignore everything else
  --       "SirVer/ultisnips",
  --       dependencies = {
  --         "mlaursen/vim-react-snippets",
  --         "mlaursen/mlaursen-vim-snippets",
  --         "quangnguyen30192/cmp-nvim-ultisnips",
  --       },
  --       -- Note: These variables need to be defined before lazy loading, so put
  --       -- in options.lua eventually
  --       -- config = function()
  --       --   vim.g.UltiSnipsExpandTrigger = "<c-space>"
  --       --   vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "~/code/react-md/UltiSnips" }
  --       -- end,
  --     },
  --   },
  --   config = function()
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local cmp = require("cmp")
  --     local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
  --
  --     cmp.setup({
  --       snippet = {
  --         expand = function(args)
  --           vim.fn["UltiSnips#Anon"](args.body)
  --         end,
  --       },
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp" },
  --         { name = "ultisnips" },
  --         { name = "buffer" },
  --         -- { name = "path" },
  --       }),
  --       mapping = cmp.mapping.preset.insert({
  --         ["<Tab>"] = cmp.mapping(
  --           function(fallback)
  --             cmp_ultisnips_mappings.jump_forwards(fallback)
  --           end,
  --           { "i", "s" }
  --         ),
  --         ["<S-Tab>"] = cmp.mapping(
  --           function(fallback)
  --             cmp_ultisnips_mappings.jump_backwards(fallback)
  --           end,
  --           { "i", "s" }
  --         ),
  --       }),
  --     })
  --   end,
  -- },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "mason.nvim",
  --     "nvim-lua/plenary.nvim",
  --   },
  --   config = function()
  --     local Util = require("config.util")
  --     local null_ls = require("null-ls")
  --     -- local cspell = require("cspell")
  --     local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  --
  --     null_ls.setup({
  --       root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
  --       sources = {
  --         null_ls.builtins.formatting.prettier,
  --         -- null_ls.builtins.diagnostics.eslint,
  --         -- null_ls.builtins.code_actions.eslint,
  --         -- null_ls.builtins.diagnostics.cspell,
  --         -- null_ls.builtins.code_actions.cspell,
  --         -- cspell.diagnostics,
  --         -- cspell.code_actions,
  --       },
  --       on_attach = function(client, bufnr)
  --         if client.name == "null-ls" and client.supports_method("textDocument/formatting") then
  --           vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --           vim.api.nvim_create_autocmd("BufWritePre", {
  --             group = augroup,
  --             buffer = bufnr,
  --             callback = function()
  --               if Util.format_on_save then
  --                 vim.lsp.buf.format({ bufnr = bufnr })
  --               end
  --             end,
  --           })
  --         end
  --       end,
  --     })
  --   end,
  -- },
}
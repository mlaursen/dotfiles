---@class LspCodeActionCommand
---@field command string
---@field title string
---@field arguments unknown[]

---@class LspCodeAction
---@field diagnostic lsp.Diagnostic[]
---@field command LspCodeActionCommand?
---@field kind lsp.CodeActionTriggerKind
---@field title string
---@field isPreferred boolean

---@param action LspCodeAction
---@return boolean
local function is_exhaustive_deps(action)
  return action.kind == "quickfix"
      and action.command
      and action.command.command == "eslint.applySuggestion"
      and action.command.arguments[1].ruleId == "react-hooks/exhaustive-deps"
    or false
end

---The isPreferred flag doesn't exist on the exhaustive-deps eslint rule for
---some reason, so here's a hacky way to allow the quickfix behavior for that
---rule
---@param action LspCodeAction
---@return boolean
local function is_quickfix(action)
  return action.isPreferred or is_exhaustive_deps(action)
end

return {
  {
    "williamboman/mason.nvim",
    opts = {
      --  https://mason-registry.dev/registry/list
      ensure_installed = {
        -- "css-lsp",
        "cssmodules-language-server",
        "eslint-lsp",
        "graphql-language-service-cli",
        "html-lsp",
        "json-lsp",
        "js-debug-adapter",
        "lua-language-server",
        "prettier",
        "stylelint-lsp",
        "stylua",
        -- "sonarlint-language-server",
        "yaml-language-server",
        "some-sass-language-server",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      -- inlay hints just expand current type information that is inferred by other types. i.e.
      -- ```
      -- // Without Inlay Hints
      -- export const FocusCodeEditor = forwardRef<
      --   HTMLSpanElement,
      --   FocusCodeEditorProps
      -- >(function FocusCodeEditor(props, ref) {
      --
      -- // Inlay Hints
      -- export const FocusCodeEditor = forwardRef<
      --   HTMLSpanElement,
      --   FocusCodeEditorProps
      -- >(function FocusCodeEditor(props: FocusCodeEditorProps, ref: ForwardedRef<HTMLSpanElement>): Element {
      -- ```
      inlay_hints = {
        enabled = false,
      },
      codelens = {
        -- enabled = false,
      },
      -- add any global capabilities here
      capabilities = {},
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },

      diagnostics = {
        -- inline virtual diagnostics is way too noisy use Trouble or jumping
        -- to diagnostics to see the messages instead
        virtual_text = false,
      },

      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        -- tsserver = {
        --   settings = {
        --     javascript = {
        --       format = {
        --         enable = false,
        --       },
        --     },
        --     typescript = {
        --       format = {
        --         enable = false,
        --       },
        --       suggest = {
        --         autoImports = false,
        --         completeFunctionCalls = false,
        --         includeCompletionsForImportStatements = false,
        --       },
        --     },
        --   },
        -- },
        stylelint_lsp = {
          filetypes = { "css", "scss" },
          settings = {
            stylelintplus = {},
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
                  "/gitlab/*.yml",
                  "/gitlab/*.yaml",
                },
              },
            },
          },
        },

        -- use somesass_ls instead
        cssls = { enabled = false },
        somesass_ls = {
          root_dir = require("lspconfig.util").root_pattern("package.json", ".git"),
          settings = {
            somesass = {
              css = {
                codeAction = { enabled = true },
                colors = { enabled = true },
                completion = { enabled = true },
                definition = { enabled = true },
                diagnostics = { enabled = true },
                documentSymbols = { enabled = true },
                foldingRanges = { enabled = true },
                highlights = { enabled = true },
                hover = { enabled = true },
                links = { enabled = true },
                references = { enabled = true },
                rename = { enabled = true },
                selectionRanges = { enabled = true },
                signatureHelp = { enabled = true },
                workspaceSymbol = { enabled = true },
              },
              scss = {
                codeAction = { enabled = true },
                colors = { enabled = true },
                completion = { enabled = true },
                definition = { enabled = true },
                diagnostics = { enabled = true },
                documentSymbols = { enabled = true },
                foldingRanges = { enabled = true },
                highlights = { enabled = true },
                hover = { enabled = true },
                links = { enabled = true },
                references = { enabled = true },
                rename = { enabled = true },
                selectionRanges = { enabled = true },
                signatureHelp = { enabled = true },
                workspaceSymbol = { enabled = true },
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      -- setup = {
      --   -- example to setup with typescript.nvim
      --   -- tsserver = function(_, opts)
      --   --   require("typescript").setup({ server = opts })
      --   --   return true
      --   -- end,
      --   -- Specify * to use this function as a fallback for any server
      --   -- ["*"] = function(server, opts) end,
      -- },

      -- a copy of LazyVim's setup function with one change (marked inline) to fix
      -- auto-fixing on neovim 0.11.
      setup = {
        eslint = function()
          local function get_client(buf)
            return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
          end
          local formatter = LazyVim.lsp.formatter({
            name = "eslint: lsp",
            primary = false,
            priority = 200,
            filter = "eslint",
          })

          -- Use EslintFixAll on Neovim < 0.10.0
          -- Changed from upstream: check the version explicitly instead of
          -- looking for `vim.lsp._require`. Seems like that check stopped working
          -- with Neovim 0.11.
          if vim.fn.has("nvim-0.10") == 0 then
            formatter.name = "eslint: EslintFixAll"
            formatter.sources = function(buf)
              local client = get_client(buf)
              return client and { "eslint" } or {}
            end

            formatter.format = function(buf)
              local client = get_client(buf)
              if client then
                local pull_diagnostics =
                  vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id, false) })

                -- Older versions of the ESLint language server send push
                -- diagnostics rather than using pull. We support both for
                -- backwards compatibility.
                local push_diagnostics =
                  vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id, true) })

                if (#pull_diagnostics + #push_diagnostics) > 0 then
                  vim.cmd("EslintFixAll")
                end
              end
            end
          end

          -- register the formatter with LazyVim
          LazyVim.format.register(formatter)
        end,
      },
    },

    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      -- allow quick fixes with eslint for type imports, react hook dependency
      -- arrays, etc
      keys[#keys + 1] = {
        "<leader>cq",
        function()
          vim.lsp.buf.code_action({
            apply = true,
            filter = is_quickfix,
          })
        end,
        desc = "Code action quickfix",
      }
    end,
  },
}

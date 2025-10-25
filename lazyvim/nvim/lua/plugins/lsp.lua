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
    "mason-org/mason.nvim",
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
      -- https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
      ---@type lspconfig.options
      servers = {
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                autoImportSpecifierExcludeRegexes = {
                  -- no `import {} from "@mui/material"`, but `import {} from "@mui/x-*"`
                  "^@mui/(?!x-)[^/]+$",

                  -- normally don't want to import from these
                  "^@mui/system",
                  "^@emotion/",

                  -- i normally want vitest or jest instead
                  "^node:test$",

                  -- require `node:` for the core modules
                  "^(child_process|fs|path)$",

                  -- I don't need node internals for 99% of my projects, so remove from auto-imports and suggestions
                  "^(node:)?(assert|async_hooks|buffer|cluster|console|constants|crypto|dgram|diagnostics_channel|dns|domain|events|http|http2|https|inspector|module|net|os|perf_hooks|process|punycode|querystring|readline|repl|stream|string_decoder|sys|timers|tls|trace_events|tty|url|util|v8|vm|wasi|worker_threads|zlib)",

                  -- I don't need imports from these most of the time
                  "^(node_modules/|next/dist/|typescript)",
                },
              },
            },
          },
        },
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

        ["*"] = {
          keys = {
            {
              "<leader>cq",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  filter = is_quickfix,
                })
              end,
              desc = "Code action quickfix",
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
    },
  },
}

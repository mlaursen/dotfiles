local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      vim.g.coc_global_extensions = {
        "coc-css",
        "coc-pairs",
        "coc-stylelintplus",
        "coc-cssmodules",
        "coc-docker",
        "coc-eslint",
        "coc-json",
        "coc-html",
        "coc-prettier",
        "coc-tsserver",
        "coc-yaml",
        "coc-vimlsp",
        "coc-spell-checker",
        "coc-webview",
        "coc-markdown-preview-enhanced",
        "coc-snippets",
      }

      vim.cmd([[
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
      ]])
      autocmd("CursorHold", {
        pattern = "*",
        command = "silent call CocActionAsync('highlight')",
      })

      -- allow <c-o> to force suggestions to appear
      map("i", "<c-o>", [[coc#refresh()]], { silent = true, expr = true, noremap = true })

      local silent_opts = { silent = true }
      map("n", "<C-k>", "<Plug>(coc-diagnostic-prev)", silent_opts)
      map("n", "<C-j>", "<Plug>(coc-diagnostic-next)", silent_opts)
      map("n", "gd", "<Plug>(coc-definition)", silent_opts)
      map("n", "gK", "<Plug>(coc-type-definition)", silent_opts)
      map("n", "gi", "<Plug>(coc-implementation)", silent_opts)
      map("n", "gr", "<Plug>(coc-references)", silent_opts)
      map("n", "fr", "<Plug>(coc-rename)", silent_opts)
      map("n", "ff", "<Plug>(coc-format)", silent_opts)

      map("n", "K", function()
        if vim.fn["CocAction"]("hasProvider", "hover") then
          vim.fn["CocActionAsync"]("doHover")
        else
          vim.fn["feedkeys"]("K", "in")
        end
      end, { silent = true, noremap = true })

      -- fix it -- show preview window of fixable things and choose fix
      map("n", "fi", "<Plug>(coc-codeaction)", silent_opts)
      map("v", "fc", "<Plug>(coc-codeaction-selected)", silent_opts)
      map("n", "fs", "<Plug>(coc-codeaction-source)")

      -- fix eslint (also any other fixable things. Mostly used for React hook dependencies)
      map("n", "fe", "<Plug>(coc-fix-current)", silent_opts)

      -- fix eslint (everything in file)
      map("n", "fE", ":<C-u>CocCommand eslint.executeAutofix<cr>", silent_opts)

      -- fix imports
      map("n", "fI", ":<C-u>CocCommand editor.action.organizeImport<cr>", silent_opts)

      -- Remap keys for applying refactor code actions
      map("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", silent_opts)
      map({ "x", "n" }, "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", silent_opts)

      -- Use CTRL-S for selections ranges.
      -- Requires 'textDocument/selectionRange' support of language server.
      map({ "n", "x" }, "<C-s>", "<Plug>(coc-range-select)", silent_opts)

      -- Allow <C-f> and <C-b> to scroll the floating window
      local float_opts = { silent = true, nowait = true, expr = true, noremap = true }
      map({ "n", "v" }, "<C-f>", [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]], float_opts)
      map({ "n", "v" }, "<C-b>", [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]], float_opts)
      map("i", "<C-f>", [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"]], float_opts)
      map("i", "<C-b>", [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"]], float_opts)

      local coc_list_opts = { silent = true, nowait = true, noremap = true }
      map("n", "<space>a", ":<C-u>CocList diagnostics<cr>", coc_list_opts)
      map("n", "<space>e", ":<C-u>CocList extensions<cr>", coc_list_opts)
      map("n", "<space>c", ":<C-u>CocList commands<cr>", coc_list_opts)
      map("n", "<space>o", ":<C-u>CocList outline<cr>", coc_list_opts)
      map("n", "<space>s", ":<C-u>CocList -I symbols<cr>", coc_list_opts)
      map("n", "<space>j", ":<C-u>CocNext<cr>", coc_list_opts)
      map("n", "<space>k", ":<C-u>CocPrev<cr>", coc_list_opts)
      map("n", "<space>p", ":<C-u>CocListResume<cr>", coc_list_opts)

      -- Map functions and class text objects
      -- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
      map({ "x", "o" }, "if", "<Plug>(coc-funcobj-i)")
      map({ "x", "o" }, "af", "<Plug>(coc-funcobj-a)")
      map({ "x", "o" }, "ic", "<Plug>(coc-classobj-i)")
      map({ "x", "o" }, "ac", "<Plug>(coc-classobj-a)")
    end,
  },
  {
    "SirVer/ultisnips",
    dependencies = {
      "mlaursen/vim-react-snippets",
      "mlaursen/mlaursen-vim-snippets",
    },
    config = function()
      vim.g.UltiSnipsExpandTrigger = "<c-space>"
      vim.g.UltiSnipsSnippetDirectories = {
        "UltiSnips",
        "~/code/react-md/UltiSnips",
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  }
}
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local o = vim.opt

o.autowrite = false

-- this fixes watch mode for @swc/cli
o.writebackup = false

-- do not sync yanks with clipboard. I prefer using a register for that instead
-- so I have separate clipboards
o.clipboard = ""
-- I like having to press tab to complete something while typing instead of
-- having to select the item to complete it. also add noinsert to prevent
-- autocomplete behavior with CopilotChat
o.completeopt = "menu,preview,noinsert"

o.conceallevel = 0 -- I do not like concealing markup

-- line numbers mean nothing and relative line numbers are even worse
-- o.number = false
-- o.relativenumber = false

-- do not use the weird shifting width cursor and set it back to the vim
-- version
o.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:block-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"

-- keep the default split behavior
o.splitbelow = false
o.splitright = false

-- set the command-line completion mode back to default so I don't have to
-- press tab twice to autocomplete
o.wildmode = "full"

o.spell = true
o.spelllang = { "en_us" }
o.spelloptions = "camel"

-- enable the clipboard within WSL
if os.getenv("WSL_DISTRO_NAME") ~= nil then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = true,
  }
end

if vim.fn.executable("volta") then
  -- https://github.com/volta-cli/volta/issues/866#issuecomment-1470067688
  vim.g["node_host_prog"] = vim.call("system", 'volta which neovim-node-host | tr -d "\n"')
end

-- why the fuck would you add animations to vim?
vim.g.snacks_animate = false
-- vim.g.lazyvim_blink_main = true
--
vim.g.lazyvim_picker = "snacks"
-- vim.g.lazyvim_picker = "fzf"

-- vim.g.lazyvim_cmp = "auto"
vim.g.lazyvim_cmp = "blink.cmp"

-- i want to enforce a .prettierrc file
vim.g.lazyvim_prettier_needs_config = true

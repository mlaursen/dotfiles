-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local o = vim.opt

o.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:block-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
o.autowrite = false
o.splitbelow = false
o.splitright = false
o.conceallevel = 0
-- I like having to press tab to complete something while typing instead of
-- having to select the item to complete it
o.completeopt = "menu,preview"

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

-- define here since it messes up the timing if lazy loaded
vim.g.UltiSnipsExpandTrigger = "<c-space>"
vim.g.UltiSnipsSnippetDirectories = {
  "UltiSnips",
  os.getenv("HOME") .. "/code/react-md/UltiSnips",
}

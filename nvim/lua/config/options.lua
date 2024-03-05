local o = vim.opt;

o.wrap = false
o.ignorecase = true
o.smartcase = true
o.lazyredraw = true
o.signcolumn = "yes"
o.updatetime = 300
o.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:block-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
if vim.fn.has("termguicolors") then
  vim.opt.termguicolors = true
end

-- Shortmess
o.shortmess = o.shortmess
  + {
    -- A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
    -- I = true, -- don't give the intro message when starting Vim |:intro|.
    -- W = true, -- don't give "written" or "[w]" when writing a file
    c = true, -- don't give |ins-completion-menu| messages
    -- m = true, -- use "[+]" instead of "[Modified]"
  }

-- Remove builtin plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip = 1

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
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local spec = {
  -- add LazyVim and import its plugins
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    opts = { colorscheme = "nightfox" },
  },
}

if os.getenv("USE_OXC") == "true" then
  --- @type boolean?
  vim.g.mlaursen_use_oxc = true
  table.insert(spec, { import = "lazyvim.plugins.extras.lang.typescript.oxc" })
else
  table.insert(spec, { import = "lazyvim.plugins.extras.formatting.prettier" })
  table.insert(spec, { import = "lazyvim.plugins.extras.linting.eslint" })
end

if os.getenv("USE_TSC") == "true" then
  --- @type boolean?
  vim.g.mlaursen_use_tsc = true
  table.insert(spec, { import = "lazyvim.plugins.extras.lang.typescript.tsgo" })
end

if os.getenv("USE_LIT") == "true" then
  --- @type boolean?
  vim.g.mlaursen_use_lit = true
end

if os.getenv("USE_GRAPHQL") == "true" then
  --- @type boolean?
  vim.g.mlaursen_use_graphql = true
end

if os.getenv("USE_TERRAFORM") == "true" then
  --- @type boolean?
  vim.g.mlaursen_use_terraform = true
  table.insert(spec, { import = "lazyvim.plugins.extras.lang.terraform" })
end

-- import/override with your plugins
table.insert(spec, { import = "plugins" })

require("lazy").setup({
  spec = spec,
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = true,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "nightfox" } },
  -- install = { colorscheme = { "tokyonight", "habamax" } },
  -- I want to manually check for updates instead of seeing the popups each time I open nvim
  checker = { enabled = false },
  -- checker = {
  --   enabled = true, -- check for plugin updates periodically
  --   notify = false, -- notify on update
  -- }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

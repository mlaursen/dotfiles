return {
  "EdenEast/nightfox.nvim",
  config = function()
    vim.opt.background = "dark"
    require("nightfox").setup({
      options = {
        colorblind = {
          enable = true,
          -- simulate_only = true,
          severity = {
            protan = 0.8,
            deutan = 1,
            tritan = 0.3,
          },
        },
      },
    })

    vim.cmd.colorscheme("nightfox")
  end,
}

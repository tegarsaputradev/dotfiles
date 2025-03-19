-- ~/.config/nvim/lua/plugins/noice.lua
return {
  "folke/noice.nvim",
  event = "VeryLazy", -- Load after startup
  dependencies = {
    "MunifTanjim/nui.nvim", -- Required for UI components
  },
  config = function()
    require("noice").setup({
      cmdline = {
        enabled = true, -- Enable the Noice cmdline
        view = "cmdline_popup", -- Use a floating popup for the cmdline
        opts = {
          position = { row = "96%", col = "98%" }, -- Center it vertically at 30% from top
          size = { width = "40%", height = "auto" },
          border = { style = "rounded", padding = { 0, 1 } },
        },
      },
    })
  end,
}

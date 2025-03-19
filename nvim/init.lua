require("core.options")
require("core.keymaps")

-- Set up the Lazy plugin manager
local lazypath = vim.fn.expand("~/Documents/github/lazy.nvim")

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  error(
    "Local lazy.nvim directory not found at "
      .. lazypath
      .. ". Please ensure the path is correct and the directory exists."
  )
end

-- Add lazy.nvim to the runtime path
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("plugins.neotree"),
  require("plugins.colorscheme"),
  require("plugins.lualine"),
  require("plugins.treesitter"),
  require("plugins.telescope"),
  require("plugins.gitsigns"),
  require("plugins.indent-blankline"),
  require("plugins.comment"),
  require("plugins.misc"),
  require("plugins.formatter"),
  require("plugins.autotag"),
  require("plugins.cmp"),
  require("plugins.mason"),
  require("plugins.lsp"),
  require("plugins.noice"),
})

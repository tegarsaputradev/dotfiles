return {

  -- Your other plugins like vim-fugitive, vim-tmux-navigator, etc.
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    config = function()
      vim.keymap.set("n", "<leader><enter>", ":Gdiffsplit<CR>", { noremap = true, silent = true })
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- Load the plugin when entering insert mode
    config = function()
      -- custom here
    end,
  },
}

return {
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
}

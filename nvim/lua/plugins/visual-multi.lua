return {
  {
    "mg979/vim-visual-multi",
    branch = "master", -- Use the latest stable branch
    keys = {
      -- Map Ctrl+D to start multi-cursor mode (like VSCode)
      { "<C-d>", "<Plug>(VM-Find-Under)", mode = "n", desc = "Select next occurrence" },
      { "<C-d>", "<Plug>(VM-Visual-Add)", mode = "v", desc = "Add next occurrence from visual selection" },
    },
    config = function()
      -- Optional: Customize behavior
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>", -- Maps Ctrl+D to select next occurrence
        ["Find Subword Under"] = "<C-d>",
        ["Skip Region"] = "<C-x>", -- Skip an occurrence
        ["Remove Region"] = "<C-c>", -- Exit multi-cursor mode
      }
    end,
  },
}

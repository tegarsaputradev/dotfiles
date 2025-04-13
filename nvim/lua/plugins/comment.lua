return {
  "numToStr/Comment.nvim",
  opts = {
    padding = true, -- Add space between comment and line
    sticky = true, -- Keep cursor in place
    ignore = nil, -- No lines ignored
    toggler = {
      line = "<C-_>", -- Toggle line comment (normal mode)
      block = "<C-b>", -- Toggle block comment (normal mode, useful for JSX)
    },
    opleader = {
      line = "<C-_>", -- Operator-pending mode for line comment
      block = "<C-b>", -- Operator-pending mode for block comment
    },
    mappings = {
      basic = true, -- Enable basic mappings
      extra = false, -- Disable extra mappings if not needed
    },
    -- Add pre-hook to ensure JSX/TSX compatibility
    pre_hook = function(ctx)
      -- Use Treesitter to detect JSX/TSX context
      local U = require("Comment.utils")
      local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
      local location = require("ts_context_commentstring.utils").get_cursor_location()
      return require("ts_context_commentstring.internal").calculate_commentstring({
        key = type,
        location = location,
      })
    end,
  },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring", -- Required for JSX/TSX support
  },
}
-- return {
--   "numToStr/Comment.nvim",
--   opts = {
--     ---Add a space b/w comment and the line
--     padding = true,
--     ---Whether the cursor should stay at its position
--     sticky = true,
--     ---Lines to be ignored while (un)comment
--     ignore = nil,
--     ---LHS of toggle mappings in NORMAL mode
--     toggler = {
--       ---Line-comment toggle keymap
--       line = "<C-_>",
--       ---Block-comment toggle keymap
--     },
--     opleader = {
--       line = "<C-_>", -- Operator-pending mode for visual and normal (e.g., `<C-_>j` or visual selection)
--     },
--   },
-- }

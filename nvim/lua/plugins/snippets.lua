return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
      local ls = require("luasnip")

      -- Tentukan path ke folder yang Anda clone secara manual
      local snippet_path = "~/Documents/github/es7"

      -- Load snippet VSCode-style dari folder manual
      require("luasnip.loaders.from_vscode").load({
        paths = { snippet_path },
      })

      -- Keybinding untuk navigasi snippet
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true, desc = "Expand or jump snippet" })

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true, desc = "Jump back in snippet" })
    end,
  },
}

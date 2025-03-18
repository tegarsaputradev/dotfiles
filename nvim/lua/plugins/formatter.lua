return {

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- Format otomatis saat save
    cmd = { "ConformInfo" }, -- Command untuk info
    dependencies = {
      "williamboman/mason.nvim", -- Untuk mengelola instalasi formatter
    },
    config = function()
      -- Setup mason untuk memastikan formatter terinstal
      require("mason").setup()

      -- Konfigurasi conform.nvim
      require("conform").setup({
        formatters_by_ft = {
          -- Formatter untuk Lua
          lua = { "stylua" },
          -- Formatter untuk Next.js (JavaScript/TypeScript/JSX/TSX)
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
        },
        -- Format otomatis saat save
        format_on_save = {
          timeout_ms = 500, -- Batas waktu formatting
          lsp_fallback = true, -- Gunakan LSP jika formatter gagal
        },
        -- Pastikan formatter terinstal via Mason
        formatters = {
          stylua = {
            command = "stylua",
            args = { "--indent-type", "Spaces", "--indent-width", "2", "-" },
          },
          prettier = {
            command = "prettier",
            args = { "--stdin-filepath", "$FILENAME" },
          },
        },
      })

      -- Keybinding untuk format manual (opsional)
      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format buffer" })

      -- Instal formatter via Mason jika belum ada
      local mason_registry = require("mason-registry")
      local formatters = { "stylua", "prettier" }
      for _, formatter in ipairs(formatters) do
        if not mason_registry.is_installed(formatter) then
          vim.cmd("MasonInstall " .. formatter)
        end
      end
    end,
  },
}

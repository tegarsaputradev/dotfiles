return {
  {
    "windwp/nvim-ts-autotag",
    event = { "InsertEnter" }, -- Aktifkan saat masuk mode insert
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- Membutuhkan Treesitter
    },
    config = function()
      -- Pastikan Treesitter terinstal dan dikonfigurasi untuk HTML
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "html", "javascript", "typescript", "tsx" }, -- Bahasa yang relevan
        autotag = {
          enable = true, -- Aktifkan autotag
          enable_rename = true, -- Rename tag penutup saat mengedit tag pembuka
          enable_close = true, -- Tutup tag otomatis saat mengetik </
          enable_close_on_slash = true, -- Tutup tag saat mengetik />
          filetypes = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "jsx",
            "tsx",
            "xml",
          },
        },
      })

      -- Setup autotag
      require("nvim-ts-autotag").setup({
        opts = {
          -- Opsi tambahan jika diperlukan
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true,
        },
      })
    end,
  },
}

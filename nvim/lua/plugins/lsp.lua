local util = require("core.util")

return {
  -- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      {
        "dsznajder/vscode-es7-javascript-react-snippets",
        build = "yarn install --frozen-lockfile && yarn compile", -- Lazy.nvim menggunakan "build" bukan "run"
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<S-n>"] = cmp.mapping.select_prev_item(),
          ["<Enter>"] = cmp.mapping.confirm({ select = true }),
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
      })
    end,
  },

  -- LSP Config (vtsls dan tailwindcss)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "brenoprata10/nvim-highlight-colors",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "vtsls", "tailwindcss" },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      -- Definisikan capabilities di sini setelah cmp-nvim-lsp dimuat
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- vtsls setup
      lspconfig.vtsls.setup({
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                { name = "@tailwindcss/language-server", enable = false },
              },
            },
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              maxInlayHintLength = 30,
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
          javascript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
        on_attach = util.on_attach,
        capabilities = capabilities, -- Gunakan capabilities lokal
      })

      -- tailwindcss setup
      lspconfig.tailwindcss.setup({
        filetypes = {
          "html",
          "css",
          "scss",
          "sass",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "elixir",
          "eelixir",
          "heex",
        },
        init_options = {
          userLanguages = {
            elixir = "html-eex",
            eelixir = "html-eex",
            heex = "html-eex",
          },
        },
        settings = {
          tailwindCSS = {
            includeLanguages = {
              elixir = "html-eex",
              eelixir = "html-eex",
              heex = "html-eex",
            },
            experimental = {
              classRegex = {
                "tw\\(['\"]([^'\"]*)['\"]\\)",
                "className\\s*=\\s*['\"]([^'\"]*)['\"]",
              },
            },
          },
        },
        on_attach = util.on_attach,
        capabilities = capabilities, -- Gunakan capabilities lokal
      })

      -- nvim-highlight-colors
      require("nvim-highlight-colors").setup({
        render = "virtual",
        enable_tailwind = true,
        virtual_symbol = "■",
        virtual_symbol_prefix = " ", -- Thin space (U+2009)
        virtual_symbol_suffix = " ", -- Thin space (U+2009)
        enable = true,
      })
    end,
  },
}

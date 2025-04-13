return {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- Load the plugin when entering insert mode
  config = function()
    local autopairs = require("nvim-autopairs")

    -- Setup with default configuration
    autopairs.setup({
      check_ts = true, -- Enable treesitter integration
      disable_filetype = { "TelescopePrompt" }, -- Disable in specific filetypes
      ts_config = {
        lua = { "string" }, -- Don't add pairs in Lua string treesitter nodes
        javascript = { "template_string" }, -- Don't add pairs in JS template strings
      },
      fast_wrap = {
        map = "<M-e>", -- Alt+e for fast wrapping
        chars = { "{", "[", "(", '"', "'" }, -- Characters to wrap
        pattern = [=[[%'%"%)%>%]%)%}%,]]=], -- Pattern for fast wrap
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl", -- Keys for selection
      },
    })
    -- custom here
  end,
}

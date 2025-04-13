local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config = {
  default_cursor_style = "SteadyBar",
  automatically_reload_config = true,
  window_close_confirmation = "NeverPrompt",
  adjust_window_size_when_changing_font_size = false,
  window_decorations = "RESIZE",
  color_scheme = "Nord (Gogh)",
  check_for_updates = false,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = false,
  font_size = 11.5,
  font = wezterm.font("JetBrains Mono", { weight = "Medium" }),
  enable_tab_bar = false,
  enable_kitty_graphics = true,

  window_padding = {
    left = 2,
    right = 2,
    top = 8,
    bottom = 2,
  },

  background = {
    {
      source = {
        File = os.getenv("HOME") .. "/.config/img/peripoc.png",
      },
      hsb = {
        hue = 1.0,
        saturation = 1.02,
        brightness = 0.25,
      },
      -- attachment = { Parallax = 0.3 },
      -- width = "100%",
      -- height = "100%",
    },
    {
      source = {
        Color = "#282c35",
      },
      width = "100%",
      height = "100%",
      opacity = 0.9,
    },
  },

  initial_cols = 205,
  initial_rows = 45,
  -- from: https://akos.ma/blog/adopting-wezterm/
  hyperlink_rules = {
    -- Matches: a URL in parens: (URL)
    {
      regex = "\\((\\w+://\\S+)\\)",
      format = "$1",
      highlight = 1,
    },
    -- Matches: a URL in brackets: [URL]
    {
      regex = "\\[(\\w+://\\S+)\\]",
      format = "$1",
      highlight = 1,
    },
    -- Matches: a URL in curly braces: {URL}
    {
      regex = "\\{(\\w+://\\S+)\\}",
      format = "$1",
      highlight = 1,
    },
    -- Matches: a URL in angle brackets: <URL>
    {
      regex = "<(\\w+://\\S+)>",
      format = "$1",
      highlight = 1,
    },
    -- Then handle URLs not wrapped in brackets
    {
      -- Before
      --regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
      --format = '$0',
      -- After
      regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
      format = "$1",
      highlight = 1,
    },
    -- implicit mailto link
    {
      regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
      format = "mailto:$0",
    },
  },
  -- Add this to override the text color
  colors = {
    foreground = "#18c904", -- Custom text color (light gray from Nord palette)
    -- You can also override other colors if desired:
    -- background = "#2E3440", -- Example: override background
    -- cursor_fg = "#FFFFFF",  -- Cursor foreground
    -- cursor_bg = "#88C0D0",  -- Cursor background
  },
}

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
  return "" -- No title at all
end)

return config

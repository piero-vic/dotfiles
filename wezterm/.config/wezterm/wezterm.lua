local wezterm = require 'wezterm';

wezterm.on("update-right-status", function(window, pane)
  -- Each element holds the text for a cell in a "powerline" style << fade
  local cells = {};

  -- Pick up the hostname
  local hostname = wezterm.hostname();
  local dot = hostname:find("[.]")
  if dot then
    hostname = hostname:sub(1, dot-1)
  end
  table.insert(cells, hostname);

  -- I like my date/time in this style: "Wed Mar 3 08:14"
  local date = wezterm.strftime("%a %b %-d %H:%M");
  table.insert(cells, date);

  -- An entry for each battery (typically 0 or 1 battery)
  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
  end

  -- The powerline < symbol
  local LEFT_ARROW = utf8.char(0xe0b3);
  -- The filled in variant of the < symbol
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- Color palette for the backgrounds of each cell
  local colors = {
    "#52307c",
    "#663a82",
    "#7c5295",
    "#b491c8",
  };

  -- Foreground color for the text across the fade
  local text_fg = "#c0c0c0";

  -- The elements to be formatted
  local elements = {};
  -- How many cells have been formatted
  local num_cells = 0;

  -- Translate a cell into elements
  function push(text)
    local cell_no = num_cells + 1
    table.insert(elements, {Foreground={Color=colors[cell_no]}})
    table.insert(elements, {Text=SOLID_LEFT_ARROW})
    table.insert(elements, {Foreground={Color=text_fg}})
    table.insert(elements, {Background={Color=colors[cell_no]}})
    table.insert(elements, {Text=" "..text.." "})

    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell)
  end

  window:set_right_status(wezterm.format(elements));
end);

return {
  -- Avoid unexpected config breakage and unusable terminal
  automatically_reload_config = false,

  font = wezterm.font_with_fallback({"JetBrains Mono", "MesloLGS NF"}),
  font_size = 14,
  color_scheme = "cyberpunk",

  window_padding = {
    left = 0, right = 0,
    top = 0, bottom = 0,
  },

  window_background_opacity = 0.9,

  colors = {
    tab_bar = {
      -- The color of the strip that goes along the top of the window
      background = "#2b2042",

      -- The active tab is the one that has focus in the window
      active_tab = {
        bg_color = "#2b2042",
        fg_color = "#c0c0c0",
        intensity = "Bold",
        underline = "None",
        italic = false,
        strikethrough = false,
      },

      -- Inactive tabs are the tabs that do not have focus
      inactive_tab = {
        bg_color = "#1b1032",
        fg_color = "#808080",
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over inactive tabs
      inactive_tab_hover = {
        bg_color = "#3b3052",
        fg_color = "#909090",
        italic = false,
      },

      -- The new tab button that let you create new tabs
      new_tab = {
        bg_color = "#1b1032",
        fg_color = "#808080",
      },

      new_tab_hover = {
        bg_color = "#3b3052",
        fg_color = "#909090",
        italic = false,
      }
    }
  },

  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.8,
  },

  send_composed_key_when_left_alt_is_pressed=false,
  send_composed_key_when_right_alt_is_pressed=true,

  unzoom_on_switch_pane = true,

  keys = {
    -- Show Launcher
    {key="t", mods="SUPER|SHIFT", action="ShowLauncher"},
    -- Pane Split
    { key="d", mods="SUPER",
      action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    { key="d", mods="SUPER|SHIFT",
      action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    { key="w", mods="SUPER",
      action=wezterm.action{CloseCurrentPane={confirm=true}}},
     -- Pane Navigation
     { key = "LeftArrow", mods="SUPER|SHIFT",
       action=wezterm.action{ActivatePaneDirection="Left"}},
     { key = "RightArrow", mods="SUPER|SHIFT",
       action=wezterm.action{ActivatePaneDirection="Right"}},
     { key = "UpArrow", mods="SUPER|SHIFT",
       action=wezterm.action{ActivatePaneDirection="Up"}},
     { key = "DownArrow", mods="SUPER|SHIFT",
       action=wezterm.action{ActivatePaneDirection="Down"}},
    -- Pane Zoom
    { key = "z", mods="SUPER", action="TogglePaneZoomState"},
    -- Adjust Pane Size
    { key = "H", mods = "SUPER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
    { key = "J", mods = "SUPER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
    { key = "K", mods = "SUPER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
    { key = "L", mods = "SUPER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
    -- FullScreen
    { key="f", mods="SUPER|CTRL", action="ToggleFullScreen"},
  },

  launch_menu = {
    {
      args = {"top"},
    },
    {
      -- Optional label to show in the launcher. If omitted, a label
      -- is derived from the `args`
      label = "Bash",
      -- The argument array to spawn.  If omitted the default program
      -- will be used as described in the documentation above
      args = {"bash", "-l"},

      -- You can specify an alternative current working directory;
      -- if you don't specify one then a default based on the OSC 7
      -- escape sequence will be used (see the Shell Integration
      -- docs), falling back to the home directory.
      -- cwd = "/some/path"

      -- You can override environment variables just for this command
      -- by setting this here.  It has the same semantics as the main
      -- set_environment_variables configuration option described above
      -- set_environment_variables = { FOO = "bar" },
    },
  },
}
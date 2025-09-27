local wezterm = require "wezterm"

local is_linux = wezterm.target_triple:find("linux") ~= nil
local is_windows = wezterm.target_triple:find("windows") ~= nil

local config = wezterm.config_builder()

-- theme stuff
config.color_scheme = "tokyonight_night"
config.font = wezterm.font("JetBrains Mono")
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- sanity wezterm settings
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"
config.audible_bell = "Disabled"

-- default window size
config.initial_cols = 150
config.initial_rows = 40


if is_linux then
    -- hyprland :)
    wezterm.on('window-config-reloaded', function(window)
        if wezterm.gui.screens().active.name == 'eDP-1' then
            window:set_config_overrides({
                dpi = 384
            })
        end
    end)
    config.font_size = 16
    config.window_decorations = "NONE"
    config.enable_tab_bar = false
    config.window_background_opacity = 0.8
    config.window_padding = {
        left = "0.5cell",
        right = "0.5cell",
        top = "0.1cell",
        bottom = "0.1cell",
    }
elseif is_windows then
    -- no tiling window manager :(
    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
    config.window_padding = {
        left = "0.5cell",
        right = "0.5cell",
        top = "0.25cell",
        bottom = "0.25cell",
    }

    -- wsl stuff
    config.default_prog = { "wsl", "--cd", "~" }
    config.launch_menu = {
        {
            label = "WSL",
            args = { "wsl", "--cd", "~" },
        },
        {
            label = "PowerShell",
            args = { "powershell" },
        },
        {
            label = "Command Prompt",
            args = { "cmd" },
        },
    }
end -- ill add mac stuff if i ever become rich

return config

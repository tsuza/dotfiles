local color = require("config.colors")

hl.config({
    general = {
        gaps_in    = 1,
        gaps_out   = 0,
        border_size = 3,
        col = {
            active_border   = color.cute,
            inactive_border = color.mblue,
        },
        layout = "dwindle",
        snap = { enabled = true },
    },
 
    decoration = {
        rounding       = 4,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        blur = {
            enabled = false
        },
        shadow = { enabled = false },
    },
 
    -- Animations disabled to match original
    animations = { enabled = false },
 
    input = {
        follow_mouse          = 2,
        float_switch_override_focus = 2,
    },
 
    misc = {
        font_family             = "Fira Sans",
        splash_font_family      = "Fira Sans",
        disable_hyprland_logo   = true,
        col                     = { splash = color.lgreen },
        background_color        = color.dblue,
        enable_swallow          = true,
        swallow_regex           = "^(cachy-browser|firefox|nautilus|nemo|thunar|btrfs-assistant.)$",
        focus_on_activate       = true,
        vrr                     = 2,
    },
 
    render = {
        direct_scanout = true,
    },
 
    dwindle = {
        special_scale_factor = 0.8,
        preserve_split       = true,
    },
 
    master = {
        new_status           = "master",
        special_scale_factor = 0.8,
    },
 
    cursor = {
        hotspot_padding = 1,
    },
 
    binds = {
        allow_workspace_cycles         = true,
        workspace_back_and_forth       = true,
        workspace_center_on            = true,
        movefocus_cycles_fullscreen    = true,
        window_direction_monitor_fallback = true,
    },
})
 
-- Group styling
hl.config({
    group = {
        col = {
            border_active          = color.dgreen,
            border_inactive        = color.lgreen,
            border_locked_active   = color.mgreen,
            border_locked_inactive = color.dblue,
        },
        groupbar = {
            font_family          = "Fira Sans",
            text_color           = color.dblue,
            col = {
                active          = color.dgreen,
                inactive        = color.lgreen,
                locked_active   = color.mgreen,
                locked_inactive = color.dblue,
            },
        },
    },
})
 
-- Per-device: disable PS controller touchpad
hl.device({
    name    = "sony-computer-entertainment-wireless-controller-touchpad",
    enabled = false,
})


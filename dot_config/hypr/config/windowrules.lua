local color = require("config.colors")

-- Float necessary windows
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, float = true })
hl.window_rule({ match = { class = "^$", title = "^(Picture in picture)$" }, float = true })
hl.window_rule({ match = { class = "^$", title = "^(Save File)$" }, float = true })
hl.window_rule({ match = { class = "^$", title = "^(Open File)$" }, float = true })
hl.window_rule({ match = { class = "^(LibreWolf)$", title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk|xdg-desktop-portal-kde|xdg-desktop-portal-hyprland)(.*)$" }, float = true })
hl.window_rule({ match = { class = "^(polkit-gnome-authentication-agent-1|hyprpolkitagent|org.org.kde.polkit-kde-authentication-agent-1)(.*)$" }, float = true })
hl.window_rule({ match = { class = "^(CachyOSHello)$" }, float = true })
hl.window_rule({ match = { class = "^(zenity)$" }, float = true })
hl.window_rule({ match = { class = "^$", title = "^(Steam - Self Updater)$" }, float = true })
hl.window_rule({ match = { class = "^(steam)$" }, float = true })

-- Opacity
hl.window_rule({ match = { class = "^(thunar|nemo)$" }, opacity = "0.92" })
hl.window_rule({ match = { class = "^(discord|armcord|webcord)$" }, opacity = "0.96" })
hl.window_rule({ match = { title = "^(QQ|Telegram)$" }, opacity = "0.95" })
hl.window_rule({ match = { title = "^(NetEase Cloud Music Gtk4)$" }, opacity = "0.95" })

-- Picture-in-Picture float + size
hl.window_rule({
    match   = { title = "^(Picture-in-Picture)$" },
    float   = true,
    size    = { "960", "540" },
    move    = { "monitor_w*0.25", "0" },
})
hl.window_rule({
    match   = { title = "^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp)$" },
    float   = true,
    size    = { "960", "540" },
    move    = { "monitor_w*0.25", "0" },
})

-- danmufloat pin + rounding
hl.window_rule({ match = { title = "^(danmufloat)$" }, pin = true })
hl.window_rule({ match = { title = "^(danmufloat|termfloat)$" }, rounding = 5 })

-- Terminal animation
hl.window_rule({ match = { class = "^(kitty|Alacritty)$" }, animation = "slide right" })

-- Firefox: disable blur (for performance)
hl.window_rule({ match = { class = "^(org.mozilla.firefox)$" }, no_blur = true })

-- Floating windows: coloured border
hl.window_rule({
    name         = "float-border",
    match        = { float = true, workspace = "w[fv1-10]" },
    border_size  = 2,
    border_color = color.cute,
    rounding     = 8,
})

-- Tiling windows
hl.window_rule({
    name        = "tile-border",
    match       = { float = false, workspace = "f[1-10]" },
    border_size = 3,
    rounding    = 4,
})

-- No gaps/border for single-window workspaces (pairs with workspace rules above)
hl.window_rule({
    name        = "no-gaps-wtv1",
    match       = { float = false, workspace = "w[tv1]" },
    border_size = 0,
    rounding    = 0,
})
hl.window_rule({
    name        = "no-gaps-f1",
    match       = { float = false, workspace = "f[1]" },
    border_size = 0,
    rounding    = 0,
})

-- ── Per-app fixes ──────────────────────────────────────────────

-- flameshot: must cover full screen on monitor 1, pinned and opaque
hl.window_rule({
    name        = "flameshot",
    match       = { class = "(flameshot)" },
    move        = { "0", "0" },
    size        = { "1920", "1080" },
    pin         = true,
    border_size = 0,
    stay_focused = true,
    opaque      = true,
    float       = true,
    monitor     = 1,
})

-- Grayjay: force tile
hl.window_rule({
    match = { class = "^$", title = "(Grayjay)" },
    tile  = true,
})

-- Iced apps: float top-left (exclude discord)
hl.window_rule({
    match = { class = "^(?!discord).*", title = ".*(i|I)ced.*" },
    float = true,
    move  = { "20", "20" },
})

-- comet: float top-right
hl.window_rule({
    match = { title = "^comet$" },
    float = true,
    move  = { "monitor_w-window_w-20", "20" },
})

-- MANNager: float
hl.window_rule({
    match = { class = "^(org.tsuza.mannager)$" },
    float = true,
})



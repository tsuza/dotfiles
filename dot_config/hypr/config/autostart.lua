local programs = require("config.variables")

hl.on("hyprland.start", function()
    -- GPU Screen Recorder (replay buffer)
    hl.exec_cmd("systemctl disable --now --user gpu-screen-recorder && systemctl enable --now --user gpu-screen-recorder")
    -- Clipboard
    hl.exec_cmd("wl-paste --watch cliphist store")
    -- Wallpaper / bar / input / notifications / network
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("mako")
    hl.exec_cmd("nm-applet --indicator")
    -- Volume overlay bar (wob)
    hl.exec_cmd('bash -c \'mkfifo /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob && tail -f /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob | wob -c ~/.config/hypr/wob.ini & disown\'')
    -- Polkit / audio effects / idle
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("easyeffects --gapplication-service")
    hl.exec_cmd(programs.idleHandler)
    -- Slow-launch fix: propagate environment to systemd / dbus
    hl.exec_cmd("systemctl --user import-environment")
    hl.exec_cmd("hash dbus-update-activation-environment 2>/dev/null")
    hl.exec_cmd("dbus-update-activation-environment --systemd")
end)


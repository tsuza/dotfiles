local programs = require("config.variables")
local screenshot = require("config.scripts.screenshot")

mainMod = "SUPER"

-- Core apps
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(programs.appLauncher))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Y", hl.dsp.window.pin())
hl.bind(mainMod .. " + I", hl.dsp.layout("togglesplit"))  -- dwindle only
 
-- Clipboard manager
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(
    "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
))
 
-- Screenshots (flameshot)
hl.bind("Print", function()
    screenshot.copy()
end)
hl.bind("SHIFT + Print", function()
    screenshot.upload()
end)
 
-- GPU Screen Recorder
hl.bind("SHIFT + ALT + KP_Subtract", function()
    hl.dsp.exec_cmd("pkill -SIGRTMIN -f gpu-screen-recorder")
    hl.notification.create({
        text = "Recording toggled",
        color = color.mgreen,
        duration = 1500
    })
end)

hl.bind("ALT + KP_Subtract", function()
    hl.dsp.exec_cmd(programs.replay)
end)

hl.bind("ALT + KP_Add", function()
    hl.dsp.exec_cmd(programs.replayLast10)
    hl.notification.create({
        text = "Replay (last 10s) saved",
        color = color.mgreen,
        duration = 1500
    })
end)

hl.bind("ALT + KP_Multiply", function()
    hl.dsp.exec_cmd(programs.replayLast30)
    hl.notification.create({
        text = "Replay (last 30s) saved",
        color = color.mlgreen,
        duration = 1500
    })
end)
 
-- ── Volume ─────────────────────────────────────────────────────
-- Raise volume (cap at 100%)
hl.bind("XF86AudioRaiseVolume", function()
    hl.dispatch(hl.dsp.exec_cmd(
        "pactl set-sink-volume @DEFAULT_SINK@ +5% && " ..
        "pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+(?=%)' | " ..
        "awk '{if($1>100) system(\"pactl set-sink-volume @DEFAULT_SINK@ 100%\")}'"
    ))
end, { repeating = true })
 
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(
    "pactl set-sink-volume @DEFAULT_SINK@ -5%"
), { repeating = true })
 
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(
    "amixer sset Master toggle | sed -En " ..
    "'/\\[on\\]/ s/.*\\[([0-9]+)%\\].*/\\1/ p; /\\[off\\]/ s/.*/0/p' | head -1 " ..
    "> /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob"
))
 
-- ── Playback ───────────────────────────────────────────────────
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),    { locked = true })
 
-- ── Brightness ─────────────────────────────────────────────────
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true })
 
-- ── Window focus (Vim/Helix keys) ──────────────────────────────
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
 
-- ── Move windows ───────────────────────────────────────────────
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.move({ direction = "down" }))
 
-- Mouse move / resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
 
-- ── Resize submap ──────────────────────────────────────────────
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
 
hl.define_submap("resize", function()
    local opts = { repeating = true }
    hl.bind("right", hl.dsp.window.resize({ x =  15, y =   0, relative = true }), opts)
    hl.bind("left",  hl.dsp.window.resize({ x = -15, y =   0, relative = true }), opts)
    hl.bind("up",    hl.dsp.window.resize({ x =   0, y = -15, relative = true }), opts)
    hl.bind("down",  hl.dsp.window.resize({ x =   0, y =  15, relative = true }), opts)
    hl.bind("l",     hl.dsp.window.resize({ x =  15, y =   0, relative = true }), opts)
    hl.bind("h",     hl.dsp.window.resize({ x = -15, y =   0, relative = true }), opts)
    hl.bind("k",     hl.dsp.window.resize({ x =   0, y = -15, relative = true }), opts)
    hl.bind("j",     hl.dsp.window.resize({ x =   0, y =  15, relative = true }), opts)
    hl.bind("escape", hl.dsp.submap("reset"))
end)
 
-- Quick resize (no submap, with mainMod+CTRL+SHIFT to avoid text-editor conflicts)
local function quickResize(x, y)
    return hl.dsp.window.resize({ x = x, y = y, relative = true })
end
hl.bind(mainMod .. " + CTRL + SHIFT + right", quickResize( 15,   0))
hl.bind(mainMod .. " + CTRL + SHIFT + left",  quickResize(-15,   0))
hl.bind(mainMod .. " + CTRL + SHIFT + up",    quickResize(  0, -15))
hl.bind(mainMod .. " + CTRL + SHIFT + down",  quickResize(  0,  15))
hl.bind(mainMod .. " + CTRL + SHIFT + l",     quickResize( 15,   0))
hl.bind(mainMod .. " + CTRL + SHIFT + h",     quickResize(-15,   0))
hl.bind(mainMod .. " + CTRL + SHIFT + k",     quickResize(  0, -15))
hl.bind(mainMod .. " + CTRL + SHIFT + j",     quickResize(  0,  15))
 
-- ── Grouping ───────────────────────────────────────────────────
hl.bind(mainMod .. " + ALT + Tab", hl.dsp.group.toggle())
hl.bind(mainMod .. " + Tab",       hl.dsp.group.next({ direction = "forward" }))
 
-- ── Gaps toggles (Lua makes this elegant) ──────────────────────
hl.bind(mainMod .. " + SHIFT + G", function()
    hl.config({ general = { gaps_out = 5, gaps_in = 3 } })
end)
hl.bind(mainMod .. " + G", function()
    hl.config({ general = { gaps_out = 0, gaps_in = 0 } })
end)
 
-- ── Workspace switching (1–10) ─────────────────────────────────
for i = 1, 10 do
    local key = i % 10  -- 10 maps to "0"
    -- Switch
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    -- Move window + switch
    hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i }))
    -- Move window silently (stay on current workspace)
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
end
 
-- Relative workspace navigation
hl.bind(mainMod .. " + PERIOD", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + COMMA",  hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + slash", hl.dsp.focus({ workspace = "previous" }))
 
-- ── Special workspaces (scratchpads) ───────────────────────────
hl.bind(mainMod .. " + minus", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + equal", hl.dsp.workspace.toggle_special("special"))
hl.bind(mainMod .. " + F1",    hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mainMod .. " + ALT + SHIFT + F1",
    hl.dsp.window.move({ workspace = "special:scratchpad", silent = true }))

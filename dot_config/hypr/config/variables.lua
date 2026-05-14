-- config/programs.lua

local programs = {
    terminal    = "alacritty",
    fileManager = "nautilus --new-window",
    appLauncher = "fuzzel",

    idleHandler =
    "swayidle -w timeout 300 'swaylock -f -c 000000' before-sleep 'swaylock -f -c 000000'",

    record =
    "~/.config/hypr/scripts/start-stop-recording.sh",

    replay =
    "killall -SIGUSR1 gpu-screen-recorder && sleep 0.5 && notify-send -t 1500 -u low -- 'GPU Screen Recorder' 'Replay saved'",

    replayLast10 =
    "pkill -SIGRTMIN+1 -f gpu-screen-recorder && sleep 0.5 && notify-send -t 1500 -u low -- 'GPU Screen Recorder' 'Replay saved'",

    replayLast30 =
    "pkill -SIGRTMIN+2 -f gpu-screen-recorder && sleep 0.5 && notify-send -t 1500 -u low -- 'GPU Screen Recorder' 'Replay saved'",
}

return programs

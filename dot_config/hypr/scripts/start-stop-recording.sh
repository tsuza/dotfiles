#!/bin/sh

# Simple script to start recording if it's not recording and stop recording
# if it's already recording. This script can be bound to a single hotkey
# to start/stop recording with a single hotkey.

pkill -SIGRTMIN -f gpu-screen-recorder
# notify-send -t 1500 -u low -- "GPU Screen Recorder" "Recording saved"

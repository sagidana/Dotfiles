#!/usr/bin/env bash

PROMPT="$*"

docker run --rm -it\
  -e DISPLAY=$DISPLAY \
  -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
  -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
  -v /dev/shm:/dev/shm \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /mnt/wslg:/mnt/wslg \
  -v "$PWD/repo":/repo \
  -v "$PWD/home":/home/node \
  -w /repo \
  claude-sandbox

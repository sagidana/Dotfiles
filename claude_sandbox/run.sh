#!/usr/bin/env bash

# docker run --rm -it\
  # -e DISPLAY=$DISPLAY \
  # -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
  # -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
  # -v /dev/shm:/dev/shm \
  # -v /tmp/.X11-unix:/tmp/.X11-unix \
  # -v "$PWD/repo":/repo \
  # -v "$PWD/home":/home/node \
  # -w /repo \
  # claude-sandbox

REPO="$1"

docker run --rm -it \
  --network space-inet-net \
  --dns 192.168.1.1 \
  -e DISPLAY=$DISPLAY \
  -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
  -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
  -v /dev/shm:/dev/shm \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $REPO:/repo \
  -v "$PWD/home":/home/node \
  -w /repo \
  claude-sandbox

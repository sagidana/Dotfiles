#!/bin/bash
docker build . -t run
docker run --rm -it \
    -v ~/.persistent_history:/root/.persistent_history \
    -v ~/.commands:/root/.commands \
    -v ~/projects:/root/projects \
    -v ~/notes:/root/notes \
    run

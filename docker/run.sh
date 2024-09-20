#!/bin/bash
docker build . -t run
docker run --rm -it \
    --network none \
    -v ~/projects:/root/projects \
    run

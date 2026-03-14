docker run --rm -it \
  -u $(id -u):$(id -u) \
  -v ~/github:/projects \
  -v ~/claude_docker/home:/home/node/ \
  claude-cli-sandbox


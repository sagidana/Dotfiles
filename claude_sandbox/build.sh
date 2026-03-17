docker build --build-arg CACHE_BUST=$(date +%s) -t claude-sandbox .

docker container prune -f
docker image prune -f


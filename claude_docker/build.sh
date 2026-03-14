# sudo usermod -aG docker $USER

docker build \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -u) \
    -t claude-cli-sandbox .


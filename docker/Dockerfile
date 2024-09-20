FROM ubuntu:latest
USER root
WORKDIR /root

RUN apt update

RUN apt install -y build-essential curl ripgrep git jq vim

# pyenv
RUN apt install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

ENV HOME="/root"
RUN git clone --depth=1 https://github.com/pyenv/pyenv.git ~/.pyenv

ENV HOME=/root
ENV PYENV_ROOT=$HOME/.pyenv
ENV PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN pyenv install 3.12
RUN pyenv global 3.12
RUN pyenv rehash

# generic python packages
RUN pip install requests frida-tools scapy tree-sitter

# rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"


# jless
RUN apt install -y libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev
RUN cargo install jless

# neovim
RUN apt install -y ninja-build gettext cmake unzip curl build-essential
RUN git clone --depth=1 https://github.com/neovim/neovim ~/neovim
RUN (cd ~/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && make install)

# tmux
RUN apt-get update && apt-get install -y git automake build-essential pkg-config libevent-dev libncurses5-dev bison
RUN git clone https://github.com/tmux/tmux.git ~/tmux
# RUN (cd ~/tmux && git checkout 3.4)
RUN (cd ~/tmux && sh autogen.sh && ./configure && make && make install)
# tmux bug that breaks ansi escaping
ENV TERM=screen-256color

# fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install --all

# bat
RUN apt install -y bat
RUN mkdir -p ~/.local/bin
RUN ln -s /usr/bin/batcat ~/.local/bin/bat
ENV PATH="/root/.local/bin:${PATH}"

# setup bashrc
COPY ./home/.bashrc /root/bashrc
RUN cat ~/bashrc >> ~/.bashrc && rm ~/bashrc

# setup .tmux.conf
COPY ./home/.tmux.conf /root/.tmux.conf
# setup neovim config
COPY ./home/.config/nvim/init.vim /root/.config/nvim/init.vim

CMD ["tmux"]

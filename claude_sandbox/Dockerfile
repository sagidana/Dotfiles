FROM node:20-bookworm

# Install system dependencies needed by Playwright/Chromium
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    neovim \
    iputils-ping \
    net-tools \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnss3 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    libxkbcommon0 \
    libxshmfence1 \
    libu2f-udev \
    libvulkan1 \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip --break-system-package

# network tools
RUN apt update && apt install -y iputils-ping net-tools

# Install Claude Code
ARG CACHE_BUST=1
RUN npm install -g npm@latest
RUN npm install -g @anthropic-ai/claude-code

# Install Playwright MCP server
RUN npm install -g @executeautomation/playwright-mcp-server

# Install Playwright browsers (Chrome)
RUN npx playwright install chrome


# Create working directories
WORKDIR /repo

# change use to non-root user so --dangerously-skip-permissions will be
# possible AND the filesystem permissions will be match the hostmachine local
# user uid and gid
USER node

# Default command

CMD ["/bin/bash"]

# ENTRYPOINT ["claude"]
# CMD ["--dangerously-skip-permissions"]

# Use a modern Node.js base image
FROM node:20-slim

ARG USER_ID
ARG GROUP_ID

RUN echo "Debug: User ID is ${USER_ID}"
RUN echo "Debug: Group ID is ${GROUP_ID}"

# Create a group and user that match the HOST IDs exactly
# Check if GID or UID already exists; if not, create them.
RUN if ! getent group ${GROUP_ID} > /dev/null; then \
        groupadd -g ${GROUP_ID} user; \
    fi && \
    if ! getent passwd ${USER_ID} > /dev/null; then \
        useradd -l -u ${USER_ID} -g ${GROUP_ID} -m user; \
    fi

# Install system dependencies (Git is required for Claude Code)
RUN apt-get update && apt-get install -y \
    neovim \
    git \
    curl \
    python3 \
    make \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code CLI globally
# Note: Some older guides recommend npm, but the native installer is preferred.
# For Docker, global npm install remains a common pattern.
RUN npm install -g @anthropic-ai/claude-code

USER ${USER_ID}

# Set the working directory where your projects will be mounted
WORKDIR /projects

# Default command to keep the container open for interactive use
CMD ["/bin/bash"]

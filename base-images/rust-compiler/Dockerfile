FROM rust:1.92-trixie

# =============================================================================
# System Dependencies
# =============================================================================

# Enable 32-bit architecture for compatibility
RUN dpkg --add-architecture i386

# Install cross-compilation toolchains and build dependencies
RUN apt-get update && apt-get install -y \
    # Native compilers
    gcc \
    g++ \
    # x86_64 Linux cross-compiler
    gcc-x86-64-linux-gnu \
    g++-x86-64-linux-gnu \
    # ARM64 Linux cross-compiler
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    # Windows cross-compiler
    gcc-mingw-w64-x86-64 \
    # Cross-compilation libraries
    libc6-dev-arm64-cross \
    libc6-dev-amd64-cross \
    # 32-bit support libraries
    libc6:i386 \
    libstdc++6:i386 \
    # MUSL toolchain
    musl-tools \
    musl-dev \
    # LLVM/Clang toolchain
    clang \
    lld \
    llvm \
    # Utilities
    wget \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# =============================================================================
# MUSL Cross-Compiler (ARM64)
# =============================================================================

# Download and install aarch64-linux-musl cross-compiler
RUN wget -q https://musl.cc/aarch64-linux-musl-cross.tgz -O /tmp/musl-cross.tgz \
    && tar -xzf /tmp/musl-cross.tgz -C /opt \
    && rm /tmp/musl-cross.tgz

ENV PATH="/opt/aarch64-linux-musl-cross/bin:${PATH}"

# Create clang wrapper for aarch64-linux-musl cross-compilation
RUN cat > /usr/local/bin/aarch64-musl-clang <<'EOF'
#!/bin/bash
exec clang \
  --target=aarch64-unknown-linux-musl \
  --sysroot=/opt/aarch64-linux-musl-cross/aarch64-linux-musl \
  -fuse-ld=lld \
  "$@"
EOF

RUN chmod +x /usr/local/bin/aarch64-musl-clang

# =============================================================================
# LLVM-MinGW (Windows ARM64)
# =============================================================================

# Download and install llvm-mingw for Windows cross-compilation
RUN wget -q https://github.com/mstorsjo/llvm-mingw/releases/download/20231128/llvm-mingw-20231128-ucrt-ubuntu-20.04-x86_64.tar.xz -O /tmp/llvm-mingw.tar.xz \
    && tar -xf /tmp/llvm-mingw.tar.xz -C /opt \
    && rm /tmp/llvm-mingw.tar.xz

ENV PATH="/opt/llvm-mingw-20231128-ucrt-ubuntu-20.04-x86_64/bin:${PATH}"

# =============================================================================
# Rust Targets
# =============================================================================

# Install Rust cross-compilation targets
RUN rustup target add \
    x86_64-unknown-linux-gnu \
    aarch64-unknown-linux-gnu \
    x86_64-unknown-linux-musl \
    aarch64-unknown-linux-musl \
    x86_64-pc-windows-gnu \
    aarch64-pc-windows-gnullvm

# =============================================================================
# Cargo Configuration
# =============================================================================

# Copy cargo config for linker configuration
RUN mkdir -p /root/.cargo
COPY cargo-config.toml /root/.cargo/config.toml
COPY cargo-config.toml /tmp/cargo-config.toml

# =============================================================================
# Project Setup
# =============================================================================

WORKDIR /app

# =============================================================================
# Entrypoint Script
# =============================================================================

# Create entrypoint to ensure cargo config is always available
RUN cat > /entrypoint.sh <<'EOF'
#!/bin/bash
set -e

# Ensure cargo config is present
mkdir -p /root/.cargo

if [ -f /app/docker/cargo-config.toml ]; then
  echo "→ Loading cargo config from /app/docker/cargo-config.toml"
  cp /app/docker/cargo-config.toml /root/.cargo/config.toml
elif [ -f /tmp/cargo-config.toml ]; then
  echo "→ Using backup cargo config from /tmp/cargo-config.toml"
  cp /tmp/cargo-config.toml /root/.cargo/config.toml
fi

exec "$@"
EOF

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["cargo", "build", "--release"]


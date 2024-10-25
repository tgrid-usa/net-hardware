FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME="/home/indy"
ENV LOG_LEVEL=info
ENV RUST_LOG=warning
 
# Install dependencies
RUN apt-get update -y && \
    apt-get install -y \
        git \
        wget \
        python3 \
        python3-pip \
        python3-nacl \
        apt-transport-https \
        ca-certificates \
        pkg-config \
        cmake \
        libssl-dev \
        libsodium-dev \
        libzmq3-dev \
        libsqlite3-dev \
        sqlite3 \
        vim \
        sudo \
        curl \
        build-essential
 
# Create indy user

RUN useradd -ms /bin/bash -u 1001 indy && \
    usermod -a -G sudo indy && \
    echo "indy ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
 
WORKDIR $HOME
 
# Install Rust and build libindy

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain 1.57.0 -y && \
    . $HOME/.cargo/env && \
    git clone https://github.com/hyperledger/indy-sdk.git && \
    cd indy-sdk/libindy && \
    $HOME/.cargo/bin/cargo build --release && \
    cp target/release/libindy.so /usr/lib/ && \
    cp target/release/libindy.so /usr/local/lib/ && \
    ldconfig
 
# Install Python packages

RUN pip3 install --upgrade pip && \
    pip3 install \
        python3-indy \
        asyncio \
        aiohttp \
        base58 \
        prompt_toolkit \
        requests
 
# Create required directories

RUN mkdir -p \
    $HOME/.indy-cli/networks \
    $HOME/.indy_client/wallet \
    $HOME/.indy_client/pool/sandbox \
    $HOME/ledger \
    $HOME/config \
    $HOME/server \
    $HOME/scripts
 
# Copy project files

COPY --chown=indy:indy config $HOME/config
COPY --chown=indy:indy server $HOME/server
COPY --chown=indy:indy scripts $HOME/scripts
COPY --chown=indy:indy indy_config.py /etc/indy/
 
# Set permissions

RUN chown -R indy:indy $HOME && \
    chmod -R ug+rwx $HOME/scripts && \
    chmod -R ug+rwx $HOME/.indy-cli && \
    chmod -R ug+rwx $HOME/.indy_client && \
    chmod +x $HOME/scripts/*.sh && \
    chmod +x $HOME/scripts/*.py
 
USER indy

WORKDIR $HOME
 
EXPOSE 8000 9701 9702 9703 9704 9705 9706 9707 9708

 
# syntax = docker/dockerfile:1.0-experimental

#### Stage - build ####
FROM arm32v7/debian:10-slim as build

# Establish a working directory
RUN mkdir /prisma-build
WORKDIR /prisma-build

# Update default packages
RUN apt-get update

# Get Ubuntu packages
RUN apt-get install -y \
    build-essential \
    curl \
    git \
    libssl-dev \
    pkg-config

# Update new packages
RUN apt-get update

# Setup Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Build prisma-engines
RUN git clone https://github.com/prisma/prisma-engines
WORKDIR prisma-engines
RUN cargo build --release

#### Stage - BASE ####
FROM arm32v7/node:14-buster-slim as base

# Update default packages
RUN apt-get update

# Get Ubuntu packages
RUN apt-get install -y libssl-dev

# Update new packages
RUN apt-get update

# Copy prisma binaries across
COPY --from=build /prisma-build/prisma-engines/target/release/query-engine /prisma-binaries/query-engine
COPY --from=build /prisma-build/prisma-engines/target/release/introspection-engine /prisma-binaries/introspection-engine
COPY --from=build /prisma-build/prisma-engines/target/release/migration-engine /prisma-binaries/migration-engine
COPY --from=build /prisma-build/prisma-engines/target/release/prisma-fmt /prisma-binaries/prisma-fmt

# Setup environment for prisma cli
ENV PRISMA_QUERY_ENGINE_BINARY=/prisma-binaries/query-engine
ENV PRISMA_INTROSPECTION_ENGINE_BINARY=/prisma-binaries/introspection-engine
ENV PRISMA_MIGRATION_ENGINE_BINARY=/prisma-binaries/migration-engine
ENV PRISMA_FMT_BINARY=/prisma-binaries/prisma-fmt

# Install prisma cli globally
RUN npm install -g @prisma/cli



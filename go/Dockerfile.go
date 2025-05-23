FROM ghcr.io/alexmspina/base-dev-container:0.0.2

LABEL org.opencontainers.image.source=https://github.com/alexmspina/dev-containers
LABEL org.opencontainers.image.description="Go 1.24.3 Development Container"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Go 1.24.3 and golangci-lint
RUN curl -LO https://go.dev/dl/go1.24.3.linux-arm64.tar.gz && \
    rm -rf /usr/local/go && \
    tar -C /usr/local -xzf go1.24.3.linux-arm64.tar.gz && \
    rm go1.24.3.linux-arm64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV PATH="${GOPATH}/bin:${PATH}"

RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/bin v1.59.0

WORKDIR /app

SHELL ["/usr/bin/zsh", "-c"]
CMD ["zsh"]
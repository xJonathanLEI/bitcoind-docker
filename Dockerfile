FROM ubuntu:20.04 AS build

ARG BITCOIN_CORE_VERSION

WORKDIR /build

# Install wget
RUN apt-get update
RUN apt-get install wget -y

# Download Bitcoin Core
RUN wget https://bitcoin.org/bin/bitcoin-core-${BITCOIN_CORE_VERSION}/bitcoin-${BITCOIN_CORE_VERSION}-x86_64-linux-gnu.tar.gz

# TODO: verify PGP signature

# Extract binary
RUN tar xzf bitcoin-${BITCOIN_CORE_VERSION}-x86_64-linux-gnu.tar.gz && mv bitcoin-${BITCOIN_CORE_VERSION} bitcoin

FROM ubuntu:20.04

LABEL org.opencontainers.image.source=https://github.com/xJonathanLEI/bitcoind-docker

# Install binary
WORKDIR /bitcoin

COPY --from=build /build/bitcoin/bin .
RUN install -m 0755 -o root -g root -t /usr/local/bin *

RUN rm *

COPY start-bitcoind.sh .
RUN chmod -x ./start-bitcoind.sh

RUN mkdir /data

ENTRYPOINT ["bash", "start-bitcoind.sh"]

FROM ubuntu:18.04 AS build

WORKDIR /build

# Install wget
RUN apt-get update
RUN apt-get install wget -y

# Download Bitcoin Core
RUN wget https://bitcoin.org/bin/bitcoin-core-0.19.0.1/bitcoin-0.19.0.1-x86_64-linux-gnu.tar.gz

# TODO: verify PGP signature

# Extract binary
RUN tar xzf bitcoin-0.19.0.1-x86_64-linux-gnu.tar.gz

FROM ubuntu:18.04

# Install binary
WORKDIR /bitcoin

COPY --from=build /build/bitcoin-0.19.0.1/bin .
RUN install -m 0755 -o root -g root -t /usr/local/bin *

RUN rm *

COPY start-bitcoind.sh .
RUN chmod -x ./start-bitcoind.sh

RUN mkdir /data

ENTRYPOINT ["bash", "start-bitcoind.sh"]
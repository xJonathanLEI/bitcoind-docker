# Bitcoin Core Docker Image

## Docker Hub

Built images are available at [Docker Hub](https://hub.docker.com/r/xjonathanlei/bitcoind).

## Data Storage

`bitcoind` stores data in `/data`

## Environment Variables

### CHAIN

The network for `bitcoind` to run on. Can be one of the following:

- main
- test
- regtest

Defaults to `main`

### TXINDEX

Whether to maintain a full transaction index or not. Can be one of the following:

- true
- false

Defaults to `false`

### RPC_USERNAME

Username for RPC, defaults to `bitcoin`

### RPC_PASSWORD

Password for RPC, defaults to `bitcoin`

#!/bin/bash

# Read chain
if [[ -n "${CHAIN}" ]]; then
  if [[ "${CHAIN}" == "main" ]]; then
    ARG_CHAIN="main"
  elif [[ "${CHAIN}" == "test" ]]; then
    ARG_CHAIN="test"
  elif [[ "${CHAIN}" == "regtest" ]]; then
    ARG_CHAIN="regtest"
  else
    echo "Unknown CHAIN: ${CHAIN}. Valid options are \"main\", \"test\", \"regtest\""
    exit 1
  fi
else
  ARG_CHAIN="main"
fi

# Read txindex
if [[ -n "${TXINDEX}" ]]; then
  if [[ "${TXINDEX}" == "true" ]]; then
    ARG_TXINDEX="1"
  elif [[ "${TXINDEX}" == "false" ]]; then
    ARG_TXINDEX="0"
  else
    echo "Unknown TXINDEX: ${TXINDEX}. Valid options are \"true\", \"false\""
    exit 1
  fi
else
  ARG_TXINDEX="0"
fi

# # Read rpc username
if [[ -n "${RPC_USERNAME}" ]]; then
  ARG_RPCUSER="${RPC_USERNAME}"
else
  ARG_RPCUSER="bitcoin"
fi

# Read rpc password
if [[ -n "${RPC_PASSWORD}" ]]; then
  ARG_RPCPASSWORD="${RPC_PASSWORD}"
else
  ARG_RPCPASSWORD="bitcoin"
fi

exec bitcoind -datadir=/data -chain=${ARG_CHAIN} -rest -server -rpcallowip=0.0.0.0/0 -rpcuser=${ARG_RPCUSER} -rpcpassword=${ARG_RPCPASSWORD} -rpcbind=0.0.0.0 -txindex=${ARG_TXINDEX};

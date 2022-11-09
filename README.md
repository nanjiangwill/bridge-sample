## Setup
```
forge create --rpc-url https://goerli.infura.io/v3/6180f6a9f8e94419b2f3a1d42e814af2 --constructor-args <validator-address> --private-key <private-key> src/AMB.sol:AMB --etherscan-api-key <API> --verify

forge create --rpc-url https://goerli.infura.io/v3/6180f6a9f8e94419b2f3a1d42e814af2 --constructor-args <AMB-contract> --private-key <private-key> src/Counter.sol:Counter --etherscan-api-key <API> --verify


forge create --rpc-url https://polygon-mumbai.infura.io/v3/6180f6a9f8e94419b2f3a1d42e814af2 --constructor-args <validator-address> --private-key <private-key> src/AMB.sol:AMB --etherscan-api-key <API> --verify

forge create --rpc-url https://polygon-mumbai.infura.io/v3/6180f6a9f8e94419b2f3a1d42e814af2 --constructor-args <AMB-contract> --private-key <private-key> src/Counter.sol:Counter --etherscan-api-key <API> --verify
```

## How to run

1. user call send() with their wallet
2. AMB contract will detect this and return corresponding calldata
3. trusted relayer will call AMB contract on the target chain with calldata
4. the contract on the target chain will execute the calldata and return the result


## Some design decisions

1. there might be some security issue(hard to detect sometimes) when we do low level call in AMB.sol and Counter.sol. But we should not import every contract to AMB.sol, since we don't want to track every contract that might need this bridge. we just need to know their address and calldata.
2. In this bridge, we trust the relayer, so we can have the validation part done in AMB.sol instead of Counter.sol.


## Some random thoughts
1. If we trust third party relayer, we can use Hyperlane inter-chain message.
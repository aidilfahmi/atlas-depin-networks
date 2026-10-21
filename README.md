# Atlas DePIN Blockchain Genesis Coordination

This repository coordinates the genesis of the **Atlas DePIN** networks. It is where genesis validators submit their `gentx` files, and where the canonical peer/seed lists for the network are maintained.

If you wish to participate in the testnet as a genesis validator, follow the steps below. Everything here is also captured in [`instructions.sh`](instructions.sh) if you prefer a scripted walkthrough.

## Repository layout

```
networks/
├── instructions.sh          # Step-by-step GenTx generation + submission guide
└── testnet/
    ├── genesis/
    │   ├── peers.txt        # Canonical peer list ({node_id}@{ip:port})
    │   └── seeds.txt        # Seed node list ({node_id}@{ip:port})
    └── gentxs/              # Submitted GenTx files land here
```

## Prerequisites

- The `atlasd` binary, built or downloaded from the [atlas-protocol](https://github.com/Atlas-DePIN/atlas) repository.

## Become a genesis validator

Set your validator info first so all subsequent commands reference it consistently:

```bash
MONIKER="YOUR_VALIDATOR_MONIKER"
WALLETNAME="YOUR_WALLET_NAME"
```

### 1. Initialize the chain

```bash
atlasd init "$MONIKER" --chain-id "itineraria-1"
```

### 2. Create a keypair

```bash
atlasd keys add $WALLETNAME
```

### 3. Register your genesis account

```bash
atlasd genesis add-genesis-account $(atlasd keys show -a $WALLETNAME) 1000000000uatl
```

### 4. Generate the GenTx file

```bash
atlasd genesis gentx $WALLETNAME 500000000uatl \
  --chain-id "itineraria-1" \
  --moniker "$MONIKER" \
  --commission-rate "0.05" \
  --commission-max-rate "0.20" \
  --commission-max-change-rate "0.01" \
  --details "" \
  --security-contact "" \
  --website ""
```

The commission and metadata flags are defaults. Adjust them to match your validator's intended setup.

## Submit your GenTx file

1. **Fork** this repository on GitHub.
2. **Copy** your GenTx file into `./testnet/gentxs/`:

   ```bash
   cp ~/.atlas/config/gentx/* ./testnet/gentxs/
   ```

3. **Get your node ID** and add yourself to the peer list:

   ```bash
   atlasd tendermint show-node-id
   ```

   Add your validator to `./testnet/genesis/peers.txt`, following the format `{node_id}@{ip_address}:{port}`. You may also want to add your validator as a seed in `./testnet/genesis/seeds.txt`.

4. **Open a pull request** adding the GenTx file and any peer/seed entries.

> Don't want to use GitHub? You can submit your GenTx file via Discord, Telegram, or anything else instead and it will be handled.

## Network parameters

| Network | Chain ID | Denom | Status |
| -------- | -------- | -------- | -------- |
| Testnet | itineraria-1 | uatl | Pending GenTXs |

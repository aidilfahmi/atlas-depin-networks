# == Generate GenTx =======
#
# 1. Make your life easier by setting the following variables:
MONIKER="YOUR VALIDATOR MONIKER"
WALLETNAME="YOUR_WALLET_NAME"

# 2. Initialize the chain
atlasd init "$MONIKER" --chain-id "itineraria-1"

# 3. Create a keypair
atlasd keys add $WALLETNAME

# 4. Add your genesis account (using the keypair you just setup)
atlasd genesis add-genesis-account $(atlasd keys show -a $WALLETNAME) 1000000000uatl

# 5. Generate the gentx file
# You may want to change the default parameters seen here.
atlasd genesis gentx $WALLETNAME 500000000uatl \
  --chain-id "itineraria-1" \
  --moniker "$MONIKER" \
  --commission-rate "0.05" \
  --commission-max-rate "0.20" \
  --commission-max-change-rate "0.01" \
  --details "" \
  --security-contact "" \
  --website ""


# == Submit your GenTx file =======
# 0. If you do not know how to use or are too lazy to use GitHub, you can submit your gentx file via Discord or Telegram instead.
#
# 1. Fork this repository on GitHub.
#
# 2. Copy your gentx file to this repository's ./testnet/gentxs/ folder.
#    cp ~/.atlas/config/gentx/* ./testnet/gentxs/
#
# 3. Use the following command to get your node ID:
#    atlasd tendermint show-node-id
#
# 4. Add your validator to ./testnet/genesis/peers.txt, following the format: {node_id}@{ip_address+port}
#    NOTE: you may also want to add your validator as a seed in ./testnet/genesis/seeds.txt.
#
# 5. Commit this file to your fork and open a pull request to add it to this repository.

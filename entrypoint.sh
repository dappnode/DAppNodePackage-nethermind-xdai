#!/bin/sh

case "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_GNOSIS" in
"gnosis-beacon-chain-prysm.dnp.dappnode.eth")
  echo "Using gnosis-beacon-chain-prysm.dnp.dappnode.eth"
  JWT_PATH="/security/prysm/jwtsecret.hex"
  ;;
"lighthouse-gnosis.dnp.dappnode.eth")
  echo "Using lighthouse-gnosis.dnp.dappnode.eth"
  JWT_PATH="/security/lighthouse/jwtsecret.hex"
  ;;
"teku-gnosis.dnp.dappnode.eth")
  echo "Using teku-gnosis.dnp.dappnode.eth"
  JWT_PATH="/security/teku/jwtsecret.hex"
  ;;
*)
  echo "Using default"
  JWT_PATH="/security/default/jwtsecret.hex"
  ;;
esac

# Print the jwt to the dappmanager
JWT=$(cat $JWT_PATH)
curl -X POST "http://my.dappnode/data-send?key=jwt&data=${JWT}"

exec /nethermind/Nethermind.Runner --config xdai \
  --JsonRpc.Enabled=true \
  --JsonRpc.JwtSecretFile=${JWT_PATH} \
  --Init.BaseDbPath=/data \
  --Init.LogDirectory=/data/logs \
  $EXTRA_OPTS

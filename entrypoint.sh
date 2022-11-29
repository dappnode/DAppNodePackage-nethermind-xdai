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
"nimbus-gnosis.dnp.dappnode.eth")
  echo "Using nimbus-gnosis.dnp.dappnode.eth"
  JWT_PATH="/security/nimbus/jwtsecret.hex"
  ;;
*)
  echo "Using default"
  JWT_PATH="/security/default/jwtsecret.hex"
  ;;
esac

# Print the jwt to the dappmanager
JWT=$(cat $JWT_PATH)
curl -X POST "http://my.dappnode/data-send?key=jwt&data=${JWT}"

exec /nethermind/Nethermind.Runner \
  --Sync.FastSync=true \
  --JsonRpc.Enabled=true \
  --JsonRpc.JwtSecretFile=${JWT_PATH} \
  --JsonRpc.Host="0.0.0.0" \
  --JsonRpc.EnginePort=8551 \
  --JsonRpc.EngineHost="0.0.0.0" \
  --JsonRpc.Port=8545 \
  --Init.WebSocketsEnabled=true \
  --Network.DiscoveryPort=31404 \
  --Network.P2PPort=31404 \
  --Init.BaseDbPath=/data \
  --HealthChecks.Enabled true \
  --Init.LogDirectory=/data/logs \
  --Merge.Enabled=true \
  $EXTRA_OPTS
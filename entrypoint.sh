#!/bin/sh

JWT_PATH="/security/jwtsecret.hex"

# Print the jwt to the dappmanager
JWT=$(cat $JWT_PATH)
curl -X POST "http://my.dappnode/data-send?key=jwt&data=${JWT}"

exec /nethermind/Nethermind.Runner \
  --JsonRpc.Enabled=true \
  --JsonRpc.JwtSecretFile=${JWT_PATH} \
  --Init.BaseDbPath=/data \
  --HealthChecks.Enabled true \
  --Init.LogDirectory=/data/logs \
  $EXTRA_OPTS
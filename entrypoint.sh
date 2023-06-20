#!/bin/bash

case "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_GNOSIS" in
"gnosis-beacon-chain-prysm.dnp.dappnode.eth")
  echo "Using gnosis-beacon-chain-prysm.dnp.dappnode.eth"
  JWT_PATH="/security/prysm/jwtsecret.hex"
  ;;
"lighthouse-gnosis.dnp.dappnode.eth")
  echo "Using lighthouse-gnosis.dnp.dappnode.eth"
  JWT_PATH="/security/lighthouse/jwtsecret.hex"
  ;;
"lodestar-gnosis.dnp.dappnode.eth")
  echo "Using lodestar-gnosis.dnp.dappnode.eth"
  JWT_PATH="/security/lodestar/jwtsecret.hex"
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

#Check if the user has added the flag bootnodes
if [[ "$EXTRA_OPTS" = *"Bootnodes"* ]]; then
  echo "Bootnodes already set"
else
  EXTRA_OPTS="--Discovery.Bootnodes enode://a8558c4449bdb4ed47b8fd0ceaee8cf56272cd308e98e693a838d58b9abd2411b71b9b7e2d63a50b140fd9b0a2e05e83f338c3906dd925e9f178f0feda0c4ca7@165.232.138.187:30303,enode://e52280c512cd1f023135d7f70f31904bda7bb699d4300346182a2e3fc5a07637c25cc4349b48101ffe2fe6229b3b165ed7929ad9db971d847d02e21192989ce5@143.198.156.24:30303,enode://8ed1893f617f1ed2c6a978fa92fa38ac19db6de5596c93bf21921c40ed34f63b63a93234ddedf9b385192dd7aa652e1d4b55efed299961b0ae5d4318ecb985ec@159.223.213.61:30303,enode://cc3f99a19360edd73f91f04c6fe728ff8da431f8445a35c02a0fd99fee2be5d9f5ea75a416b08f4a019e0a0d3afa8aece93a560bbe3ce0509eec54bbddc00bb8@178.62.194.136:30303,enode://8f3a63b270cd32692f5b825874b9f3acef3cf90dec40fe54848267f568b7275349efb830812c1b24f1781774f745fb00e595d2feef642fd6867e173f05108cc4@178.62.192.195:30303,enode://075d567bcc5b6bbcb5c9922bf7f17a706408bed141dcefb5d387cfe6e0c7c9407e450a5d17b9180b25fb07b3e82943639d011752ea44a2d868b3c37f48a318b9@167.99.209.14:30303,enode://bb19f1fcf0d0667d9752bec2f4230e24331a7764e5a73a41006378861ef79f9a4386f646e239e1842e4bb721ade9369be8f2fd81b407d9febec2e150ccb7f257@137.184.228.83:30303,enode://529cc11acd013d5e92aa38d4139636619285b2bb4221bcdf7c5dbf171e828d05b88934e6154b984f8164953d7d7530b49c6d0e030fade3a3737d28092a289704@164.92.96.111:30303,enode://9d41c6f8c77a1ac3069cc9326068c04465b9fc56abaaf84fa753fc723511f278dd1d65c22753eb60dfd95f60fe942d0f670c490660e3d6cd518ddafb986682d2@178.62.196.104:30303,enode://874ac7df642fc2abffcca71991c3646a5634a415a4a6513112a89429f7ae43914ad6f1d2ea73a96a19f302c17a7c5e07a0dd01fed70c9294a6fd5615b86710b7@159.223.213.166:30303,enode://5d1a11b5f19afb7d2d04406a4877ed7de92a4ca898ee0d36ff54729b99664e4ac787877e553043a38a38f878aab43fc0d757673e0c11ee8eb606f1ea4681ce3c@147.182.204.197:30303,enode://144d125c790100f6405d957dea8c3a1647199109d915889e90d7f6c2940c8737b16e68e2a3af57327971ec28ed77408f9bc96035b2589da6496f3112ec72e037@137.184.183.65:30303,enode://ac8e8a62f5b54c35f4d7eb565079e9c81e241a150c0d6b2bb5bb32b068e8e4930b14a5b504f77d34014c8e9f14ec0307cc6b239e8c56be85fdcc68d4956cce7c@159.223.213.157:30303,enode://20b0de013d851ae5b667f41a923f2856420161fe0a46030cdea6d81db8da3c5b04070834219a2a6ca41d8f2c6c813870414ce473ab25736742163b0be6191861@159.223.209.185:30303,enode://3c8de197987eb896488ed60037b44c5201878d7cb47d22a322d6d73b999b1d5482820e0456dc08676665ba1ce96906900a2b5f830b2eea73730ca7532c227c7b@159.223.217.249:30303,enode://644ad8205801f9dba1d6eff107590d49479d5276c8d078f8631f351a2077d70b7bed2822219cb1c7590ba68149b89751968a45236e7d02c1025e493d647dd776@159.223.213.162:3030 $EXTRA_OPTS"
fi

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

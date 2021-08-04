# Hyperledger_Private_Data
My lab when Private Data with Hyperledger Fabric

```
rm -rf /tmp/hyperledger/*
docker volume prune
docker network prune
```

## Build the network
```
  docker-compose up -d rca-airline rca-ansp rca-airport ca-tls
 ./allCAnReg_UK_airspace.sh
 ./enrollAllOrgs_UK_airspace.sh
  docker-compose up -d
```

## Build the Channel
```
source term-aftn-channel
source term-airline

configtxgen -profile ${CHANNEL_PROFILE} -configPath ${PWD} -outputBlock ${CHANNEL_NAME}.block -channelID ${CHANNEL_NAME}
```

Output is aftn-channel.block file
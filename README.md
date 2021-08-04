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

```
source term-airline
osnadmin channel join --channelID ${CHANNEL_NAME} --config-block ${CHANNEL_NAME}.block -o $CORE_ORDERER_ADDRESS --ca-file $ORDERER_CA --client-cert $ADMIN_TLS_CERTFILE  --client-key $ADMIN_TLS_KEYFILE

source term-ansp
osnadmin channel join --channelID ${CHANNEL_NAME} --config-block ${CHANNEL_NAME}.block -o $CORE_ORDERER_ADDRESS --ca-file $ORDERER_CA --client-cert $ADMIN_TLS_CERTFILE  --client-key $ADMIN_TLS_KEYFILE

source term-airport
osnadmin channel join --channelID ${CHANNEL_NAME} --config-block ${CHANNEL_NAME}.block -o $CORE_ORDERER_ADDRESS --ca-file $ORDERER_CA --client-cert $ADMIN_TLS_CERTFILE  --client-key $ADMIN_TLS_KEYFILE
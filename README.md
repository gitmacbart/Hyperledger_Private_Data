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
```

## Join the peer(s)
```
source term-airline
peer channel join -b ${CHANNEL_NAME}.block
```
output is
```
2021-08-04 14:20:54.619 CEST [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2021-08-04 14:20:54.758 CEST [channelCmd] executeJoin -> INFO 002 Successfully submitted proposal to join channel
```
join also for ansp and airport members
```
source term-ansp
peer channel join -b ${CHANNEL_NAME}.block

source term-airport
peer channel join -b ${CHANNEL_NAME}.block
```
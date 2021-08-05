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

## Package AFTN chaincode

sacc example modified as follow:
```
	if fn == "set" {
		result, err = set(stub, args)
	} else if fn == "setPrivateAFTN" {
		result, err = setPrivateAFTN(stub, args)
	} else if fn == "setPrivateAirline" {
		result, err = setPrivateAirline(stub, args)
	} else if fn == "setPrivateAnsp" {
		result, err = setPrivateAnsp(stub, args)
	} else if fn == "getPrivate" {
		result, err = getPrivate(stub, args)
	} else if fn == "getPrivateAirline" {
		result, err = getPrivateAirline(stub, args)
	} else if fn == "getPrivateAnsp" {
		result, err = getPrivateAnsp(stub, args)
```

Command is:
```
peer lifecycle chaincode package aftn.tar.gz --path /Users/arnaud/BlockChain/FabricLabs/Hyperledger_Private_Data/aftn --label aftn_1
```
Outcome is aftn.tar.gz file

## Install aftn chaincode

```
source term-airline
peer lifecycle chaincode install aftn.tar.gz
```
outputs is 

> 2021-08-04 14:31:20.797 CEST [cli.lifecycle.chaincode] submitInstallProposal -> INFO 001 Installed remotely: response:<status:200
> 2021-08-04 14:31:20.797 CEST [cli.lifecycle.chaincode] submitInstallProposal -> INFO 002 Chaincode code package identifier: **aftn_1:515aa8ea1ec379ee317d4af35f6b94dff893dc631ed1a492a58eb518d203b2de**

```
source term-ansp
peer lifecycle chaincode install aftn.tar.gz

source term-airport
peer lifecycle chaincode install aftn.tar.gz
```

## Approve Chaincode

```
source term-airline
peer lifecycle chaincode approveformyorg --tls --cafile $ORDERER_CA -o localhost:7050 --channelID $CHANNEL_NAME --name aftncc --version 1 --init-required --sequence 1 --waitForEvent --collections-config collection_UK_airspace.json --package-id aftn_1:515aa8ea1ec379ee317d4af35f6b94dff893dc631ed1a492a58eb518d203b2de
```
> 2021-08-04 14:43:35.822 CEST [chaincodeCmd] ClientWait -> INFO 001 txid >[b646086a57388eadc107bfb777203400868d5a4f8518b63701f92c61f6bba11f] committed with status (VALID) at localhost:7051

```
source term-ansp
peer lifecycle chaincode approveformyorg --tls --cafile $ORDERER_CA -o localhost:8050 --channelID $CHANNEL_NAME --name aftncc --version 1 --init-required --sequence 1 --waitForEvent --collections-config collection_UK_airspace.json --package-id aftn_1:515aa8ea1ec379ee317d4af35f6b94dff893dc631ed1a492a58eb518d203b2de

source term-airport
peer lifecycle chaincode approveformyorg --tls --cafile $ORDERER_CA -o localhost:9050 --channelID $CHANNEL_NAME --name aftncc --version 1 --init-required --sequence 1 --waitForEvent --collections-config collection_UK_airspace.json --package-id aftn_1:515aa8ea1ec379ee317d4af35f6b94dff893dc631ed1a492a58eb518d203b2de
```

## Commit Chaincode

```
source term-airline

peer lifecycle chaincode commit --tls --cafile $ORDERER_CA -o localhost:7050 --peerAddresses $CORE_PEER_ADDRESS --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --peerAddresses localhost:8051 --tlsRootCertFiles /tmp/hyperledger/ansp/peer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem --channelID $CHANNEL_NAME --name aftncc --version 1 --sequence 1 --init-required --collections-config collection_UK_airspace.json
```
Output is

>2021-08-04 14:50:09.976 CEST [chaincodeCmd] ClientWait -> INFO 001 txid >[eb38dd44f4dd8f9bd0f6334b49735046dddf2724f1b9e2a665066f8e81ed6e39] committed with status (VALID) at localhost:7051
>2021-08-04 14:50:10.024 CEST [chaincodeCmd] ClientWait -> INFO 002 txid [eb38dd44f4dd8f9bd0f6334b49735046dddf2724f1b9e2a665066f8e81ed6e39] committed with status (VALID) at localhost:8051

And 3 containers are started as below

>dev-peer1-airport-aftn_1-515aa8ea1ec379ee317d4af35f6b94dff893dc631ed1a492a58eb518d203b2de-67611a118fa520f369591024e31a015adc67febb07fdce398bbe6a84b6e625aa   "chaincode -peer.add…"   42 seconds ago      Up 41 seconds                                                                                             dev-peer1-airport-aftn_1-515aa8ea1ec379ee317d4af35f6b94dff893dc631ed1a492a58eb518d203b2de

>dev-peer1-ansp-aftn_1-515aa8ea1ec379ee317d4af35f6b94dff893dc631ed1a492a58eb518d203b2de-de0937db2d44b1502fb40be2e5bfe660cbc98c6b7bbd6052c25065f66ecbb147      "chaincode -peer.add…"   42 seconds ago      Up 41 seconds                                                                                             dev-peer1-ansp-aftn_1-515aa8ea1ec379ee317d4af35f6b94dff893dc631ed1a492a58eb518d203b2de

>dev-peer1-airline-aftn_1-515aa8ea1ec379ee317d4af35f6b94dff893dc631ed1a492a58eb518d203b2de-01e694ca5cff2016a3062ec072cc1ab23b4f28601cb6b3699fcd455415bf145c   "chaincode -peer.add…"   42 seconds ago      Up 41 seconds                                                                                             dev-peer1-airline-aftn_1-515aa8ea1ec379ee317d4af35f6b94dff893dc631ed1a492a58eb518d203b2de



## Init Chaincode

```
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer1-airline --tls true --cafile $ORDERER_CA --peerAddresses localhost:7051 --tlsRootCertFiles /tmp/hyperledger/airline/peer1/assets/tls-ca/tls-ca-cert.pem --peerAddresses localhost:8051 --tlsRootCertFiles /tmp/hyperledger/ansp/peer1/assets/tls-ca/tls-ca-cert.pem --channelID $CHANNEL_NAME --name aftncc --isInit -c '{"Args":["2021-08-04ZAGBA0849","Created"]}'
```
> That will create the state database on each nodes

```
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer1-airline --tls true --cafile $ORDERER_CA --peerAddresses localhost:7051 --tlsRootCertFiles /tmp/hyperledger/airline/peer1/assets/tls-ca/tls-ca-cert.pem --peerAddresses localhost:8051 --tlsRootCertFiles /tmp/hyperledger/ansp/peer1/assets/tls-ca/tls-ca-cert.pem --channelID $CHANNEL_NAME --name aftncc -c '{"Args":["setPrivateAFTN","2021-08-03ZAGBA0849","RouteText:N0441F380 PODET DCT INGID DCT SIMBA"]}'
```

> That will create private and/or hash databases as referred in the private collection definition

## Observe Databases on each member node

As per docker-compose.yaml definition (username admin password adminpw)

> http://localhost:7984/_utils/#/_all_dbs for airline
> http://localhost:8984/_utils/#/_all_dbs for ansp
> http://localhost:9984/_utils/#/_all_dbs for airport

Regards
Arnaud
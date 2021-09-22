# Hyperledger Topology different channels

Reusing a lot from https://github.com/kctam my reference


Network is: 
- 6 members (
		Airlines [BA,EZ] 
		Ansp [NATS] 
		Airports [LHR, BHX, MAN]

- No system channel

- 2 channels
		UK_Airspace [BA, EZ, NATS] --> consensus is ba, ez and nats
		UK_Airports [BA, EZ, LHR, BHX, MAN] --> consensus is lhr,bhx and man

- 2 chaincodes / dlt(s)
		FPL (flight planning)
		OPS (Airport operations)
		 
Test is to have OPS cc able to query some data frpm FPL dlt

Type of databases:
	State
	Private
	Implicit


```
rm -rf /tmp/hyperledger/*
docker volume prune
docker network prune
```

## Build the network
```
  docker-compose up -d rca-ba rca-ez rca-nats rca-lhr rca-bhx rca-man ca-tls
 ./allCAnReg.sh
 ./enrollAllOrgs.sh
  docker-compose up -d
```

## Build the Channel channelairspace [BA, EZ, NATS] & join the peer(s)
```
source term-channels
source term-ba

configtxgen -profile ${CHANNEL_PROFILE_1} -configPath ${PWD} -outputBlock ${CHANNEL_NAME_1}.block -channelID ${CHANNEL_NAME_1}
```

```
source term-ba
osnadmin channel join --channelID ${CHANNEL_NAME_1} --config-block ${CHANNEL_NAME_1}.block -o $CORE_ORDERER_ADDRESS --ca-file $ORDERER_CA --client-cert $ADMIN_TLS_CERTFILE  --client-key $ADMIN_TLS_KEYFILE
```
Output is:
Status: 201
{
        "name": "channelairspace",
        "url": "/participation/v1/channels/channelairspace",
        "consensusRelation": "consenter",
        "status": "active",
        "height": 1
}

And join the ba peer to the channel channelairspace
```
peer channel join -b ${CHANNEL_NAME_1}.block
```
Repeat this for ez and nats

## Package FPL chaincode

FPL functions as follow:
```
	if fn == "set" {
		result, err = set(stub, args)
	} else if fn == "setFPL" {
		result, err = setFPL(stub, args)
	} else if fn == "getFPL" {
		result, err = getFPL(stub, args)
	} else if fn == "getFPLasBA" {
		result, err = getFPLasBA(stub, args)
	} else if fn == "getFPLasEZ" {
		result, err = getFPLasEZ(stub, args)
	} else { // assume 'get' even if fn is nil
		result, err = get(stub, args)
	}
	if err != nil {
		return shim.Error(err.Error())
	}
```

Package chaincode as below
```
peer lifecycle chaincode package fpl.tar.gz --path /Users/arnaud/BlockChain/FabricLabs/Hyperledger_Private_Data/fpl --label fpl_1
```

## Install fpl chaincode on ba, ez and nats peers

```
source term-ba
peer lifecycle chaincode install fpl.tar.gz
```
Repeat this for ez and nats

## Approve Chaincode

package-id is an output of chaincode installation above

```
source term-ba

peer lifecycle chaincode approveformyorg --tls --cafile $ORDERER_CA -o localhost:7050 --channelID $CHANNEL_NAME_1 --name fplcc --version 1 --init-required --sequence 1 --waitForEvent --signature-policy "OR ('baMSP.peer','natsMSP.peer','ezMSP.peer')" --collections-config collection_airspace.json --package-id fpl_1:c18af9a084a4b9baa6911ea40cb5501d1ebd9691403e4e063ef475a47370168a

```
Repeat this for ez and nats

Note:
--signature-policy "OR ('baMSP.peer','natsMSP.peer','ezMSP.peer')" to supersede the endorsement policy to have only one member to invoke a transaction 

## Commit Chaincode

```
source term-ba

peer lifecycle chaincode commit --tls --cafile $ORDERER_CA -o localhost:7050 --peerAddresses $CORE_PEER_ADDRESS --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --peerAddresses localhost:9051 --tlsRootCertFiles /tmp/hyperledger/nats/peer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem --peerAddresses localhost:8051 --tlsRootCertFiles /tmp/hyperledger/ez/peer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem --channelID $CHANNEL_NAME_1 --name fplcc --version 1 --sequence 1  --init-required --signature-policy "OR ('baMSP.peer','natsMSP.peer','ezMSP.peer')" --collections-config collection_airspace.json

```
And 3 containers for chaincode are started

## Init Chaincode

```
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer1-ba --tls true --cafile $ORDERER_CA --peerAddresses localhost:7051 --tlsRootCertFiles /tmp/hyperledger/ba/peer1/assets/tls-ca/tls-ca-cert.pem --channelID $CHANNEL_NAME_1 --name fplcc --isInit -c '{"Args":["2021-08-04ZAGBA0849","Created"]}' 
```
> That will create the state database on each nodes

```
peer chaincode invoke -o localhost:9050 --ordererTLSHostnameOverride orderer1-nats --tls true --cafile $ORDERER_CA --peerAddresses localhost:9051 --tlsRootCertFiles /tmp/hyperledger/nats/peer1/assets/tls-ca/tls-ca-cert.pem  --channelID $CHANNEL_NAME_1 --name fplcc -c '{"Args":["setFPL","2021-10-03ZAGBA0876","flight plan public RouteText:N0441F380  ","flight plan private RouteText:PODET DCT INGID DCT SIMBA","ez"]}'
```

> That will create private and/or hash databases as referred in the private collection definition

```
       "name": "natsba",
       "policy": "OR('baMSP.member', 'natsMSP.member')",

        "name": "natsez",
        "policy": "OR('ezMSP.member', 'natsMSP.member')",
```

## Observe Databases

As per docker-compose.yaml definition (username admin password adminpw)

> http://localhost:7984/_utils/#/_all_dbs for ba
> http://localhost:8984/_utils/#/_all_dbs for ez
> http://localhost:9984/_utils/#/_all_dbs for nats

Regards
Arnaud
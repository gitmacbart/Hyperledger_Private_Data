# Hyperledger Topology different channels

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

:eye_speech_bubble:
**Note: Update different term-x files and paths to reflect your own environment**

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
# Build the Channel channelairspace [BA, EZ, NATS]

## Join the peer(s)
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

# Install fpl chaincode on ba, ez and nats peers

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


# Build the Channel channelairports [BA, EZ, LHR, BHX, MAN]

## Join the peer(s)
```
source term-channels
source term-lhr

configtxgen -profile ${CHANNEL_PROFILE_2} -configPath ${PWD} -outputBlock ${CHANNEL_NAME_2}.block -channelID ${CHANNEL_NAME_2}
```

```
source term-lhr
osnadmin channel join --channelID ${CHANNEL_NAME_2} --config-block ${CHANNEL_NAME_2}.block -o $CORE_ORDERER_ADDRESS --ca-file $ORDERER_CA --client-cert $ADMIN_TLS_CERTFILE  --client-key $ADMIN_TLS_KEYFILE
```

And join the ba peer to the channel channelairports
```
peer channel join -b ${CHANNEL_NAME_2}.block
```
Repeat this for bhx, man, ba and ez

## Package Fchain chaincode

Fchain functions as follow:
```
	if fn == "set" {
		result, err = set(stub, args)
	} else if fn == "getFPLpublic" {
		result, err = getFPLpublic(stub, args)
	} else if fn == "getFPLprivateasBA" {
		result, err = getFPLprivateasBA(stub, args)
	} else if fn == "getFPLprivateasEZ" {
		result, err = getFPLprivateasBA(stub, args)
	} else { // assume 'get' even if fn is nil
		result, err = get(stub, args)
	}
```

Package chaincode as below
```
peer lifecycle chaincode package fchain.tar.gz --path /Users/arnaud/BlockChain/FabricLabs/Hyperledger_Private_Data/fchain --label fchain_1
```

# Install fchain chaincode on lhr, bhx, man, ba and ez peers

```
source term-lhr
peer lifecycle chaincode install fchain.tar.gz
```
Repeat this for bhx, man,ba and ez.

## Approve Chaincode

package-id is an output of chaincode installation above

```
source term-lhr

peer lifecycle chaincode approveformyorg --tls --cafile $ORDERER_CA -o localhost:10050 --channelID $CHANNEL_NAME_2 --name fchaincc --version 1 --sequence 1  --init-required --waitForEvent --signature-policy "OR ('baMSP.peer','lhrMSP.peer','ezMSP.peer','bhxMSP.peer','manMSP.peer')" --package-id fchain_2:072c8761a8b663965b98b4d95e1803ead880a9d9c566e55f58d4195154e1e2f0

```
Repeat this for bhx, man,ba and ez.

## Commit Chaincode

```
source term-lhr

peer lifecycle chaincode commit --tls --cafile $ORDERER_CA -o localhost:10050 --peerAddresses $CORE_PEER_ADDRESS --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --peerAddresses localhost:11051 --tlsRootCertFiles /tmp/hyperledger/bhx/peer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem --peerAddresses localhost:12051 --tlsRootCertFiles /tmp/hyperledger/man/peer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem --channelID $CHANNEL_NAME_2 --name fchaincc --version 1 --sequence 1  --init-required  --signature-policy "OR ('baMSP.peer','lhrMSP.peer','ezMSP.peer','bhxMSP.peer','manMSP.peer')"

```
And 3 containers for chaincode are started

## Init Chaincode

```
peer chaincode invoke -o localhost:10050 --ordererTLSHostnameOverride orderer1-lhr --tls true --cafile $ORDERER_CA --peerAddresses localhost:10051 --tlsRootCertFiles /tmp/hyperledger/lhr/peer1/assets/tls-ca/tls-ca-cert.pem  --channelID $CHANNEL_NAME_2 --name fchaincc --isInit -c '{"Args":["2021-09-04ZAGBA0872","Created"]}'
```

```
peer chaincode query --channelID $CHANNEL_NAME_2 --name fchaincc -c '{"Args":["getFPLpublic","2021-10-03ZAGBA0872"]}'
```

# Inter channels test

:flight_departure:
As NATS create a flight plan for BA with a public part[N0441F380 ] , a private part [INGIDIMBA] limited to BA & NATS and a restricted part [SIMBA] limited to NATS
This use the chaincode fpl hosted on channel 'channelairspace'

```
>>>source term-nats 
>>>peer chaincode invoke -o localhost:9050 --ordererTLSHostnameOverride orderer1-nats --tls true --cafile $ORDERER_CA --peerAddresses localhost:9051 --tlsRootCertFiles /tmp/hyperledger/nats/peer1/assets/tls-ca/tls-ca-cert.pem  --channelID $CHANNEL_NAME_1 --name fplcc -c '{"Args":["setFPL","2021-10-03ZAGBA0800","flight plan Public:N0441F380  ","flight plan Private:INGIDIMBA","flight plan Restricted:SIMBA","ba"]}'
```

Output is:

2021-09-28 10:05:15.688 CEST [chaincodeCmd] chaincodeInvokeOrQuery -> INFO 001 Chaincode invoke successful. result: status:200 payload:"The asset is 2021-10-03ZAGBA0800 where public info is flight plan Public:N0441F380   and private info is flight plan Private:INGIDIMBAvisible only from nats & ba and restricted info is flight plan Restricted:SIMBA visible only from nats." 

:flight_arrival:
From BA node using chanicode fchain hosted on channel 'channelairports', query public and private informations for flight 2021-10-03ZAGBA080 and potentially update the asset on fchain@channelairports

```
>>>source term-ba                                                                                                       
>>>peer chaincode query --channelID $CHANNEL_NAME_2 --name fchaincc -c '{"Args":["getFPLpublic","2021-10-03ZAGBA0800"]}'
```

Output is:
flight plan Public:N0441F380  

```
>>>peer chaincode query --channelID $CHANNEL_NAME_2 --name fchaincc -c '{"Args":["getFPLprivateasBA","2021-10-03ZAGBA0800"]}'
```

Output is:
Public info is flight plan Public:N0441F380   | Private info only visible by BA & NATS is flight plan Private:INGIDIMBA
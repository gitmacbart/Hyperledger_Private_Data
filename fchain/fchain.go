/*
 * Copyright IBM Corp All Rights Reserved
 *
 * SPDX-License-Identifier: Apache-2.0
 */

 //--- arnaud.bart@sita.aero ----

package main

import (
	"fmt"

	"github.com/hyperledger/fabric-chaincode-go/shim"
	"github.com/hyperledger/fabric-protos-go/peer"
)

type SimpleAsset struct {
}

//----Init----------------------------------------------------------------------------------

func (t *SimpleAsset) Init(stub shim.ChaincodeStubInterface) peer.Response {
	args := stub.GetStringArgs()
	if len(args) != 2 {
		return shim.Error("Incorrect arguments. Expecting a key and a value")
	}
	err := stub.PutState(args[0], []byte(args[1]))
	if err != nil {
		return shim.Error(fmt.Sprintf("Failed to create asset: %s", args[0]))
	}
	return shim.Success(nil)
}
//------------------------------------------------------------------------------------------

//----Invoke---------------------------------------------------------------------------------
func (t *SimpleAsset) Invoke(stub shim.ChaincodeStubInterface) peer.Response {
	fn, args := stub.GetFunctionAndParameters()
	var result string
	var err error
	if fn == "set" {
		result, err = set(stub, args)
	} else if fn == "getFPLpublic" {
		result, err = getFPLpublic(stub, args)
	} else if fn == "getFPLprivateasBA" {
		result, err = getFPLprivateasBA(stub, args)
	} else if fn == "getFPLprivateasEZ" {
		result, err = getFPLprivateasEZ(stub, args)
	} else { // assume 'get' even if fn is nil
		result, err = get(stub, args)
	}
	if err != nil {
		return shim.Error(err.Error())
	}
	return shim.Success([]byte(result))
}
//------------------------------------------------------------------------------------------

//----Set----------------------------------------------------------------------------------
func set(stub shim.ChaincodeStubInterface, args []string) (string, error) {
	if len(args) != 2 {
		return "", fmt.Errorf("Incorrect arguments. Expecting a key and a value")
	}

	err := stub.PutState(args[0], []byte(args[1]))
	if err != nil {
		return "", fmt.Errorf("Failed to set asset: %s", args[0])
	}
	return args[1], nil
}
//------------------------------------------------------------------------------------------

//----Get----------------------------------------------------------------------------------
func get(stub shim.ChaincodeStubInterface, args []string) (string, error) {
	if len(args) != 1 {
		return "", fmt.Errorf("Incorrect arguments. Expecting a key")
	}

	value, err := stub.GetState(args[0])
	if err != nil {
		return "", fmt.Errorf("Failed to get asset: %s with error: %s", args[0], err)
	}
	if value == nil {
		return "", fmt.Errorf("Asset not found: %s", args[0])
	}
	return string(value), nil
}
//------------------------------------------------------------------------------------------

//--- Get FLP public from fplcc within channelairspace--------------------------------------
func getFPLpublic(stub shim.ChaincodeStubInterface, args []string) (string, error) {

	params := []string{"get", args[0]}
	queryArgs := make([][]byte, len(params))
	for i, arg := range params {
		queryArgs[i] = []byte(arg)
	}

	response := stub.InvokeChaincode("fplcc", queryArgs, "channelairspace")
	if response.Status != shim.OK {
		return "", fmt.Errorf("Failed to query chaincode. Got error: %s", response.Payload)
	}
	return string(response.Payload), nil
}
//------------------------------------------------------------------------------------------

//---Get FLP private as BA from fplcc within channelairspace--------------------------------
func getFPLprivateasBA(stub shim.ChaincodeStubInterface, args []string) (string, error) {

	params := []string{"getFPLasBA", args[0]}
	queryArgs := make([][]byte, len(params))
	for i, arg := range params {
		queryArgs[i] = []byte(arg)
	}

	response := stub.InvokeChaincode("fplcc", queryArgs, "channelairspace")
	if response.Status != shim.OK {
		return "", fmt.Errorf("Failed to query chaincode. Got error: %s", response.Payload)
	}
	return string(response.Payload), nil
}
//------------------------------------------------------------------------------------------

//-----Get FLP private as EZ from fplcc within channelairspace------------------------------
func getFPLprivateasEZ(stub shim.ChaincodeStubInterface, args []string) (string, error) {

	params := []string{"getFPLasEZ", args[0]}
	queryArgs := make([][]byte, len(params))
	for i, arg := range params {
		queryArgs[i] = []byte(arg)
	}

	response := stub.InvokeChaincode("fplcc", queryArgs, "channelairspace")
	if response.Status != shim.OK {
		return "", fmt.Errorf("Failed to query chaincode. Got error: %s", response.Payload)
	}
	return string(response.Payload), nil
}
//------------------------------------------------------------------------------------------

//-----Main---------------------------------------------------------------------------------
func main() {
	if err := shim.Start(new(SimpleAsset)); err != nil {
		fmt.Printf("Error starting SimpleAsset chaincode: %s", err)
	}
}
//------------------------------------------------------------------------------------------
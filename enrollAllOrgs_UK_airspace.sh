echo "Enroll airline"

echo "*** Enroll peer1-airline"

mkdir -p /tmp/hyperledger/airline/peer1/assets/ca 
cp /tmp/hyperledger/airline/ca/admin/msp/cacerts/0-0-0-0-7054.pem /tmp/hyperledger/airline/peer1/assets/ca/airline-ca-cert.pem

mkdir -p /tmp/hyperledger/airline/peer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/airline/peer1/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/airline/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airline/peer1/assets/ca/airline-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-airline:peer1PW@0.0.0.0:7054
sleep 5

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airline/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-airline:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-airline --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/airline/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/airline/peer1/tls-msp/keystore/key.pem

echo "### Enroll orderer1-airline"

# preparation
mkdir -p /tmp/hyperledger/airline/orderer1/assets/ca 
cp /tmp/hyperledger/airline/ca/admin/msp/cacerts/0-0-0-0-7054.pem /tmp/hyperledger/airline/orderer1/assets/ca/airline-ca-cert.pem

mkdir -p /tmp/hyperledger/airline/orderer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/airline/orderer1/assets/tls-ca/tls-ca-cert.pem

# for identity
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/airline/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airline/orderer1/assets/ca/airline-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer1-airline:ordererpw@0.0.0.0:7054
sleep 5

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airline/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-airline:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-airline --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/airline/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/airline/orderer1/tls-msp/keystore/key.pem

echo "### Enroll Admin"

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/airline/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airline/peer1/assets/ca/airline-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-airline:airlineAdminPW@0.0.0.0:7054

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airline/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://admin-airline:airlineAdminPW@0.0.0.0:7052 --enrollment.profile tls
sleep 5

cp /tmp/hyperledger/airline/admin/tls-msp/keystore/*_sk /tmp/hyperledger/airline/admin/tls-msp/keystore/key.pem


mkdir -p /tmp/hyperledger/airline/peer1/msp/admincerts
cp /tmp/hyperledger/airline/admin/msp/signcerts/cert.pem /tmp/hyperledger/airline/peer1/msp/admincerts/airline-admin-cert.pem

mkdir -p /tmp/hyperledger/airline/admin/msp/admincerts
cp /tmp/hyperledger/airline/admin/msp/signcerts/cert.pem /tmp/hyperledger/airline/admin/msp/admincerts/airline-admin-cert.pem

mkdir -p /tmp/hyperledger/airline/msp/{admincerts,cacerts,tlscacerts,users}
cp /tmp/hyperledger/airline/peer1/assets/ca/airline-ca-cert.pem /tmp/hyperledger/airline/msp/cacerts/
cp /tmp/hyperledger/airline/peer1/assets/tls-ca/tls-ca-cert.pem /tmp/hyperledger/airline/msp/tlscacerts/
cp /tmp/hyperledger/airline/admin/msp/signcerts/cert.pem /tmp/hyperledger/airline/msp/admincerts/admin-airline-cert.pem
cp ./airline-config.yaml /tmp/hyperledger/airline/msp/config.yaml
cp ./airline-config.yaml /tmp/hyperledger/airline/orderer1/msp/config.yaml

echo "Enroll ansp"

echo "*** Enroll peer1-ansp"

mkdir -p /tmp/hyperledger/ansp/peer1/assets/ca 
cp /tmp/hyperledger/ansp/ca/admin/msp/cacerts/0-0-0-0-7055.pem /tmp/hyperledger/ansp/peer1/assets/ca/ansp-ca-cert.pem

mkdir -p /tmp/hyperledger/ansp/peer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/ansp/peer1/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/ansp/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ansp/peer1/assets/ca/ansp-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-ansp:peer1PW@0.0.0.0:7055
sleep 5

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ansp/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-ansp:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-ansp --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/ansp/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/ansp/peer1/tls-msp/keystore/key.pem

echo "### Enroll orderer1-ansp"

# preparation
mkdir -p /tmp/hyperledger/ansp/orderer1/assets/ca 
cp /tmp/hyperledger/ansp/ca/admin/msp/cacerts/0-0-0-0-7055.pem /tmp/hyperledger/ansp/orderer1/assets/ca/ansp-ca-cert.pem

mkdir -p /tmp/hyperledger/ansp/orderer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/ansp/orderer1/assets/tls-ca/tls-ca-cert.pem

# for identity
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/ansp/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ansp/orderer1/assets/ca/ansp-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer1-ansp:ordererpw@0.0.0.0:7055
sleep 5

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ansp/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-ansp:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-ansp --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/ansp/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/ansp/orderer1/tls-msp/keystore/key.pem

echo "### Enroll Admin"

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/ansp/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ansp/peer1/assets/ca/ansp-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-ansp:anspAdminPW@0.0.0.0:7055

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ansp/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://admin-ansp:anspAdminPW@0.0.0.0:7052 --enrollment.profile tls
sleep 5

cp /tmp/hyperledger/ansp/admin/tls-msp/keystore/*_sk /tmp/hyperledger/ansp/admin/tls-msp/keystore/key.pem

mkdir -p /tmp/hyperledger/ansp/peer1/msp/admincerts
cp /tmp/hyperledger/ansp/admin/msp/signcerts/cert.pem /tmp/hyperledger/ansp/peer1/msp/admincerts/ansp-admin-cert.pem

mkdir -p /tmp/hyperledger/ansp/admin/msp/admincerts
cp /tmp/hyperledger/ansp/admin/msp/signcerts/cert.pem /tmp/hyperledger/ansp/admin/msp/admincerts/ansp-admin-cert.pem

mkdir -p /tmp/hyperledger/ansp/msp/{admincerts,cacerts,tlscacerts,users}
cp /tmp/hyperledger/ansp/peer1/assets/ca/ansp-ca-cert.pem /tmp/hyperledger/ansp/msp/cacerts/
cp /tmp/hyperledger/ansp/peer1/assets/tls-ca/tls-ca-cert.pem /tmp/hyperledger/ansp/msp/tlscacerts/
cp /tmp/hyperledger/ansp/admin/msp/signcerts/cert.pem /tmp/hyperledger/ansp/msp/admincerts/admin-ansp-cert.pem
cp ./ansp-config.yaml /tmp/hyperledger/ansp/msp/config.yaml
cp ./ansp-config.yaml /tmp/hyperledger/ansp/orderer1/msp/config.yaml


echo "Enroll airport"

echo "*** Enroll peer1-airport"

mkdir -p /tmp/hyperledger/airport/peer1/assets/ca 
cp /tmp/hyperledger/airport/ca/admin/msp/cacerts/0-0-0-0-7056.pem /tmp/hyperledger/airport/peer1/assets/ca/airport-ca-cert.pem

mkdir -p /tmp/hyperledger/airport/peer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/airport/peer1/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/airport/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airport/peer1/assets/ca/airport-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-airport:peer1PW@0.0.0.0:7056
sleep 5

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airport/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-airport:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-airport --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/airport/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/airport/peer1/tls-msp/keystore/key.pem

echo "### Enroll orderer1-airport"

# preparation
mkdir -p /tmp/hyperledger/airport/orderer1/assets/ca 
cp /tmp/hyperledger/airport/ca/admin/msp/cacerts/0-0-0-0-7056.pem /tmp/hyperledger/airport/orderer1/assets/ca/airport-ca-cert.pem

mkdir -p /tmp/hyperledger/airport/orderer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/airport/orderer1/assets/tls-ca/tls-ca-cert.pem

# for identity
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/airport/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airport/orderer1/assets/ca/airport-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer1-airport:ordererpw@0.0.0.0:7056
sleep 5

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airport/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-airport:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-airport --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/airport/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/airport/orderer1/tls-msp/keystore/key.pem

echo "### Enroll Admin"

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/airport/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airport/peer1/assets/ca/airport-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-airport:airportAdminPW@0.0.0.0:7056

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airport/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://admin-airport:airportAdminPW@0.0.0.0:7052 --enrollment.profile tls
sleep 5

cp /tmp/hyperledger/airport/admin/tls-msp/keystore/*_sk /tmp/hyperledger/airport/admin/tls-msp/keystore/key.pem

mkdir -p /tmp/hyperledger/airport/peer1/msp/admincerts
cp /tmp/hyperledger/airport/admin/msp/signcerts/cert.pem /tmp/hyperledger/airport/peer1/msp/admincerts/airport-admin-cert.pem

mkdir -p /tmp/hyperledger/airport/admin/msp/admincerts
cp /tmp/hyperledger/airport/admin/msp/signcerts/cert.pem /tmp/hyperledger/airport/admin/msp/admincerts/airport-admin-cert.pem

mkdir -p /tmp/hyperledger/airport/msp/{admincerts,cacerts,tlscacerts,users}
cp /tmp/hyperledger/airport/peer1/assets/ca/airport-ca-cert.pem /tmp/hyperledger/airport/msp/cacerts/
cp /tmp/hyperledger/airport/peer1/assets/tls-ca/tls-ca-cert.pem /tmp/hyperledger/airport/msp/tlscacerts/
cp /tmp/hyperledger/airport/admin/msp/signcerts/cert.pem /tmp/hyperledger/airport/msp/admincerts/admin-airport-cert.pem
cp ./airport-config.yaml /tmp/hyperledger/airport/msp/config.yaml
cp ./airport-config.yaml /tmp/hyperledger/airport/orderer1/msp/config.yaml
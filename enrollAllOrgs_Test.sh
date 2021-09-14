echo "Enroll BA"

echo "*** Enroll peer1-ba"

mkdir -p /tmp/hyperledger/ba/peer1/assets/ca 
cp /tmp/hyperledger/ba/ca/admin/msp/cacerts/0-0-0-0-7054.pem /tmp/hyperledger/ba/peer1/assets/ca/ba-ca-cert.pem

mkdir -p /tmp/hyperledger/ba/peer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/ba/peer1/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/ba/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ba/peer1/assets/ca/ba-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-ba:peer1PW@0.0.0.0:7054
sleep 5

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ba/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-ba:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-ba --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/ba/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/ba/peer1/tls-msp/keystore/key.pem

echo "### Enroll orderer1-ba"

# preparation
mkdir -p /tmp/hyperledger/ba/orderer1/assets/ca 
cp /tmp/hyperledger/ba/ca/admin/msp/cacerts/0-0-0-0-7054.pem /tmp/hyperledger/ba/orderer1/assets/ca/ba-ca-cert.pem

mkdir -p /tmp/hyperledger/ba/orderer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/ba/orderer1/assets/tls-ca/tls-ca-cert.pem

# for identity
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/ba/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ba/orderer1/assets/ca/ba-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer1-ba:ordererpw@0.0.0.0:7054
sleep 5

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ba/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-ba:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-ba --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/ba/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/ba/orderer1/tls-msp/keystore/key.pem

echo "### Enroll Admin"

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/ba/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ba/peer1/assets/ca/ba-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-ba:baAdminPW@0.0.0.0:7054

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ba/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://admin-ba:baAdminPW@0.0.0.0:7052 --enrollment.profile tls
sleep 5

cp /tmp/hyperledger/ba/admin/tls-msp/keystore/*_sk /tmp/hyperledger/ba/admin/tls-msp/keystore/key.pem


mkdir -p /tmp/hyperledger/ba/peer1/msp/admincerts
cp /tmp/hyperledger/ba/admin/msp/signcerts/cert.pem /tmp/hyperledger/ba/peer1/msp/admincerts/ba-admin-cert.pem

mkdir -p /tmp/hyperledger/ba/admin/msp/admincerts
cp /tmp/hyperledger/ba/admin/msp/signcerts/cert.pem /tmp/hyperledger/ba/admin/msp/admincerts/ba-admin-cert.pem

mkdir -p /tmp/hyperledger/ba/msp/{admincerts,cacerts,tlscacerts,users}
cp /tmp/hyperledger/ba/peer1/assets/ca/ba-ca-cert.pem /tmp/hyperledger/ba/msp/cacerts/
cp /tmp/hyperledger/ba/peer1/assets/tls-ca/tls-ca-cert.pem /tmp/hyperledger/ba/msp/tlscacerts/
cp /tmp/hyperledger/ba/admin/msp/signcerts/cert.pem /tmp/hyperledger/ba/msp/admincerts/admin-ba-cert.pem
cp ./ba-config.yaml /tmp/hyperledger/ba/msp/config.yaml
cp ./ba-config.yaml /tmp/hyperledger/ba/orderer1/msp/config.yaml


echo "*************************************************************************************************************"

echo "Enroll ez"

echo "*** Enroll peer1-ez"

mkdir -p /tmp/hyperledger/ez/peer1/assets/ca 
cp /tmp/hyperledger/ez/ca/admin/msp/cacerts/0-0-0-0-7055.pem /tmp/hyperledger/ez/peer1/assets/ca/ez-ca-cert.pem

mkdir -p /tmp/hyperledger/ez/peer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/ez/peer1/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/ez/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ez/peer1/assets/ca/ez-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-ez:peer1PW@0.0.0.0:7055
sleep 5

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ez/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-ez:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-ez --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/ez/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/ez/peer1/tls-msp/keystore/key.pem

echo "### Enroll orderer1-ez"

# preparation
mkdir -p /tmp/hyperledger/ez/orderer1/assets/ca 
cp /tmp/hyperledger/ez/ca/admin/msp/cacerts/0-0-0-0-7055.pem /tmp/hyperledger/ez/orderer1/assets/ca/ez-ca-cert.pem

mkdir -p /tmp/hyperledger/ez/orderer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/ez/orderer1/assets/tls-ca/tls-ca-cert.pem

# for identity
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/ez/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ez/orderer1/assets/ca/ez-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer1-ez:ordererpw@0.0.0.0:7055
sleep 5

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ez/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-ez:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-ez --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/ez/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/ez/orderer1/tls-msp/keystore/key.pem

echo "### Enroll Admin"

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/ez/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ez/peer1/assets/ca/ez-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-ez:ezAdminPW@0.0.0.0:7055

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ez/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://admin-ez:ezAdminPW@0.0.0.0:7052 --enrollment.profile tls
sleep 5

cp /tmp/hyperledger/ez/admin/tls-msp/keystore/*_sk /tmp/hyperledger/ez/admin/tls-msp/keystore/key.pem


mkdir -p /tmp/hyperledger/ez/peer1/msp/admincerts
cp /tmp/hyperledger/ez/admin/msp/signcerts/cert.pem /tmp/hyperledger/ez/peer1/msp/admincerts/ez-admin-cert.pem

mkdir -p /tmp/hyperledger/ez/admin/msp/admincerts
cp /tmp/hyperledger/ez/admin/msp/signcerts/cert.pem /tmp/hyperledger/ez/admin/msp/admincerts/ez-admin-cert.pem

mkdir -p /tmp/hyperledger/ez/msp/{admincerts,cacerts,tlscacerts,users}
cp /tmp/hyperledger/ez/peer1/assets/ca/ez-ca-cert.pem /tmp/hyperledger/ez/msp/cacerts/
cp /tmp/hyperledger/ez/peer1/assets/tls-ca/tls-ca-cert.pem /tmp/hyperledger/ez/msp/tlscacerts/
cp /tmp/hyperledger/ez/admin/msp/signcerts/cert.pem /tmp/hyperledger/ez/msp/admincerts/admin-ez-cert.pem
cp ./ez-config.yaml /tmp/hyperledger/ez/msp/config.yaml
cp ./ez-config.yaml /tmp/hyperledger/ez/orderer1/msp/config.yaml



echo "*******************************************************************************************************"

echo "Enroll nats"

echo "*** Enroll peer1-nats"

mkdir -p /tmp/hyperledger/nats/peer1/assets/ca 
cp /tmp/hyperledger/nats/ca/admin/msp/cacerts/0-0-0-0-7056.pem /tmp/hyperledger/nats/peer1/assets/ca/nats-ca-cert.pem

mkdir -p /tmp/hyperledger/nats/peer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/nats/peer1/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/nats/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/nats/peer1/assets/ca/nats-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-nats:peer1PW@0.0.0.0:7056
sleep 5

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/nats/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-nats:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-nats --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/nats/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/nats/peer1/tls-msp/keystore/key.pem

echo "### Enroll orderer1-nats"

# preparation
mkdir -p /tmp/hyperledger/nats/orderer1/assets/ca 
cp /tmp/hyperledger/nats/ca/admin/msp/cacerts/0-0-0-0-7056.pem /tmp/hyperledger/nats/orderer1/assets/ca/nats-ca-cert.pem

mkdir -p /tmp/hyperledger/nats/orderer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/nats/orderer1/assets/tls-ca/tls-ca-cert.pem

# for identity
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/nats/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/nats/orderer1/assets/ca/nats-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer1-nats:ordererpw@0.0.0.0:7056
sleep 5

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/nats/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-nats:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-nats --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/nats/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/nats/orderer1/tls-msp/keystore/key.pem

echo "### Enroll Admin"

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/nats/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/nats/peer1/assets/ca/nats-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-nats:natsAdminPW@0.0.0.0:7056

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/nats/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://admin-nats:natsAdminPW@0.0.0.0:7052 --enrollment.profile tls
sleep 5

cp /tmp/hyperledger/nats/admin/tls-msp/keystore/*_sk /tmp/hyperledger/nats/admin/tls-msp/keystore/key.pem


mkdir -p /tmp/hyperledger/nats/peer1/msp/admincerts
cp /tmp/hyperledger/nats/admin/msp/signcerts/cert.pem /tmp/hyperledger/nats/peer1/msp/admincerts/nats-admin-cert.pem

mkdir -p /tmp/hyperledger/nats/admin/msp/admincerts
cp /tmp/hyperledger/nats/admin/msp/signcerts/cert.pem /tmp/hyperledger/nats/admin/msp/admincerts/nats-admin-cert.pem

mkdir -p /tmp/hyperledger/nats/msp/{admincerts,cacerts,tlscacerts,users}
cp /tmp/hyperledger/nats/peer1/assets/ca/nats-ca-cert.pem /tmp/hyperledger/nats/msp/cacerts/
cp /tmp/hyperledger/nats/peer1/assets/tls-ca/tls-ca-cert.pem /tmp/hyperledger/nats/msp/tlscacerts/
cp /tmp/hyperledger/nats/admin/msp/signcerts/cert.pem /tmp/hyperledger/nats/msp/admincerts/admin-nats-cert.pem
cp ./nats-config.yaml /tmp/hyperledger/nats/msp/config.yaml
cp ./nats-config.yaml /tmp/hyperledger/nats/orderer1/msp/config.yaml


echo "************************************************************************************************************************"

echo "Enroll lhr"

echo "*** Enroll peer1-lhr"

mkdir -p /tmp/hyperledger/lhr/peer1/assets/ca 
cp /tmp/hyperledger/lhr/ca/admin/msp/cacerts/0-0-0-0-7057.pem /tmp/hyperledger/lhr/peer1/assets/ca/lhr-ca-cert.pem

mkdir -p /tmp/hyperledger/lhr/peer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/lhr/peer1/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/lhr/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/lhr/peer1/assets/ca/lhr-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-lhr:peer1PW@0.0.0.0:7057
sleep 5

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/lhr/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-lhr:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-lhr --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/lhr/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/lhr/peer1/tls-msp/keystore/key.pem

echo "### Enroll orderer1-lhr"

# preparation
mkdir -p /tmp/hyperledger/lhr/orderer1/assets/ca 
cp /tmp/hyperledger/lhr/ca/admin/msp/cacerts/0-0-0-0-7057.pem /tmp/hyperledger/lhr/orderer1/assets/ca/lhr-ca-cert.pem

mkdir -p /tmp/hyperledger/lhr/orderer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/lhr/orderer1/assets/tls-ca/tls-ca-cert.pem

# for identity
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/lhr/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/lhr/orderer1/assets/ca/lhr-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer1-lhr:ordererpw@0.0.0.0:7057
sleep 5

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/lhr/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-lhr:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-lhr --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/lhr/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/lhr/orderer1/tls-msp/keystore/key.pem

echo "### Enroll Admin"

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/lhr/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/lhr/peer1/assets/ca/lhr-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-lhr:lhrAdminPW@0.0.0.0:7057

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/lhr/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://admin-lhr:lhrAdminPW@0.0.0.0:7052 --enrollment.profile tls
sleep 5

cp /tmp/hyperledger/lhr/admin/tls-msp/keystore/*_sk /tmp/hyperledger/lhr/admin/tls-msp/keystore/key.pem


mkdir -p /tmp/hyperledger/lhr/peer1/msp/admincerts
cp /tmp/hyperledger/lhr/admin/msp/signcerts/cert.pem /tmp/hyperledger/lhr/peer1/msp/admincerts/lhr-admin-cert.pem

mkdir -p /tmp/hyperledger/lhr/admin/msp/admincerts
cp /tmp/hyperledger/lhr/admin/msp/signcerts/cert.pem /tmp/hyperledger/lhr/admin/msp/admincerts/lhr-admin-cert.pem

mkdir -p /tmp/hyperledger/lhr/msp/{admincerts,cacerts,tlscacerts,users}
cp /tmp/hyperledger/lhr/peer1/assets/ca/lhr-ca-cert.pem /tmp/hyperledger/lhr/msp/cacerts/
cp /tmp/hyperledger/lhr/peer1/assets/tls-ca/tls-ca-cert.pem /tmp/hyperledger/lhr/msp/tlscacerts/
cp /tmp/hyperledger/lhr/admin/msp/signcerts/cert.pem /tmp/hyperledger/lhr/msp/admincerts/admin-lhr-cert.pem
cp ./lhr-config.yaml /tmp/hyperledger/lhr/msp/config.yaml
cp ./lhr-config.yaml /tmp/hyperledger/lhr/orderer1/msp/config.yaml


echo "****************************************************************************************************************************"

echo "Enroll bhx"

echo "*** Enroll peer1-bhx"

mkdir -p /tmp/hyperledger/bhx/peer1/assets/ca 
cp /tmp/hyperledger/bhx/ca/admin/msp/cacerts/0-0-0-0-7058.pem /tmp/hyperledger/bhx/peer1/assets/ca/bhx-ca-cert.pem

mkdir -p /tmp/hyperledger/bhx/peer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/bhx/peer1/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/bhx/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/bhx/peer1/assets/ca/bhx-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-bhx:peer1PW@0.0.0.0:7058
sleep 5

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/bhx/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-bhx:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-bhx --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/bhx/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/bhx/peer1/tls-msp/keystore/key.pem

echo "### Enroll orderer1-bhx"

# preparation
mkdir -p /tmp/hyperledger/bhx/orderer1/assets/ca 
cp /tmp/hyperledger/bhx/ca/admin/msp/cacerts/0-0-0-0-7058.pem /tmp/hyperledger/bhx/orderer1/assets/ca/bhx-ca-cert.pem

mkdir -p /tmp/hyperledger/bhx/orderer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/bhx/orderer1/assets/tls-ca/tls-ca-cert.pem

# for identity
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/bhx/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/bhx/orderer1/assets/ca/bhx-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer1-bhx:ordererpw@0.0.0.0:7058
sleep 5

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/bhx/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-bhx:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-bhx --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/bhx/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/bhx/orderer1/tls-msp/keystore/key.pem

echo "### Enroll Admin"

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/bhx/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/bhx/peer1/assets/ca/bhx-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-bhx:bhxAdminPW@0.0.0.0:7058

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/bhx/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://admin-bhx:bhxAdminPW@0.0.0.0:7052 --enrollment.profile tls
sleep 5

cp /tmp/hyperledger/bhx/admin/tls-msp/keystore/*_sk /tmp/hyperledger/bhx/admin/tls-msp/keystore/key.pem


mkdir -p /tmp/hyperledger/bhx/peer1/msp/admincerts
cp /tmp/hyperledger/bhx/admin/msp/signcerts/cert.pem /tmp/hyperledger/bhx/peer1/msp/admincerts/bhx-admin-cert.pem

mkdir -p /tmp/hyperledger/bhx/admin/msp/admincerts
cp /tmp/hyperledger/bhx/admin/msp/signcerts/cert.pem /tmp/hyperledger/bhx/admin/msp/admincerts/bhx-admin-cert.pem

mkdir -p /tmp/hyperledger/bhx/msp/{admincerts,cacerts,tlscacerts,users}
cp /tmp/hyperledger/bhx/peer1/assets/ca/bhx-ca-cert.pem /tmp/hyperledger/bhx/msp/cacerts/
cp /tmp/hyperledger/bhx/peer1/assets/tls-ca/tls-ca-cert.pem /tmp/hyperledger/bhx/msp/tlscacerts/
cp /tmp/hyperledger/bhx/admin/msp/signcerts/cert.pem /tmp/hyperledger/bhx/msp/admincerts/admin-bhx-cert.pem
cp ./bhx-config.yaml /tmp/hyperledger/bhx/msp/config.yaml
cp ./bhx-config.yaml /tmp/hyperledger/bhx/orderer1/msp/config.yaml

echo "***************************************************************************************************************************"


echo "Enroll man"

echo "*** Enroll peer1-man"

mkdir -p /tmp/hyperledger/man/peer1/assets/ca 
cp /tmp/hyperledger/man/ca/admin/msp/cacerts/0-0-0-0-7059.pem /tmp/hyperledger/man/peer1/assets/ca/man-ca-cert.pem

mkdir -p /tmp/hyperledger/man/peer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/man/peer1/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/man/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/man/peer1/assets/ca/man-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-man:peer1PW@0.0.0.0:7059
sleep 5

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/man/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-man:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-man --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/man/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/man/peer1/tls-msp/keystore/key.pem

echo "### Enroll orderer1-man"

# preparation
mkdir -p /tmp/hyperledger/man/orderer1/assets/ca 
cp /tmp/hyperledger/man/ca/admin/msp/cacerts/0-0-0-0-7059.pem /tmp/hyperledger/man/orderer1/assets/ca/man-ca-cert.pem

mkdir -p /tmp/hyperledger/man/orderer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/man/orderer1/assets/tls-ca/tls-ca-cert.pem

# for identity
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/man/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/man/orderer1/assets/ca/man-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer1-man:ordererpw@0.0.0.0:7059
sleep 5

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/man/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-man:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-man --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/man/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/man/orderer1/tls-msp/keystore/key.pem

echo "### Enroll Admin"

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/man/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/man/peer1/assets/ca/man-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-man:manAdminPW@0.0.0.0:7059

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/man/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://admin-man:manAdminPW@0.0.0.0:7052 --enrollment.profile tls
sleep 5

cp /tmp/hyperledger/man/admin/tls-msp/keystore/*_sk /tmp/hyperledger/man/admin/tls-msp/keystore/key.pem


mkdir -p /tmp/hyperledger/man/peer1/msp/admincerts
cp /tmp/hyperledger/man/admin/msp/signcerts/cert.pem /tmp/hyperledger/man/peer1/msp/admincerts/man-admin-cert.pem

mkdir -p /tmp/hyperledger/man/admin/msp/admincerts
cp /tmp/hyperledger/man/admin/msp/signcerts/cert.pem /tmp/hyperledger/man/admin/msp/admincerts/man-admin-cert.pem

mkdir -p /tmp/hyperledger/man/msp/{admincerts,cacerts,tlscacerts,users}
cp /tmp/hyperledger/man/peer1/assets/ca/man-ca-cert.pem /tmp/hyperledger/man/msp/cacerts/
cp /tmp/hyperledger/man/peer1/assets/tls-ca/tls-ca-cert.pem /tmp/hyperledger/man/msp/tlscacerts/
cp /tmp/hyperledger/man/admin/msp/signcerts/cert.pem /tmp/hyperledger/man/msp/admincerts/admin-man-cert.pem
cp ./man-config.yaml /tmp/hyperledger/man/msp/config.yaml
cp ./man-config.yaml /tmp/hyperledger/man/orderer1/msp/config.yaml
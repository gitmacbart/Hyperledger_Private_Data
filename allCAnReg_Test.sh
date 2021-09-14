echo "Working on TLS-CA"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/tls-ca/crypto/tls-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/tls-ca/admin

fabric-ca-client enroll -d -u https://tls-ca-admin:tls-ca-adminpw@0.0.0.0:7052
sleep 5

fabric-ca-client register -d --id.name peer1-ba --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer1-ez --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer1-nats --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer1-lhr --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer1-bhx --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer1-man --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052

fabric-ca-client register -d --id.name orderer1-ba --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name orderer1-ez --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name orderer1-nats --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name orderer1-lhr --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name orderer1-bhx --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name orderer1-man --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052


fabric-ca-client register -d --id.name admin-ba --id.secret baAdminPW --id.type admin -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name admin-ez --id.secret ezAdminPW --id.type admin -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name admin-nats --id.secret natsAdminPW --id.type admin -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name admin-lhr --id.secret lhrAdminPW --id.type admin -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name admin-bhx --id.secret bhxAdminPW --id.type admin -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name admin-man --id.secret manAdminPW --id.type admin -u https://0.0.0.0:7052

echo "Working on RCA-ba"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ba/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/ba/ca/admin

fabric-ca-client enroll -d -u https://rca-ba-admin:rca-ba-adminpw@0.0.0.0:7054
sleep 50

fabric-ca-client register -d --id.name peer1-ba --id.secret peer1PW --id.type peer -u https://0.0.0.0:7054
fabric-ca-client register -d --id.name orderer1-ba --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7054
fabric-ca-client register -d --id.name admin-ba --id.secret baAdminPW --id.type admin -u https://0.0.0.0:7054

echo "Working on RCA-ez"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ez/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/ez/ca/admin

fabric-ca-client enroll -d -u https://rca-ez-admin:rca-ez-adminpw@0.0.0.0:7055
sleep 50

fabric-ca-client register -d --id.name peer1-ez --id.secret peer1PW --id.type peer -u https://0.0.0.0:7055
fabric-ca-client register -d --id.name orderer1-ez --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7055
fabric-ca-client register -d --id.name admin-ez --id.secret ezAdminPW --id.type admin -u https://0.0.0.0:7055

echo "Working on RCA-nats"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/nats/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/nats/ca/admin

fabric-ca-client enroll -d -u https://rca-nats-admin:rca-nats-adminpw@0.0.0.0:7056
sleep 5

fabric-ca-client register -d --id.name peer1-nats --id.secret peer1PW --id.type peer -u https://0.0.0.0:7056
fabric-ca-client register -d --id.name orderer1-nats --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7056
fabric-ca-client register -d --id.name admin-nats --id.secret natsAdminPW --id.type admin -u https://0.0.0.0:7056

echo "Working on RCA-lhr"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/lhr/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/lhr/ca/admin

fabric-ca-client enroll -d -u https://rca-lhr-admin:rca-lhr-adminpw@0.0.0.0:7057
sleep 5

fabric-ca-client register -d --id.name peer1-lhr --id.secret peer1PW --id.type peer -u https://0.0.0.0:7057
fabric-ca-client register -d --id.name orderer1-lhr --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7057
fabric-ca-client register -d --id.name admin-lhr --id.secret lhrAdminPW --id.type admin -u https://0.0.0.0:7057


echo "Working on RCA-bhx"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/bhx/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/bhx/ca/admin

fabric-ca-client enroll -d -u https://rca-bhx-admin:rca-bhx-adminpw@0.0.0.0:7058
sleep 5

fabric-ca-client register -d --id.name peer1-bhx --id.secret peer1PW --id.type peer -u https://0.0.0.0:7058
fabric-ca-client register -d --id.name orderer1-bhx --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7058
fabric-ca-client register -d --id.name admin-bhx --id.secret lhrAdminPW --id.type admin -u https://0.0.0.0:7058


echo "Working on RCA-man"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/man/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/man/ca/admin

fabric-ca-client enroll -d -u https://rca-man-admin:rca-man-adminpw@0.0.0.0:7059
sleep 5

fabric-ca-client register -d --id.name peer1-man --id.secret peer1PW --id.type peer -u https://0.0.0.0:7059
fabric-ca-client register -d --id.name orderer1-man --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7059
fabric-ca-client register -d --id.name admin-man --id.secret manAdminPW --id.type admin -u https://0.0.0.0:7059


echo "All CA and registration done"
echo "Working on TLS-CA"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/tls-ca/crypto/tls-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/tls-ca/admin

fabric-ca-client enroll -d -u https://tls-ca-admin:tls-ca-adminpw@0.0.0.0:7052
sleep 5

fabric-ca-client register -d --id.name peer1-airline --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer1-ansp --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer1-airport --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name orderer1-airline --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name orderer1-ansp --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name orderer1-airport --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name admin-airline --id.secret airlineAdminPW --id.type admin -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name admin-ansp --id.secret anspAdminPW --id.type admin -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name admin-airport --id.secret airportAdminPW --id.type admin -u https://0.0.0.0:7052

echo "Working on RCA-airline"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airline/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/airline/ca/admin

fabric-ca-client enroll -d -u https://rca-airline-admin:rca-airline-adminpw@0.0.0.0:7054
sleep 5

fabric-ca-client register -d --id.name peer1-airline --id.secret peer1PW --id.type peer -u https://0.0.0.0:7054
fabric-ca-client register -d --id.name orderer1-airline --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7054
fabric-ca-client register -d --id.name admin-airline --id.secret airlineAdminPW --id.type admin -u https://0.0.0.0:7054

echo "Working on RCA-ansp"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/ansp/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/ansp/ca/admin

fabric-ca-client enroll -d -u https://rca-ansp-admin:rca-ansp-adminpw@0.0.0.0:7055
sleep 5

fabric-ca-client register -d --id.name peer1-ansp --id.secret peer1PW --id.type peer -u https://0.0.0.0:7055
fabric-ca-client register -d --id.name orderer1-ansp --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7055
fabric-ca-client register -d --id.name admin-ansp --id.secret anspAdminPW --id.type admin -u https://0.0.0.0:7055

echo "Working on RCA-airport"

export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/airport/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/airport/ca/admin

fabric-ca-client enroll -d -u https://rca-airport-admin:rca-airport-adminpw@0.0.0.0:7056
sleep 5

fabric-ca-client register -d --id.name peer1-airport --id.secret peer1PW --id.type peer -u https://0.0.0.0:7056
fabric-ca-client register -d --id.name orderer1-airport --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7056
fabric-ca-client register -d --id.name admin-airport --id.secret airportAdminPW --id.type admin -u https://0.0.0.0:7056

echo "All CA and registration done"
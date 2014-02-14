#!/bin/sh

#
# Clone Sickbeard and CouchPotato
# Checkout correct revisions
#

cd /opt/
git clone https://github.com/midgetspy/Sick-Beard.git sickbeard
git clone https://github.com/RuudBurger/CouchPotatoServer.git couchpotato

cd /opt/sickbeard/
git checkout $SB_COMMIT

cd /opt/couchpotato/
git checkout $CP_COMMIT
6e251929903d6f81d988fe25c5c451756d34ffd1
2cfff73486ffb48a490716b80cc371a39b3e8662

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

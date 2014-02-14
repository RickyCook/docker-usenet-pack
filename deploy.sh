#!/bin/sh

#
# Clone Sickbeard and CouchPotato
# Checkout correct revisions
# Link init scripts
#

SB_DIR=/opt/sickbeard
CP_DIR=/opt/couchpotato

git clone https://github.com/midgetspy/Sick-Beard.git "$SB_DIR"
git clone https://github.com/RuudBurger/CouchPotatoServer.git "$CP_DIR"

cd "$SB_DIR"
git checkout $SB_COMMIT
ln -s "$SB_DIR/init.ubuntu" /etc/init.d/sickbeard

cd "$CP_DIR"
git checkout $CP_COMMIT
ln -s "$CP_DIR/init/ubuntu" /etc/init.d/couchpotato

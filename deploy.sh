#!/bin/sh

#
# Clone Sickbeard and CouchPotato
# Checkout correct revisions
# Link init scripts
# Link defaults
#

TOOL_DIR=/opt/docker-usenet-pack
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

# Link defaults, removing file if it already exists
for file in $(ls $TOOL_DIR|grep default-); do
	full_file=/etc/default/${file:8}
	[ -f $full_file ] && rm $full_file
	ln -s $TOOL_DIR/$file $full_file
done

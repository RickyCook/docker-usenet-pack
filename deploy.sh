#!/bin/sh

#
# Checkout correct revisions
# Link init scripts
# Link defaults
#

TOOL_DIR=/opt/docker-usenet-pack
SB_DIR=/opt/sickbeard
CP_DIR=/opt/couchpotato

cd "$SB_DIR"
git fetch
git checkout $SB_COMMIT
ln -s "$SB_DIR/init.ubuntu" /etc/init.d/sickbeard

cd "$CP_DIR"
git fetch
git checkout $CP_COMMIT
ln -s "$CP_DIR/init/ubuntu" /etc/init.d/couchpotato

# Link defaults, removing file if it already exists
for file in $(ls $TOOL_DIR|grep default-); do
	echo "Processing '$file'"
	full_file=/etc/default/${file:8}
	[ -f $full_file ] && rm $full_file
	ln -s $TOOL_DIR/$file $full_file
done

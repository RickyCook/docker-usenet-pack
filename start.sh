#!/bin/sh
# Configure the container
if [ ! -d /data/.docker-usenet-pack ]; then
	/opt/docker-usenet-pack/firstrun.py
fi

# Start the apps
for app in sickbeard couchpotato sabnzbplus; do
	/etc/init.d/$app start
done

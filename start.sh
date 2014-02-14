#!/bin/sh
for app in sickbeard couchpotato sabnzbplus; do
	/etc/init.d/$app start
done

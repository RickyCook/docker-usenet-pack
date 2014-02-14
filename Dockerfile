#
# Usenet Pack
#

FROM debian
MAINTAINER Ricky Cook, mail@thatpanda.com

# Add the sources, update and install
ADD https://github.com/RickyCook/docker-usenet-pack/raw/245d23a21ecefbca834283fcc73d5068b8d3d35e/sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y sabnzbdplus sabnzbdplus-theme-mobile sabnzbdplus-theme-iphone git

# Clone and checkout tools, sickbeard, couchpotato
RUN git clone https://github.com/midgetspy/Sick-Beard.git /opt/sickbeard && git clone https://github.com/RuudBurger/CouchPotatoServer.git /opt/couchpotato
RUN git clone https://github.com/RickyCook/docker-usenet-pack.git /opt/docker-usenet-pack/ && cd /opt/docker-usenet-pack/ && git checkout 70dbd39
RUN SB_COMMIT=6e251929903d6f81d988fe25c5c451756d34ffd1 CP_COMMIT=2cfff73486ffb48a490716b80cc371a39b3e8662 /opt/docker-usenet-pack/deploy.sh

VOLUME ["/data"]
EXPOSE 8080

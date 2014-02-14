#
# Usenet Pack
#

FROM debian
MAINTAINER Ricky Cook, mail@thatpanda.com

# Add the sources, update and install
ADD https://github.com/RickyCook/docker-usenet-pack/raw/245d23a21ecefbca834283fcc73d5068b8d3d35e/sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y sabnzbdplus sabnzbdplus-theme-mobile sabnzbdplus-theme-iphone

EXPOSE 8080

#
# Usenet Pack
#

FROM debian
MAINTAINER Ricky Cook, mail@thatpanda.com

# Add the sources, update and install
ADD https://raw.github.com/RickyCook/docker-usenet-pack/master/sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y sabnzbdplus sabnzbdplus-theme-mobile sabnzbdplus-theme-iphone

EXPOSE 8080

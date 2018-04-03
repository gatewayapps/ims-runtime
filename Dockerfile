FROM ubuntu:xenial
MAINTAINER Daniel Gary <daniel@gatewayapps.com>

RUN mkdir /usr/local/ims -p
WORKDIR /usr/local/ims

# INSTALL COMMON
RUN apt-get update && apt-get install -qq cron wget curl unzip software-properties-common build-essential git

# INSTALL NODE
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get -qy install nodejs

# INSTALL GLOBAL NODE MODULES
RUN npm i -g pm2 bunyan gulp-cli

# INSTALL OPENRESTY
RUN wget -qO - https://openresty.org/package/pubkey.gpg | apt-key add -
RUN add-apt-repository "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main"
RUN apt-get -qy update
RUN apt-get -qy install openresty

# INSTALL PHANTOMJS
RUN apt-get -qy install libpcre3-dev libssl-dev perl make build-essential chrpath libxft-dev
RUN apt-get -qy install libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev
RUN curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 -o phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/
RUN ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin


# INSTALL GRAPHICSMAGICK
RUN apt-get -qy install graphicsmagick

ADD ecosystem.config.js /usr/local/ims/ecosystem.config.js
RUN mkdir /usr/local/ims/store/ims.core.administration -p

ENV NODE_ENV development
EXPOSE 80

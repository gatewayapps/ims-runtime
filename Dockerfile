FROM ubuntu:xenial
MAINTAINER Daniel Gary <daniel@gatewayapps.com>

RUN mkdir /usr/local/ims -p
WORKDIR /usr/local/ims

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.11.3

# INSTALL COMMON
RUN apt-get update && apt-get install -qq cron wget curl unzip software-properties-common build-essential git

RUN apt-get install -y -q --no-install-recommends  sudo g++ gcc git make

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install -g npm \
    && npm cache clean --force

# Set up our PATH correctly so we don't have to long-reference npm, node, &c.
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# INSTALL GLOBAL NODE MODULES
RUN npm i -g pm2 bunyan gulp-cli

RUN npm --version

# INSTALL Python
RUN apt-get -qy install python2.7
RUN ln -s /usr/bin/python2.7 /usr/bin/python

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

# INSTALL MONO
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN sudo echo "deb http://download.mono-project.com/repo/ubuntu stable-xenial main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
RUN sudo apt-get update
RUN sudo apt-get install -qq mono-complete referenceassemblies-pcl mono-xsp4
RUN sudo apt-get install -qq mono-fastcgi-server4
RUN sudo apt-get install -qq nuget

# CONFIGURE FASTCGI PARAMS
RUN echo 'fastcgi_param PATH_INFO   "";' >> /usr/local/openresty/nginx/conf/fastcgi_params
RUN echo 'fastcgi_param SCRIPT_FILENAME   $document_root$fastcgi_script_name;' >> /usr/local/openresty/nginx/conf/fastcgi_params

ADD ecosystem.config.js /usr/local/ims/ecosystem.config.js
RUN mkdir /usr/local/ims/store/ims.core.administration -p

ENV NODE_ENV development
EXPOSE 80

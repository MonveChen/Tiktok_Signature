FROM node:16.17.0

WORKDIR /root

LABEL maintainer="164598724@qq.com"

RUN apt-get update

# Install WebKit dependencies
RUN apt-get install -y libwoff1 \
  libopus0 \
  libwebp6 \
  libwebpdemux2 \
  libenchant1c2a \
  libgudev-1.0-0 \
  libsecret-1-0 \
  libhyphen0 \
  libgdk-pixbuf2.0-0 \
  libegl1 \
  libnotify4 \
  libxslt1.1 \
  libevent-2.1-6 \
  libgles2 \
  libgl1 \
  libvpx5 \
  libgstreamer1.0-0 \
  libgstreamer-gl1.0-0 \
  libgstreamer-plugins-base1.0-0 \
  libgstreamer-plugins-bad1.0-0 \
  libharfbuzz-icu0 \
  libopenjp2-7

# Install Chromium dependencies

RUN apt-get install -y libnss3 \
  libxss1 \
  libasound2

# Install Firefox dependencies
RUN apt-get install -y libdbus-glib-1-2 \
  libxt6

COPY ./package.json /root/package.json

RUN npm i

COPY ./index.js /root/index.js
COPY ./Signer.js /root/Signer.js
COPY ./vercel.json /root/vercel.json

COPY ./entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "./entrypoint.sh"]
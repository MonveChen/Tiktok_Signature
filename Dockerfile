FROM node:16.17.0

WORKDIR /root

LABEL maintainer="164598724@qq.com"

COPY ./package.json /root/package.json

RUN npm i

COPY ./index.js /root/index.js
COPY ./Signer.js /root/Signer.js
COPY ./vercel.json /root/vercel.json

COPY ./entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "./entrypoint.sh"]
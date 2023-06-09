FROM node:16.17.0 as builder

WORKDIR /root

LABEL maintainer="164598724@qq.com"

COPY ./package.json /root/package.json

RUN npm i

COPY ./tsconfig.json /root/tsconfig.json
COPY ./tsconfig.build.json /root/tsconfig.build.json
COPY ./gulpfile.js /root/gulpfile.js
COPY ./src /root/src

RUN npm run build && npm run gulp

RUN rm -rf ./src \
	&& rm -rf ./tsconfig.json \
	&& rm -rf ./tsconfig.build.json

FROM node:16.17.0 as prod

WORKDIR /root

COPY --from=builder /root/dist /root/dist
COPY --from=builder /root/package.json /root/package.json

RUN npm i --omit=dev

COPY ./entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "./entrypoint.sh"]
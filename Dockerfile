FROM node:alpine AS builder

RUN apk add --update --no-cache curl git libevent libffi libjpeg-turbo libssl1.0 sqlite-libs unzip

ARG RIOT_VERSION=0.17.0

RUN curl -L https://github.com/vector-im/riot-web/archive/v$RIOT_VERSION.zip -o riot.zip \
 && unzip riot.zip \
 && rm riot.zip \
 && mv riot-web-* riot-web

WORKDIR riot-web
RUN yarn install
RUN npm run build

FROM node:alpine

RUN npm install -g http-server

WORKDIR /usr/src/app
COPY --from=builder /riot-web/webapp .
COPY --from=builder /riot-web/config.sample.json .
COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 8080/tcp

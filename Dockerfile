FROM node:14-alpine AS builder

RUN apk add --update --no-cache cairo-dev curl g++ git libevent libffi libjpeg-turbo-dev libssl1.1 make pango-dev pkgconf pixman-dev python3 sqlite-libs unzip

ARG ELEMENT_VERSION=0.17.0

RUN curl -L https://github.com/vector-im/element-web/archive/v$ELEMENT_VERSION.zip -o element.zip \
 && unzip element.zip \
 && rm element.zip \
 && mv element-web-* element-web

WORKDIR element-web
RUN yarn install
RUN npm run build

FROM node:14-alpine

RUN npm install -g http-server

WORKDIR /usr/src/app
COPY --from=builder /element-web/webapp .
COPY --from=builder /element-web/config.sample.json .
COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 8080/tcp

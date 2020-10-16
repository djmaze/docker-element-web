# docker-element-web

[![Build status](https://ci.strahlungsfrei.de/api/badges/djmaze/docker-element-web/status.svg)](https://ci.strahlungsfrei.de/djmaze/docker-element-web)

This is a Docker image running a release version of [element-web](https://github.com/vector-im/element-web).

## Usage

Pick a `VERSION` from the tags available at the Docker repository.

```bash
docker run -d \
  -e DEFAULT_HS_URL=https://my.home-server.org \
  -p 8080:8080/tcp \
  mazzolino/element-web:<VERSION>
```

The app will now be available at [http://localhost:8080](http://localhost:8080).

### Available options

The container can be configured through several environment variables:

- `DEFAULT_HS_URL`: default homeserver URL
- `DISABLE_GUESTS`: disable guest access (`true`/`false`)
- `DISABLE_LOGIN_LANGUAGE_SELECTOR`: disable login language selector (`true`/`false`)


See also the supplied [docker-compose config](docker-compose.yml) for an example.

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/misery/ordersprinter/blob/main/LICENSE)

# Ordersprinter in Docker
This repository is to easy deploy and initialize [Ordersprinter](https://www.ordersprinter.de) via docker-compose.


## Cmdline
Just checkout out this repository and create an ``.env`` file in the directory.

```
MYSQL_PASS=
MYSQL_USER=
MYSQL_ROOT_PASS=
MYSQL_DB=
WEB_ROOT=
```

Provide your own database settings via ``MYSQL_`` variable. This will
be used by Ordersprinter during installation.

Since the image does ``NOT`` contain the sources of Ordersprinter you need
to manage that externally. Just extract the ZIP of Ordersprinter and provide
the absolute path to the ``webapp`` directory via ``WEB_ROOT``.
If you use a Unix system you need to change the owner of
``webapp/php`` and ``webapp/php/config.php`` via ``chown 82:82``.


## Portainer
If you use [Portainer](https://github.com/portainer/portainer) for your Docker host.
You can create a stack via a git repository, too.

``Stacks -> Add stack -> Use a git repository``

Now you can provide the following information.
- Name: ordersprinter
- Repository URL: https://github.com/misery/ordersprinter
- Repository reference: refs/heads/main
- Environment variables: See ``.env`` file settings above.


### Portainer as container
If you run Portainer as a container you need to bind mount the data
directory. Otherwise Docker cannot access the local files from the
git repository for the new container.
This is an issue in portainer: [#6390](https://github.com/portainer/portainer/issues/6390)

docker-compose.yml
```
version: '3'

services:
  home:
    image: portainer/portainer-ce:alpine
    container_name: portainer
    command: --data /volume1/docker/portainer
    volumes:
      - /volume1/docker/portainer:/volume1/docker/portainer
      - /volume1/docker/portainer:/data
      - /var/run/docker.sock:/var/run/docker.sock
    restart: always
    ports:
      - "9000:9000"
```

Start up: ``docker-compose up -d``

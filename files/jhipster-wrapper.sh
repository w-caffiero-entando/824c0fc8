#!/bin/sh

docker run --rm -it \
  -v"$PWD":/WORKDIR/ \
  -u $(id -u ${USER}):$(id -g ${USER}) \
  entando-cli bash -l -i -c "
    cd /WORKDIR
    ent-jhipster --color $*
  "

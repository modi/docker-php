#!/usr/bin/env bash

set -euxo pipefail

REPO="modicn/php"
PHP72_VER="7.2.34"
PHP72_TAG="$REPO:$PHP72_VER-fpm-alpine3.12"
PHP72_TAG_SHORT="$REPO:7.2-fpm"

docker build ./7.2/alpine/fpm -t $PHP72_TAG --build-arg PHP_VER=$PHP72_VER
docker push $PHP72_TAG

docker tag $PHP72_TAG $PHP72_TAG_SHORT
docker push $PHP72_TAG_SHORT

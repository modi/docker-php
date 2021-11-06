# docker build . -t modicn/php:7.4.23-fpm-alpine3.14 && docker push modicn/php:7.4.23-fpm-alpine3.14
# docker tag modicn/php:7.4.23-fpm-alpine3.14 modicn/php:7.4-fpm-alpine && docker push modicn/php:7.4-fpm-alpine

FROM php:7.4.23-fpm-alpine3.14

# https://pecl.php.net/package/apcu
ARG PECL_APCU_VER=5.1.20
# https://pecl.php.net/package/memcached
ARG PECL_MEMCACHED_VER=3.1.5
# https://pecl.php.net/package/mongodb
ARG PECL_MONGODB_VER=1.10.0
# https://pecl.php.net/redis
ARG PECL_REDIS_VER=5.3.4

RUN set -ex; \
    apk update; \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        # ext-gd
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        # ext-gmp
        gmp-dev \
        # ext-memcached
        libmemcached-dev \
        # ext-zip
        libzip-dev \
    ; \
    apk add --no-cache \
        # ext-gd
        freetype \
        libjpeg-turbo \
        libpng \
        # ext-memcached
        libmemcached \
        # ext-zip
        libzip \
    ; \
    docker-php-ext-install \
        bcmath \
        gmp \
        opcache \
        pcntl \
        pdo_mysql \
        zip \
    ; \
    docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    ; \
    docker-php-ext-install gd; \
    pecl install \
        apcu-${PECL_APCU_VER} \
        memcached-${PECL_MEMCACHED_VER} \
        mongodb-${PECL_MONGODB_VER} \
        redis-${PECL_REDIS_VER} \
    ; \
    docker-php-ext-enable \
        apcu \
        memcached \
        mongodb \
        redis \
    ; \
    rm -rf /tmp/pear; \
    apk del --no-network .build-deps

ENV LANG C.UTF-8

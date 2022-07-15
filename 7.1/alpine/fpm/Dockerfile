# docker build . -t modicn/php:7.1 && docker push modicn/php:7.1

FROM php:7.1-fpm-alpine

# https://pecl.php.net/package/apcu
ARG PECL_APCU_VER=5.1.21
# https://pecl.php.net/package/libsodium
ARG PECL_LIBSODIUM_VER=2.0.23
# https://pecl.php.net/package/memcached
ARG PECL_MEMCACHED_VER=3.2.0
# https://pecl.php.net/package/mongodb
ARG PECL_MONGODB_VER=1.11.1
# https://pecl.php.net/redis
ARG PECL_REDIS_VER=5.3.7

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
        # ext-mcrypt
        libmcrypt-dev \
        # ext-memcached
        libmemcached-dev \
        # ext-sodium
        libsodium-dev \
        # ext-zip
        libzip-dev \
    ; \
    apk add --no-cache \
        # ext-gd
        freetype \
        libjpeg-turbo \
        libpng \
        # ext-gmp
        gmp \
        # ext-mcrypt
        libmcrypt \
        # ext-memcached
        libmemcached \
        # ext-sodium
        libsodium \
        # ext-zip
        libzip \
        # tools
        unzip \
        icu-libs \
    ; \
    docker-php-ext-install \
        bcmath \
        gmp \
        mcrypt \
        opcache \
        pcntl \
        pdo_mysql \
    ; \
    docker-php-ext-configure gd \
        --with-freetype-dir \
        --with-jpeg-dir \
        --with-png-dir \
    ; \
    docker-php-ext-install gd; \
    pecl install \
        apcu-${PECL_APCU_VER} \
        libsodium-${PECL_LIBSODIUM_VER} \
        memcached-${PECL_MEMCACHED_VER} \
        mongodb-${PECL_MONGODB_VER} \
        redis-${PECL_REDIS_VER} \
    ; \
    docker-php-ext-configure zip --with-libzip; \
    docker-php-ext-install zip; \
    docker-php-ext-enable \
        apcu \
        memcached \
        mongodb \
        redis \
        sodium \
    ; \
    rm -rf /tmp/pear; \
    apk del --no-network .build-deps

ENV LANG C.UTF-8

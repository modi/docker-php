# docker build . -t modicn/php:5.6 && docker push modicn/php:5.6

FROM php:5.6-fpm-alpine

# https://pecl.php.net/package/apcu
ARG PECL_APCU_VER=4.0.11
# https://pecl.php.net/package/memcached
ARG PECL_MEMCACHED_VER=2.2.0
# https://pecl.php.net/redis
ARG PECL_REDIS_VER=4.3.0

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
        # ext-zip
        libzip \
        # tools
        unzip \
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
        memcached-${PECL_MEMCACHED_VER} \
        redis-${PECL_REDIS_VER} \
    ; \
    docker-php-ext-configure zip --with-libzip; \
    docker-php-ext-install zip; \
    docker-php-ext-enable \
        apcu \
        memcached \
        redis \
    ; \
    rm -rf /tmp/pear; \
    apk del --no-network .build-deps; \
    rm -rf /var/cache/apk/*

ENV LANG C.UTF-8

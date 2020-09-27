# docker build . -t modicn/php-dev:7.4.10-fpm-alpine && docker push modicn/php-dev:7.4.10-fpm-alpine

FROM php:7.4.10-fpm-alpine

ARG PHPEXT_APCU_VER=5.1.18
ARG PHPEXT_MEMCACHED_VER=3.1.5
ARG PHPEXT_REDIS_VER=5.3.1
ARG PHPEXT_XDEBUG_VER=2.9.6

RUN set -ex; \
    apk update; \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        # ext-gd
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
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
        # tools
        bash \
        git \
        openssh-client \
        vim \
    ; \
    docker-php-ext-install \
        bcmath \
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
        apcu-${PHPEXT_APCU_VER} \
        memcached-${PHPEXT_MEMCACHED_VER} \
        redis-${PHPEXT_REDIS_VER} \
        xdebug-${PHPEXT_XDEBUG_VER} \
    ; \
    docker-php-ext-enable \
        apcu \
        memcached \
        redis \
        xdebug \
    ; \
    rm -rf /tmp/pear; \
    apk del --no-network .build-deps

ENV LANG C.UTF-8

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini


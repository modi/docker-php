ARG PHP_VER=7.2.34

FROM php:$PHP_VER-fpm-alpine3.12

# https://pecl.php.net/package/apcu
ARG PECL_APCU_VER=5.1.20
# https://pecl.php.net/package/apcu_bc
ARG PECL_APCU_BC_VER=1.0.5
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
        # ext-gmp
        gmp \
        # ext-memcached
        libmemcached \
        # ext-zip
        libzip \
        # BusyBox 提供的 unzip，解压输出的文件，权限是 777
        unzip \
    ; \
    docker-php-ext-install \
        bcmath \
        gd \
        gmp \
        opcache \
        pcntl \
        pdo_mysql \
    ; \
    # https://github.com/php/php-src/blob/php-7.2.34/ext/zip/config.m4
    docker-php-ext-configure zip \
        --with-libzip \
    ; \
    docker-php-ext-install zip; \
    pecl install \
        apcu-${PECL_APCU_VER} \
        apcu_bc-${PECL_APCU_BC_VER} \
        memcached-${PECL_MEMCACHED_VER} \
        mongodb-${PECL_MONGODB_VER} \
        redis-${PECL_REDIS_VER} \
    ; \
    docker-php-ext-enable \
        apc \
        memcached \
        mongodb \
        redis \
    ; \
    # load apcu before apc
    docker-php-ext-enable apcu \
        --ini-name 0-apcu.ini \
    ; \
    rm -rf /tmp/pear; \
    apk del --no-network .build-deps

ENV LANG C.UTF-8

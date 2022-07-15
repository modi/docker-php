# docker build . -t modicn/php:7.3 && docker push modicn/php:7.3

FROM php:7.3-fpm-alpine3.14

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
        # pdo_pgsql
        postgresql-dev \
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
        # BusyBox 的 unzip 输出文件权限是 777 太宽
        unzip \
        # ext-mongodb
        icu-libs \
        # pdo_pgsql
        libpq \
    ; \
    docker-php-ext-install \
        bcmath \
        exif \
        gmp \
        opcache \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
    ; \
    # https://github.com/php/php-src/blob/PHP-7.3/ext/gd/config.m4
    docker-php-ext-configure gd \
        --with-freetype-dir \
        --with-jpeg-dir \
        --with-png-dir \
    ; \
    docker-php-ext-install gd; \
    # https://github.com/php/php-src/blob/PHP-7.3/ext/zip/config.m4
    docker-php-ext-configure zip --with-libzip; \
    docker-php-ext-install zip; \
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

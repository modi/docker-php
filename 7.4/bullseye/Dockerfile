FROM php:7.4-fpm-bullseye AS builder

# https://pecl.php.net/package/apcu
ARG PECL_APCU_VER=5.1.20
# https://pecl.php.net/package/imagick
ARG PECL_IMAGICK_VER=3.7.0
# https://pecl.php.net/package/memcached
ARG PECL_MEMCACHED_VER=3.1.5
# https://pecl.php.net/package/mongodb
ARG PECL_MONGODB_VER=1.10.0
# https://pecl.php.net/redis
ARG PECL_REDIS_VER=5.3.4

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        # ext-gd
        libfreetype-dev \
        libjpeg-dev \
        libpng-dev \
        # ext-gmp
        libgmp-dev \
        # ext-imagemagick
        libmagickwand-dev \
        # ext-memcached
        libmemcached-dev \
        # pdo_pgsql
        libpq-dev \
        # ext-zip
        libzip-dev \
    ; \
    docker-php-ext-install \
        bcmath \
        exif \
        gmp \
        mysqli \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        zip \
    ; \
    # https://github.com/php/php-src/blob/PHP-7.4/ext/gd/config.m4
    docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    ; \
    docker-php-ext-install gd; \
    pecl install \
        apcu-${PECL_APCU_VER} \
        imagick-${PECL_IMAGICK_VER} \
        memcached-${PECL_MEMCACHED_VER} \
        mongodb-${PECL_MONGODB_VER} \
        redis-${PECL_REDIS_VER}

FROM php:7.4-fpm-bullseye

COPY --from=builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        # ext-gd
        libfreetype6 \
        libjpeg62-turbo \
        libpng16-16 \
        # ext-gmp
        libgmp10 \
        # ext-imagick
        libmagickwand-6.q16-6 \
        # ext-memcached
        libmemcached11 \
        # ext-zip
        libzip4 \
        # pdo_pgsql
        libpq5 \
        # 中文字体
        fonts-noto-cjk \
        # other
        unzip \
    ; \
    docker-php-ext-enable \
        apcu \
        bcmath \
        exif \
        gd \
        gmp \
        memcached \
        mongodb \
        mysqli \
        imagick \
        opcache \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        redis \
        zip \
    ; \
    rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

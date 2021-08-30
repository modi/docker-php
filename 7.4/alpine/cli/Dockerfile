# docker build . -t modicn/php-dev:7.4.23-cli-alpine3.14 && docker push modicn/php-dev:7.4.23-cli-alpine3.14
# docker tag modicn/php-dev:7.4.23-cli-alpine3.14 modicn/php-dev:7.4-cli-alpine && docker push modicn/php-dev:7.4-cli-alpine

FROM php:7.4.23-cli-alpine3.14

# https://github.com/composer/composer/releases
ARG COMPOSER_VER=2.1.6
# https://pecl.php.net/package/apcu
ARG PHPEXT_APCU_VER=5.1.20
# https://pecl.php.net/package/memcached
ARG PHPEXT_MEMCACHED_VER=3.1.5
# https://pecl.php.net/redis
ARG PHPEXT_REDIS_VER=5.3.4
# https://pecl.php.net/package/xdebug
ARG PHPEXT_XDEBUG_VER=3.0.4
# https://cs.symfony.com/
ARG PHP_CS_FIXER_VER=v3

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

RUN set -ex; \
    wget https://github.com/composer/composer/releases/download/${COMPOSER_VER}/composer.phar -q -O /usr/local/bin/composer; \
    chmod +x /usr/local/bin/composer

RUN set -ex; \
    wget https://cs.symfony.com/download/php-cs-fixer-${PHP_CS_FIXER_VER}.phar -q -O /usr/local/bin/php-cs-fixer; \
    chmod +x /usr/local/bin/php-cs-fixer

RUN set -ex; \
    git clone --depth=1 --branch stable https://github.com/phacility/arcanist.git /usr/local/src/arcanist; \
    rm -rf /usr/local/src/arcanist/.git; \
    ln -s /usr/local/src/arcanist/bin/arc /usr/local/bin/arc

COPY arcrc /etc/arcconfig

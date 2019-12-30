# docker build . -t modicn/php-dev:7.1-alpine && docker push modicn/php-dev:7.1-alpine

FROM php:7.1-fpm-alpine

RUN set -ex; \
    apk update; \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        # ext-gd
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
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
        # ext-mcrypt
        libmcrypt \
        # ext-memcached
        libmemcached \
        # ext-sodium
        libsodium \
        # ext-zip
        libzip \
        # tools
        bash \
        git \
        openssh-client \
        sudo \
        supervisor \
        vim \
    ; \
    docker-php-ext-install \
        bcmath \
        mcrypt \
        opcache \
        pcntl \
        pdo_mysql \
    ; \
    docker-php-ext-configure zip --with-libzip; \
    docker-php-ext-install zip; \
    docker-php-ext-configure gd \
        --with-freetype-dir \
        --with-jpeg-dir \
        --with-png-dir \
    ; \
    docker-php-ext-install gd; \
    pecl install \
        apcu-5.1.18 \
        libsodium-2.0.22 \
        memcached-3.1.5 \
        redis-5.1.1 \
        xdebug-2.9.0 \
    ; \
    docker-php-ext-enable \
        apcu \
        memcached \
        redis \
        sodium \
        xdebug \
    ; \
    rm -rf /tmp/pear; \
    apk del --no-network .build-deps

RUN set -ex; \
    wget https://github.com/composer/composer/releases/download/1.9.1/composer.phar -q -O /usr/local/bin/composer; \
    chmod +x /usr/local/bin/composer

RUN set -ex; \
    wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -q -O /usr/local/bin/php-cs-fixer; \
    chmod +x /usr/local/bin/php-cs-fixer

RUN set -ex; \
    git clone --depth=1 --branch stable https://github.com/phacility/libphutil.git /usr/local/src/libphutil; \
    rm -rf /usr/local/src/libphutil/.git; \
    git clone --depth=1 --branch stable https://github.com/phacility/arcanist.git /usr/local/src/arcanist; \
    rm -rf /usr/local/src/arcanist/.git; \
    ln -s /usr/local/src/arcanist/bin/arc /usr/local/bin/arc

ENTRYPOINT ["/bin/sh", "-c"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

# docker build . -t modicn/php:5.6-dev && docker push modicn/php:5.6-dev

FROM modicn/php:5.6

# https://github.com/composer/composer/releases
ARG COMPOSER_VER=2.2.12
# https://pecl.php.net/package/xdebug
ARG PHPEXT_XDEBUG_VER=2.5.5
# https://cs.symfony.com
ARG PHP_CS_FIXER_VER=2.19.3

RUN set -ex; \
    apk update; \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
    ; \
    apk add --no-cache \
        # tools
        bash \
        git \
        openssh-client \
        vim \
    ; \
    pecl install \
        xdebug-${PHPEXT_XDEBUG_VER} \
    ; \
    docker-php-ext-enable \
        xdebug \
    ; \
    rm -rf /tmp/pear; \
    apk del --no-network .build-deps

RUN set -ex; \
    wget https://github.com/composer/composer/releases/download/${COMPOSER_VER}/composer.phar -q -O /usr/local/bin/composer; \
    chmod +x /usr/local/bin/composer

RUN set -ex; \
    wget https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v${PHP_CS_FIXER_VER}/php-cs-fixer.phar -q -O /usr/local/bin/php-cs-fixer; \
    chmod +x /usr/local/bin/php-cs-fixer

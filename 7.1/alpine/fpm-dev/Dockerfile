FROM modicn/php:7.1-fpm

# https://github.com/composer/composer/releases
ARG COMPOSER_VER=2.2.12
# https://pecl.php.net/package/xdebug
ARG PHPEXT_XDEBUG_VER=3.0.4
# https://cs.symfony.com/
ARG PHP_CS_FIXER_VER=v3
# https://github.com/bobthecow/psysh
ARG PSYSH_VER=v0.11.4

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
    wget https://cs.symfony.com/download/php-cs-fixer-${PHP_CS_FIXER_VER}.phar -q -O /usr/local/bin/php-cs-fixer; \
    chmod +x /usr/local/bin/php-cs-fixer

RUN set -ex; \
    wget https://github.com/bobthecow/psysh/releases/download/${PSYSH_VER}/psysh-${PSYSH_VER}.tar.gz -q -O /tmp/psysh.tar.gz; \
    tar zxvf /tmp/psysh.tar.gz -C /usr/local/bin; \
    chmod +x /usr/local/bin/psysh; \
    rm /tmp/psysh.tar.gz

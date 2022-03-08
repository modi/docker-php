# docker build . -t modicn/php:7.4.23-fpm-alpine3.14-dev && docker push modicn/php:7.4.23-fpm-alpine3.14-dev
# docker tag modicn/php:7.4.23-fpm-alpine3.14-dev modicn/php:7.4-fpm-alpine-dev && docker push modicn/php:7.4-fpm-alpine-dev

FROM modicn/php:7.4.23-fpm-alpine3.14

# https://github.com/composer/composer/releases
ARG COMPOSER_VER=2.1.6
# https://pecl.php.net/package/xdebug
ARG PHPEXT_XDEBUG_VER=3.0.4
# https://cs.symfony.com/
ARG PHP_CS_FIXER_VER=v3
# https://github.com/bobthecow/psysh
ARG PSYSH_VER=v0.10.8

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
    git clone --depth=1 --branch stable https://github.com/phacility/arcanist.git /usr/local/src/arcanist; \
    ln -s /usr/local/src/arcanist/bin/arc /usr/local/bin/arc; \
    rm -rf /usr/local/src/arcanist/.git

RUN set -ex; \
    wget https://github.com/bobthecow/psysh/releases/download/${PSYSH_VER}/psysh-${PSYSH_VER}.tar.gz -q -O /tmp/psysh.tar.gz; \
    tar zxvf /tmp/psysh.tar.gz -C /usr/local/bin; \
    chmod +x /usr/local/bin/psysh; \
    rm /tmp/psysh.tar.gz

COPY arcrc /etc/arcconfig

# 自用的 PHP Docker 镜像（Dockerized PHP）

基于 [Docker 官方 PHP 镜像](https://hub.docker.com/_/php)构建：

- PHP版本：7.4
- OS：Alpine Linux 3.16
- 中文字体：[Noto CJK](https://github.com/googlefonts/noto-cjk)

## 生产环境版

包含扩展：

- apcu
- bcmath
- exif
- gd
- gmp
- imagick
- memcached
- mongodb
- opcache
- pcntl
- pdo_mysql
- pdo_pgsql
- redis
- zip

## 开发环境版

在生产环境版基础上，增加的扩展：

- xdebug

开发工具：

- Composer
- PHP-CS-Fixer
- Psysh

## 使用

在开发环境版容器里运行 shell：

    docker run --rm -it modicn/php:7.4-dev ash

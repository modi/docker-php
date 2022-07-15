# 自用的 PHP Docker 镜像（Dockerized PHP）

基于 [Docker 官方](https://hub.docker.com/_/php)的 Alpine Linux 版镜像构建。

## 生产环境版

启用的扩展：

- apcu
- bcmath
- exif
- gd
- gmp
- memcached
- mongodb
- opcache
- pcntl
- pdo_mysql
- pdo_pgsql
- redis
- zip

## 开发环境版

在生产环境版基础上，额外启用的扩展：

- xdebug

开发工具：

- Composer
- PHP-CS-Fixer
- Psysh

## 使用

在开发环境版容器里运行 shell：

    docker run --rm -it modicn/php:7.4.23-fpm-alpine3.14-dev ash

# 自用的 PHP Docker 镜像（Dockerized PHP）

基于 [Docker 官方](https://hub.docker.com/_/php)的 Alpine Linux 系统 + PHP 7.4 FPM 镜像，维护了生产环境版和开发环境版两个版本。

生产环境版启用的 PHP 扩展有：

- apcu
- bcmath
- gd
- gmp
- memcached
- mongodb
- opcache
- pcntl
- pdo_mysql
- redis
- zip

开发环境版在生产环境版基础上添加了 xdebug 扩展，并安装了以下工具：

- Composer
- PHP-CS-Fixer
- Arcanist
- Psysh

## 使用

在开发环境版容器里运行 shell：

    docker run --rm -it modicn/php:7.4.23-fpm-alpine3.14-dev ash

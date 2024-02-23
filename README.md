# 自用的 PHP Docker 镜像（Dockerized PHP）

基于 [Docker 官方 PHP 镜像](https://hub.docker.com/_/php)构建：

- PHP版本：5.6 / 7.0 / 7.1 / 7.3 / 7.4 / 8.3
- OS：Alpine Linux 3.16 / Debian 11 (Bullseye)
- 添加了中文字体：[Noto CJK](https://github.com/googlefonts/noto-cjk)

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
- mysqli
- opcache
- pcntl
- pdo_mysql
- pdo_pgsql
- redis
- zip

## 开发环境版

在生产环境版基础上，增加开发工具：

- xdebug
- Composer
- PHP-CS-Fixer
- Psysh

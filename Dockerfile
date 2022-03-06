FROM php:7.4.28-fpm-alpine3.15

RUN apk upgrade -a -U

WORKDIR /var/www/html
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions gd pdo_mysql bcmath zip intl opcache mysqli

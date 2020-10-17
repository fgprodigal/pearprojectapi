FROM php:7.1.31-apache

#添加redis
ENV PHPREDIS_VERSION 5.0.2

COPY .env /

RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz && \
    apt-get update && \
    apt-get install -y libzip-dev zip git && \
    tar xfz /tmp/redis.tar.gz && \
    rm -r /tmp/redis.tar.gz && \
    mkdir -p /usr/src/php/ext && \
    mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis && \
    docker-php-ext-install redis mysqli pdo_mysql && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install zip && \
    rm -rf /usr/src/phpG && \
    apt-get clean -y && \
    mkdir /var/www/html/pearProjectApi && \
    git clone https://github.com/a54552239/pearProjectApi.git /var/www/html/pearProjectApi && \
    mv /.env /var/www/html/pearProjectApi && \
    curl -o vendor.zip https://vilson-static.oss-cn-shenzhen.aliyuncs.com/common/vendor.zip && \
    unzip vendor.zip -d /var/www/html/pearProjectApi && \
    chown -R www-data:www-data /var/www/html/pearProjectApi && \
    rm -rf vendor.zip

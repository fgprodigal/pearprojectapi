FROM php:7.1.31-apache

#添加redis
ENV PHPREDIS_VERSION 5.0.2
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
    curl -o vendor.zip https://vilson-static.oss-cn-shenzhen.aliyuncs.com/common/vendor.zip && \
    unzip vendor.zip -d /var/www/html/pearProjectApi && \
    chown -R www-data:www-data /var/www/html/pearProjectApi && \
    sed -i "s/127.0.0.1/redis/g" /var/www/html/pearProjectApi/config/session.php && \
    sed -i "s/127.0.0.1/redis/g" /var/www/html/pearProjectApi/config/cache.php && \
    sed -i "s/127.0.0.1/db/g" /var/www/html/pearProjectApi/config/database.php && \
    sed -i "13s/root/jsjglzx188/2" /var/www/html/pearProjectApi/config/database.php && \
    rm -rf vendor.zip
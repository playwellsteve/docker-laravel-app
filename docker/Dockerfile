FROM php:7.2-fpm-stretch

ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS=0 \
    PHP_OPCACHE_MAX_ACCELERATED_FILES=8000 \
    PHP_OPCACHE_MEMORY_CONSUMPTION=128


RUN apt-get update -yqq \
  && apt-get install -y --no-install-recommends \
    nginx \
    supervisor \
    procps \
  && docker-php-ext-install pdo_mysql \
  && pecl install xdebug \
  && docker-php-ext-enable xdebug opcache

COPY . /var/www/html

# PHP
COPY docker/config/php/conf.d/*.ini /usr/local/etc/php/conf.d/
COPY docker/config/php/php.ini /usr/local/etc/php/php.ini
COPY docker/config/php/php-fpm.d/docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf


# Supervisor
COPY docker/config/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY docker/config/supervisor/conf.d/*.conf /etc/supervisor/conf.d-available/

# Nginx
COPY docker/config/nginx/default /etc/nginx/sites-available/default
COPY docker/config/nginx/h5bp/ /etc/nginx/h5bp

COPY docker/start.sh /usr/local/bin/start

RUN chown -R www-data:www-data /var/www/html \
  && chmod +x /usr/local/bin/start \
  && ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log 

CMD ["/usr/local/bin/start"]

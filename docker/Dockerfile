FROM php:7.2-apache-stretch

RUN docker-php-ext-install pdo_mysql \
  && pecl install xdebug \
  && docker-php-ext-enable xdebug \
  && a2enmod rewrite

COPY . /var/www/html
COPY docker/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY docker/config/php/conf.d/*.ini /usr/local/etc/php/conf.d/
COPY docker/start.sh /usr/local/bin/start
COPY docker/config/php/php.ini /usr/local/etc/php/php.ini

RUN chown -R www-data:www-data /var/www/html \
  && chmod +x /usr/local/bin/start

CMD ["/usr/local/bin/start"]

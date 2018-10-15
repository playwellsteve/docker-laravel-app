FROM php:7.2-apache-stretch

COPY . /var/www/html
COPY docker/vhost.conf /etc/apache2/sites-available/000-default.conf

RUN chown -R www-data:www-data /var/www/html \
  && docker-php-ext-install pdo_mysql \
  && a2enmod rewrite
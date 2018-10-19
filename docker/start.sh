#!/usr/bin/env bash

set -e

env=${APP_ENV:-production}
role=${CONTAINER_ROLE:-app}


if [ "$env" != "local" ]; then
    echo "Caching configuration"
    (
        cd /var/www/html &&
        php artisan config:cache &&
        php artisan route:cache &&
        php artisan view:cache
     )
    echo "Removing Xdebug"
    rm -rf /usr/local/etc/php/conf.d/{docker-php-ext-xdebug.ini,xdebug.ini}
fi

echo "The role is $role ..."

if [ "$role" = "app" ]; then
    exec supervisord -c /etc/supervisor/supervisord.conf
elif [ "$role" = "scheduler" ]; then
    echo "Scheduler is running"
    while [ true ]
    do
        php /var/www/html/artisan schedule:run --verbose --no-interaction &
        sleep 60
    done
elif [ "$role" = "queue" ]; then
    echo "Running the queue"
    php /var/www/html/artisan queue:work --verbose --tries=3 --timeout=90
    iexit 0
else
    echo "Could not match the container role \"$role\""
    exit 1
fi
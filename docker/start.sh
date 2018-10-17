#!/usr/bin/env bash

set -e

env=${APP_ENV:-production}


if [ "$env" != "local" ]; then
    echo "Removing Xdebug"
    rm -rf /usr/local/etc/php/conf.d/{docker-php-ext-xdebug.ini,xdebug.ini}
fi

exec apache2-foreground
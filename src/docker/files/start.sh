#!/bin/bash

function changeNginxEnvVars {
    if [ -z "$2" ]; then
            echo "Environment variable '$1' not set."
            return
    fi

    echo "Replacing {$1} for $2 on /vhost.conf"

    sed -i "s/{$1}/$2/g" /vhost.conf
}

for _curVar in `env | awk -F = '{print $1}'`;do
    changeNginxEnvVars ${_curVar} ${!_curVar}
done

cp /vhost.conf /runtime

# publish assets & run migrations
/srv/www/yii migrate/up --interactive=0

touch /srv/www/runtime/logs/app.log

# output application log to docker logs
tail -n 0 -f /srv/www/runtime/logs/app.log &

# start php-fpm
exec php-fpm

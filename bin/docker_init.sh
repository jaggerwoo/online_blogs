#!/bin/sh

# override container nginx
chmod -R 777 /var/lib/nginx
chmod -R 777 /var/log/nginx
rm -f /etc/nginx/sites-enabled/default
cp -f /home/app/docker/.htpasswd /etc/nginx/
# app pre config
cp -Rf /home/app/config/docker/* /home/app/config/
# system pre config
/home/app/bin/pre_config.rb
# set TZ
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# assets:precompile
if [ -z "$SKIP_ASSETS" ]; then
    cd /home/app
    echo "run assets:precompile..."
    rm -rf /home/app/public/assets
    DB_ADAPTER=nulldb bundle exec rake assets:precompile
fi

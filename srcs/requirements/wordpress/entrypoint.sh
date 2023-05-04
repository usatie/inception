#!/bin/sh
wp config create --path=$WP_DATA_PATH --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST
wp core install --path=$WP_DATA_PATH --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL
php-fpm81 --nodaemonize

#!/bin/sh +x
wp config create \
	--path=$WP_DATA_PATH \
	--dbname=$DB_NAME \
	--dbuser=$DB_USER \
	--dbpass=$DB_PASSWORD \
	--dbhost=$DB_HOST
wp core install \
	--path=$WP_DATA_PATH \
	--url=$WP_URL \
	--title="$WP_TITLE" \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL \
	--skip-email
wp user create \
	$WP_EDITOR_USER \
	$WP_EDITOR_EMAIL \
	--path=$WP_DATA_PATH \
	--role=author \
	--user_pass=$WP_EDITOR_PASSWORD
exec php-fpm81 --nodaemonize

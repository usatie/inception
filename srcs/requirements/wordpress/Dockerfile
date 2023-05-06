FROM alpine:3.17.2

RUN apk add --update --no-cache php81 php81-fpm php81-mysqli php81-phar php81-iconv mariadb-client

# Install wget
ENV WP_PATH=/var/www/html/wordpress
# Download, Extract, Move to /var/www/html, and Remove wordpress.tar.gz in one line
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp \
	&& adduser -u 82 -D -S -G www-data www-data \
	&& mkdir -p $WP_PATH \
	&& wp core download --path=$WP_PATH --allow-root \
	&& chown -R www-data:www-data /var/www/html/wordpress

#COPY conf/wp-config.php /var/www/html/wordpress/wp-config.php
COPY conf/zz-docker.conf /etc/php81/php-fpm.d/zz-docker.conf

EXPOSE 9000

# php-fpm can't run as www-data, why?
#USER www-data
WORKDIR /var/www/html/wordpress
COPY ./entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
#ENTRYPOINT ["php-fpm81", "--nodaemonize"]

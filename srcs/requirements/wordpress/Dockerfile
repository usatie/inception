FROM alpine:3.17.3

RUN apk add --update --no-cache php81 php81-fpm php81-mysqli

# Download, Extract, Move to /var/www/html, and Remove wordpress.tar.gz in one line
RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xvf latest.tar.gz \
	&& mkdir -p /var/www/html/ \
	&& mv wordpress /var/www/html/ \
	&& rm latest.tar.gz \
	&& adduser -u 82 -D -S -G www-data www-data \
	&& chown -R www-data:www-data /var/www/html/wordpress

COPY conf/wp-config.php /var/www/html/wordpress/wp-config.php
COPY conf/zz-docker.conf /etc/php81/php-fpm.d/zz-docker.conf

EXPOSE 9000

# php-fpm can't run as www-data, why?
#USER www-data
WORKDIR /var/www/html/wordpress
ENTRYPOINT ["php-fpm81", "--nodaemonize"]

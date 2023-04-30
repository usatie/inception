FROM alpine:3.17.3
#FROM php:8.1-fpm-alpine

RUN apk add --update --no-cache php81 php81-fpm

# Download, Extract, Move to /var/www/html, and Remove wordpress.tar.gz in one line
RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xvf latest.tar.gz \
	&& mkdir -p /var/www/html/ \
	&& mv wordpress /var/www/html/ \
	&& rm latest.tar.gz \
	&& adduser -u 82 -D -S -G www-data www-data \
	&& chown -R www-data:www-data /var/www/html/wordpress

COPY conf/zz-docker.conf /etc/php81/php-fpm.d/zz-docker.conf

ENTRYPOINT ["php-fpm81", "--nodaemonize"]
FROM alpine:3.17.2

RUN apk add --update --no-cache nginx openssl gettext
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /etc/nginx/https.d \
	&& mkdir -p /etc/nginx/ssl
COPY conf/ssl.conf /etc/nginx/https.d/ssl.template
WORKDIR /etc/nginx

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 443

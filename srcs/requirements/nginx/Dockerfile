FROM alpine:3.17.3

RUN apk add --update --no-cache nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/ssl.conf /etc/nginx/conf.d/ssl.conf
COPY ssl/server.crt /etc/nginx/ssl/server.crt
COPY ssl/server.key /etc/nginx/ssl/server.key
COPY ssl/server.password /etc/nginx/ssl/server.password

RUN echo "hello world" > /var/www/index.html

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]

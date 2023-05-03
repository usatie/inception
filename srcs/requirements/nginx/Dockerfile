FROM alpine:3.17.3

RUN apk add --update --no-cache nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /etc/nginx/https.d
COPY conf/ssl.conf /etc/nginx/https.d/ssl.conf
COPY ssl/server.crt /etc/nginx/ssl/server.crt
COPY ssl/server.key /etc/nginx/ssl/server.key
COPY ssl/server.password /etc/nginx/ssl/server.password

ENTRYPOINT ["nginx", "-g", "daemon off;"]

FROM alpine:3.17.2

RUN apk add --update --no-cache mysql mysql-client openrc; \
	mkdir -p /run/openrc; \
	touch /run/openrc/softlevel; \
	sed -i 's/^skip-networking/skip-networking = 0\nskip-bind-address\nskip-name-resolve\nport = 3306\ncharacter-set-server = utf8/g' /etc/my.cnf.d/mariadb-server.cnf; \
	rc-status; \
	# purge and re-create /var/lib/mysql with appropriate ownership \
	rm -rf /var/lib/mysql; \
	mkdir -p /var/lib/mysql /var/run/mysqld; \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld; \
	# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime \
	chmod 777 /var/run/mysqld;

#ENTRYPOINT ["/bin/sh"]
COPY ./entrypoint.sh /usr/local/bin/
EXPOSE 3306
ENTRYPOINT ["entrypoint.sh"]

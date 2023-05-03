FROM alpine:3.17.3

RUN apk add --update --no-cache mysql mysql-client openrc \
	&& mkdir -p /run/openrc \
	&& touch /run/openrc/softlevel \
	&& sed -i 's/^skip-networking/skip-networking = 0\nskip-bind-address\nskip-name-resolve\nport = 3306\ncharacter-set-server = utf8/g' /etc/my.cnf.d/mariadb-server.cnf \
	&& rc-status \
	&& rc-service mariadb setup \
	&& rc-service mariadb start \
	&& echo "SELECT User FROM mysql.user;" >> /tmp/sql \
	&& echo "CREATE USER 'wordpress' IDENTIFIED BY 'password';" >> /tmp/sql \
	&& echo "CREATE DATABASE IF NOT EXISTS wordpress DEFAULT CHARACTER SET utf8;" >> /tmp/sql \
	&& echo "grant all privileges on wordpress.* to wordpress@'%' with grant option ;" >> /tmp/sql \
	&& echo "DELETE FROM mysql.user WHERE User='';" >> /tmp/sql \
	&& echo "DROP DATABASE test;" >> /tmp/sql \
	&& echo "FLUSH PRIVILEGES;" >> /tmp/sql \
	&& mysql --user=root < /tmp/sql \
	&& rm -rf /tmp/sql \
	&& rc-service mariadb stop

USER mysql
#ENTRYPOINT ["/bin/sh"]
EXPOSE 3306
ENTRYPOINT ["mysqld", "--datadir=/var/lib/mysql"]

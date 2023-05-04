#!/bin/sh -x

# if $DATADIR/mysql not exist, initialize database
if [ ! -d "${MYSQL_DATA_PATH}/mysql" ]; then
	# Don't know why, but it doesn't work
    # mysql_install_db --datadir=${MYSQL_DATA_PATH}
	rc-service mariadb setup
	# Wait for mariadb to be ready
    rc-service mariadb start
    mysqladmin -u root password "${MYSQL_ROOT_PASSWORD}"
	echo "CREATE USER '${MYSQL_USER}' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> /tmp/sql
    echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} DEFAULT CHARACTER SET utf8;"  >> /tmp/sql
    echo "grant all privileges on ${MYSQL_DATABASE}.* to ${MYSQL_USER}@'%' identified by '${MYSQL_PASSWORD}' with grant option ;" >> /tmp/sql
    echo "DELETE FROM mysql.user WHERE User='';" >> /tmp/sql
    echo "DROP DATABASE test;" >> /tmp/sql
    echo "FLUSH PRIVILEGES;" >> /tmp/sql
    cat /tmp/sql | mysql -u root --password="${MYSQL_ROOT_PASSWORD}"
    rm /tmp/sql
    rc-service mariadb stop
fi

exec mysqld --datadir=/var/lib/mysql --user=mysql

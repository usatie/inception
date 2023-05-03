#!/bin/sh -x
declare -g DATABASE_ALREADY_EXISTS
if [ -d "$DATADIR/mysql" ]; then
	DATABASE_ALREADY_EXISTS='true'
fi

if [ ! -d "${DB_DATA_PATH}/mysql" ]; then
	# Don't know why, but it doesn't work
    # mysql_install_db --datadir=${DB_DATA_PATH}
	rc-service mariadb setup
	# Wait for mariadb to be ready
    rc-service mariadb start
    mysqladmin -u root password "${DB_ROOT_PASS}"
	echo "CREATE USER '${DB_USER}' IDENTIFIED BY '${DB_PASS}';" >> /tmp/sql
    echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME} DEFAULT CHARACTER SET utf8;"  >> /tmp/sql
    echo "grant all privileges on ${DB_NAME}.* to ${DB_USER}@'%' identified by '${DB_PASS}' with grant option ;" >> /tmp/sql
    echo "DELETE FROM mysql.user WHERE User='';" >> /tmp/sql
    echo "DROP DATABASE test;" >> /tmp/sql
    echo "FLUSH PRIVILEGES;" >> /tmp/sql
    cat /tmp/sql | mysql -u root --password="${DB_ROOT_PASS}"
    rm /tmp/sql
    rc-service mariadb stop
fi

mysqld --datadir=/var/lib/mysql --user=mysql

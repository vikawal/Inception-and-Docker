#!bin/sh
#start new of it not existimng yet
if [ ! -d "/var/lib/mysql/mysql" ]; then
#change owner to mysql (R -recursive - all die and files):
#so DB has all permisssion to read/write database files
        chown -R mysql:mysql /var/lib/mysql

        # init database: where is it stored & user --rpm (compatibility with Red Hat Package management)
        mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm
# temp file creating, if fail -> exit with error, DB is not proceeding
        tfile=`mktemp`
        if [ ! -f "$tfile" ]; then
                return 1
        fi
fi
#if WP DB exists? no ->
if [ ! -d "/var/lib/mysql/wordpress" ]; then
#create temp file and write there SQL commands:
#swith to mysql systen DB
#all privilieges work immediately
#remove anonym users (sequrity)
#delete defalt "test DB" and references to it
#delete root accounts with remote access
#root login limited to localhost (secure)
#root passw-> .env value
#create WP DB name(.env) if it doesn't exist with UTF encoding
# creating user and password and give him all permissions
#and allow to connect on any IP addresses (@'%')
#reload priviligies to make them work immediately
        cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM     mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
        # run init.sql in init setup mode (bootstrap) and execute commands
        /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
        rm -f /tmp/create_db.sql
        #remove temp dir
fi

FROM alpine:3.16
#using .env arguments when building
ARG DB_NAME \
    DB_USER \
    DB_PASS \
    DB_ROOT
    # installing mariaDB and client for SQL
RUN apk update && apk add --no-cache mariadb=10.6.16-r0 mariadb-client=10.6.16-r0
#dir for storaging DB runtime process (PID)
RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    #creating congif file at /etc/my.cnf.d/docker.cnf;
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      #no chaching for host
      echo 'skip-name-resolve'; \
      #use API address instead of DNS names (google ->142.250.74.238)
      echo 'bind-address=0.0.0.0'; \
      #accept any API address
    } | tee  /etc/my.cnf.d/docker.cnf; \
    # modifying mariadb-server.cnf: enable networking (for Docker)
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf
#initialize empty DB as the sql user of root in dir
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306
#copy and run the creation script and delete (security)
COPY requirements/mariadb/conf/create_db.sh .
RUN sh create_db.sh && rm create_db.sh
#run commands inside container sd mysql user
USER mysql
#start DB server, no logging errors to disk (preferred in containers)
CMD ["/usr/bin/mysqld", "--skip-log-error"]

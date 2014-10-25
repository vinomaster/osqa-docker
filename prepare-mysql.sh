/usr/sbin/mysqld &
sleep 10
echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
echo "CREATE USER 'osqa'@'localhost' IDENTIFIED BY 'osqa'" | mysql
echo "CREATE DATABASE osqa DEFAULT CHARACTER SET UTF8 COLLATE utf8_general_ci" | mysql
echo "GRANT ALL ON osqa.* to 'osqa'@'localhost'" | mysql

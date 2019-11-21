
rm -rf /var/lib/mysql
mkdir /var/mysql
ln -sf /var/mysql /var/lib/mysql

yum -y install vim rsync screen mariadb-server httpd php php-mysql php-xml php-gd php-imap php-ldapphp-mbstring php-odbc php-pdo php-soap unzip

systemctl enable httpd mariadb
systemctl start httpd mariadb



# Provision database
echo "DELETE PRE-EXISTING wikidb-new DATABASE"
mysql -u root -e 'DROP DATABASE IF EXISTS `wikidb-new`' # Escape with backticks to process hyphens

echo "CREATE BLANK wikidb-new DATABASE"
mysql -u root -e 'CREATE DATABASE `wikidb-new`' # Escape with backticks to process hyphens
mysql -u root -e "GRANT ALL PRIVILEGES ON wikidb_new.* TO 'wikiuser'@'localhost' IDENTIFIED BY 'Carr0t'; FLUSH PRIVILEGES;"

echo "SET BUFFERS FOR 'BIG FILES'"
mysql -u root -e 'set global net_buffer_length=1000000; set global max_allowed_packet=1000000000; SET foreign_key_checks = 0;'
echo "CHECK DATES AND SIZES OF YSL DIRECTORY."
ls -l /var/lib/

echo "IMPORT MAIN SQL FILE /var/www/html/BACKUP/15.05.2019/wiki.sql"

mysql -u root -e 'source /var/www/html/BACKUP/15.05.2019/wiki.sql;'
echo "(re)SET foreign_key_checksm = 1;"
mysql -u root -e 'SET foreign_key_checks = 1;'

echo "IMPORT WEB CONTENT TO /var/www/html/wiki"

# Backup web content zipped up in /var/www/html/BACKUP/mediawiki-1.25.1.zip
umount /var/www/html/wiki  2>/dev/null
mount /var/www/html/wiki && \
cd /var/www/html/wiki && \
rm -rf mediawiki-1.25.1 && \
unzip -n /var/www/html/BACKUP/mediawiki-1.25.1.zip && \ 
mv mediawiki-1.25.1/* .
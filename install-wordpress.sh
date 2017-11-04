#!/bin/bash
set -e
set -x

# For installing wordpress. Needs to be run with the env script.
 

WORDPRESS_PACKAGE=wordpress-4.8.1.tar.gz

TMP_DIR=/tmp

cd $TMP_DIR
wget https://wordpress.org/$WORDPRESS_PACKAGE

cd $WEB_ROOT

if [ `ls -1 . | wc -l` -gt 0 ]; then
	echo "Files already exist in $WEB_ROOT. Still proceed? (Y if yes)"
	read CONFIRM
	if [ ! "$CONFIRM" = "Y" ]; then
		exit 0
	fi
fi

tar xf $TMP_DIR/$WORDPRESS_PACKAGE

# put the wordpress files on the web root level, not as subdir
mv wordpress/* .
rmdir wordpress

cp wp-config-sample.php wp-config.php

# configure database datails
sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
sed -i "/DB_CHARSET/s/localhost/my-mysql/g" wp-config.php
sed -i "/DB_CHARSET/s/utf8/utf8mb4/g" wp-config.php

# get the line where the salt def placeholders start
SALT_LINE=`grep -n 'put your unique phrase here' wp-config.php | head -n1 | cut -d':' -f1`
# generate the salts using the api per wordpress documentation, save output to file
curl https://api.wordpress.org/secret-key/1.1/salt/ > salt_defs.txt
# insert to the appropriate line in config file
sed -i "${SALT_LINE}r salt_defs.txt" wp-config.php
# delete the placeholder lines
sed -i "/put your unique phrase here/d" wp-config.php

# add some custom settings
echo "/* custom */" >> wp-config.php
echo "define('WP_POST_REVISIONS', 2);" >> wp-config.php
echo "define('FS_METHOD', 'direct');" >> wp-config.php
echo "define('FORCE_SSL_ADMIN', true);" >> wp-config.php 


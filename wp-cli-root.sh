#!/bin/bash

source /config.sh
source /config/run_config.sh

if [[ $ADMIN_USERNAME == $DEFAULT_VALUE || $ADMIN_PASSWORD == $DEFAULT_VALUE || $ADMIN_EMAIL == $DEFAULT_VALUE || $SITE_TITLE == $DEFAULT_VALUE ]]; then
  echo -e "${txtred}The config is still set to the defaults.${txtrst}"
  echo -e "${txtred}Did you forget to change them in config/run_config.sh?${txtrst}"
  exit 1;
fi

reset_permissions $WP_PATH

# Run the database install before using wp-cli
# Copied from https://github.com/tutumcloud/tutum-docker-lamp/blob/master/run.sh
VOLUME_HOME="/var/lib/mysql"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"
    /create_mysql_admin_user.sh
else
    echo "=> Using an existing volume of MySQL"
fi

# Start MySQL for wp-cli
# Copied from https://github.com/tutumcloud/tutum-docker-wordpress/blob/master/create_mysql_admin_user.sh
/usr/bin/mysqld_safe > /dev/null 2>&1 &
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

su -s /bin/bash www-data -c /wp-cli.sh
mysqladmin -uroot shutdown

source /run.sh
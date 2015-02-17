#!/bin/bash

source /config.sh
source /config/run_config.sh

cd /app

if [[ ! -f $WP_PATH$TOUCHED ]]; then
  wp core install --url="$SITE_URL" --title="$SITE_TITLE" --admin_user="$ADMIN_USERNAME" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL"
  touch $WP_PATH$TOUCHED
fi

if [[ ! -f $UPLOADS_DIR$TOUCHED ]]; then

  touch $UPLOADS_DIR$TOUCHED
fi

if [[ ! -f $PLUGINS_DIR$TOUCHED ]]; then

  touch $PLUGINS_DIR$TOUCHED
fi

if [[ ! -f $THEMES_DIR$TOUCHED ]]; then
  wp theme install $DEFAULT_THEME --activate
  touch $THEMES_DIR$TOUCHED
fi

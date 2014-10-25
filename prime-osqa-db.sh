#!/bin/bash
echo "Starting system processes..."
/usr/bin/supervisord
sleep 1m
echo "Prime OSQA Database..."
cd /home/osqa/bash
echo "no" | python manage.py syncdb --all
python manage.py migrate forum --fake
echo "Restarting Web Server..."
/etc/init.d/apache2 restart


#!/bin/bash

if [[ ! -f "/etc/nginx/certs/.htpasswd" ]]; then
    htpasswd -b -c /etc/nginx/certs/.htpasswd $BASIC_AUTH_USERNAME $BASIC_AUTH_PASSWORD
fi

/scripts/wait-for-it.sh app:3000 --timeout=300 -- echo 'App service is ready!'

nginx -g 'daemon off;'

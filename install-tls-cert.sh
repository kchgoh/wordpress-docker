#!/bin/bash

docker run --rm \	
	-it --name certbot \
	-v /etc/letsencrypt:/etc/letsencrypt \
	-v ${WEB_ROOT}:/var/www \		
	certbot/certbot:v0.18.1 \		
	certonly \
	--agree-tos \
	--non-interactive \
	--webroot --webroot-path /var/www \		
	-d ${DOMAIN} -d www.${DOMAIN} \
	-m ${EMAIL}


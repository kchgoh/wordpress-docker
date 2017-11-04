FROM debian:stretch-slim

RUN apt-get update && \
    apt-get install -y php7.0-fpm php7.0-curl php7.0-exif php7.0-mysql php-imagick --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /run/php

RUN sed -i "s/;*daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i "s/;*error_log\s*=\s*.*/error_log = \/proc\/self\/fd\/2/g" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i "s/;*listen\s*=\s*.*/listen = 9000/g" /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i "s/;*access.log\s*=\s*.*/access.log = \/proc\/self\/fd\/2/g" /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i "s/;*catch_workers_output\s*=\s*.*/catch_workers_output = yes/g" /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i "s/;*cgi.fix_pathinfo\s*=\s*.*/cgi.fix_pathinfo = 0/g" /etc/php/7.0/fpm/php.ini

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.0"]

export WEB_ROOT=/home/foo/var/www
export DB_ROOT=/home/foo/var/db
export DOMAIN=mydomain.com
export EMAIL=admin@mydomain.com

# for docker compose these are used for initial db creation only.
# after db is created, if any change then need to change in the db itself.

export MYSQL_ROOT_PASSWORD=rootpass
export MYSQL_DATABASE=wordpress
export MYSQL_USER=user
export MYSQL_PASSWORD=userpass

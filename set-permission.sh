#!/bin/bash
set -e

SCRIPT=`basename $0`

print_usage() {
	echo "Usage: $SCRIPT {command}"
	echo "This should be run from WordPress root directory."
	echo "Available commands:"
	echo "    init - For initial setup, set all permission"
	echo "    upgrade - Set relaxed permission for upgrade only"
	echo "    revert - Revert back to original permission after 'upgrade'"
}

set_base_perm() {
	sudo chown -R www-data ./*
	sudo chgrp -R www-data ./*
}

set_controlled_perm() {
	sudo find . \! -path '*wp-content*' | sudo xargs chown `whoami`
	sudo find . -type d \! -path '*wp-content*' | sudo xargs chmod 750
	sudo find . -type f \! -path '*wp-content*' | sudo xargs chmod 640
}

set_relaxed_perm() {
	sudo chown -R www-data ./*
}

if [ "$WEB_ROOT" = "" ]; then
	echo '$WEB_ROOT must be defined'
	exit 1
fi

if [ $# -ne 1 ]; then
	print_usage
	exit 1
fi

cd $WEB_ROOT

for ARG in $@; do
	case $ARG in
		$0) ;;
		init) set_base_perm ; set_controlled_perm ;;
		upgrade) set_relaxed_perm ;;
		revert) set_controlled_perm ;;
		*) print_usage ; exit 1 ;;
	esac
done


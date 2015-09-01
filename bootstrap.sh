#!/bin/bash

export basedir=$(cd $(dirname "$0") && pwd)
export last_bootstrap_file="${basedir}/.last-bootstrap"

source $basedir/mylog.sh
source $basedir/install_functions.sh

# Basic information and setup
pheader 'Checking the essentials...'

piinfo "Operating System: "
echo $OS_NAME

piinfo 'Checking for previous bootstrap: '
if [[ -f $last_bootstrap_file ]]; then
	last_update_time=$(cat $last_bootstrap_file)
	pinfo $(timestamp2pretty $last_update_time)
else
	pinfo 'none found'
fi

piinfo 'Checking this repo: '
if $(require_clean_directory upgrade); then
	pinfo 'ready to bootstrap'
else
	pwarn 'Please clean up directory (e.g. `git checkout -- .`) and try again'
	exit 2
fi

# Get latest version of files
pheader 'Checking for file updates...'

git fetch --progress
new_updates_available=`git diff HEAD FETCH_HEAD`
if [ "$new_updates_available" != "" ]; then
	pinfo 'Updating to latest version...'

	git checkout -- .
	git pull --progress || exit 3
fi

# date +%s > last_update_file

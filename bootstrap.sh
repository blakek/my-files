#!/bin/bash

export basedir=$(cd $(dirname "$0") && pwd)

source $basedir/mylog.sh
source $basedir/install_functions.sh

pheader 'Checking the essentials...'
piinfo "Operating System: "
echo $OS_NAME

piinfo 'Node.js: '
is_installed node nodejs || install_node

piinfo 'npm: '
is_installed npm || install_npm

piinfo 'A fake test program: '
is_installed fake fake2 || install_fake

if $(is_clean_directory upgrade); then
	piinfo 'Ready to update'
else
	pwarn 'Please clean up directory'
fi

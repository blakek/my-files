# Return a mostly-friendly operating system name
get_os() {
	case $OSTYPE in
		darwin*) echo 'OS X';;
		linux*) echo 'Linux';;
		cygwin*) echo 'Cygwin';;
		msys*) echo 'MinGW';;
		freebsd*) echo 'FreeBSD';;
		*) echo 'unknown';;
	esac
}

# Checks to see if a program can be found in the PATH
is_installed() {
	type -p "$@" 2> /dev/null && return 0 || {
		type_list=$(echo "$@" | sed 's/ /, /g')
		pwarn "$type_list not found" && return 1
	}
}

# Installs Homebrew for OS X
install_brew() {
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew doctor
}

# Install Node.js
install_node() {
	perror 'Not yet implemented'
}

# Remove me when done testing
install_fake() {
	if [[ $OS_NAME == 'OS X' ]]; then
		echo 'Installing fake for OS X...'
	elif [[ $OS_NAME == 'Linux' ]]; then
		echo 'Installing fake for Linux...'
	else
		perror 'Failed to install fake: Unknown OS' && exit 1
	fi
}

OS_NAME=$(get_os)

# Return a mostly-friendly operating system name
get_os() {
	case $OSTYPE in
		darwin*) echo 'OS X';;
		linux*) echo 'Linux';;
		cygwin*) echo 'Cygwin';;
		msys*) echo 'MinGW';;
		*bsd*) echo 'BSD-based';;
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

timestamp2pretty() {
	if [[ $OS_NAME == 'OS X' || $OS_NAME == 'BSD-based' ]]; then
		echo $(date -r $1)
	else
		echo $(date -d @$1)
	fi
}

# Ensure there are no uncommitted/unstaged changes in a git repo before working on it
require_clean_directory() {
	# Update the index
	git update-index -q --ignore-submodules --refresh
	err=0

	# Disallow unstaged changes in the working tree
	if ! $(git diff-files --quiet --ignore-submodules --); then
		perror >&2 "cannot $1: you have unstaged changes"
		git diff-files --name-status -r --ignore-submodules -- >&2
		err=1
	fi

	# Disallow uncommitted changes in the index
	if ! $(git diff-index --cached --quiet HEAD --ignore-submodules --); then
		perror >&2 "cannot $1: your index contains uncommitted changes"
		git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
		err=1
	fi

	if [ $err = 1 ]; then
		perror >&2 'Please commit or stash them'
		exit 1
	fi
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

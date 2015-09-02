# Reset
reset='\e[0m'

# Colors
white='\e[1;37m'
black='\e[0;30m'
blue='\e[0;34m'
light_blue='\e[1;34m'
green='\e[0;32m'
light_green='\e[1;32m'
cyan='\e[0;36m'
light_cyan='\e[1;36m'
red='\e[0;31m'
light_red='\e[1;31m'
purple='\e[0;35m'
light_purple='\e[1;35m'
brown='\e[0;33m'
yellow='\e[1;33m'
gray='\e[0;30m'
light_gray='\e[0;37m'

# Formats
bold='\e[1m'
italic='\e[3m'
underline='\e[4m'
strikethrough='\e[9m'

pheader() {
	printf "\n$underline$@$reset\n"
}

pokay() {
	printf "$green$@$reset\n"
}

pinfo() {
	printf "$blue$@$reset\n"
}

pwarn() {
	printf "$yellow$@$reset\n"
}

perror() {
	printf "$red$@$reset\n"
}

piheader() {
	printf "$underline$@$reset"
}

piokay() {
	printf "$green$@$reset"
}

piinfo() {
	printf "$blue$@$reset"
}

piwarn() {
	printf "$yellow$@$reset"
}

pierror() {
	printf "$red$@$reset"
}

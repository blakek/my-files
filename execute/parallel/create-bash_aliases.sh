fileName="$HOME/.bash_aliases"
source $libdir/mylog.sh
source $basedir/install_functions.sh

pinfo 'Creating .bash_aliases'

if [ -f $fileName ]; then
	mv $fileName ${fileName}.backup
fi

cat <<-EOF > $fileName
	# Reasonable defaults
	alias ll='ls -lhFS'
	alias la='ls -A'
	alias l='ls -CF'
EOF

is_installed poweroff > /dev/null || {
	cat <<-EOF >> $fileName
		alias poweroff='sudo shutdown -h now'
		alias reboot='sudo reboot'

	EOF
}

echo '# Add colors to common programs' >> $fileName
cat <<-EOF >> $fileName
	alias grep='grep --colour=auto'
	alias fgrep='fgrep --colour=auto'
	alias egrep='egrep --colour=auto'

EOF

echo '# Setup shortcuts to executables in non-standard places' >> $fileName
if [ -x '/Applications/FirefoxDeveloperEdition.app/Contents/MacOS/firefox' ]; then
	echo "alias firefox='/Applications/FirefoxDeveloperEdition.app/Contents/MacOS/firefox'" >> $fileName
fi

if [ -x '/Applications/ImageOptim.app/Contents/MacOS/ImageOptim' ]; then
	echo "alias imageoptim='/Applications/ImageOptim.app/Contents/MacOS/ImageOptim'" >> $fileName
fi

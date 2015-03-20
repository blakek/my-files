# Add my personal programs to PATH
export PATH=~/bin:$PATH

# Don't remember commands if space was entered before them.
# Also, don't remember duplicate commands
export HISTCONTROL=ignoreboth

# My prompt
#PS1="\$? \u@\h \[\e[01;34m\]\W \[\e[0;32m\]\$\[\e[00m\] "
#PS1='\[\e[;36m\][\u@\h \[\e[;37m\]\W\[\e[;36m\]]\$ \[\e[0m\]'
# Without __git_ps1:
#PS1='$(ret=$? && if [ $ret -gt 0 ]; then echo "\[\e[01;31m\][$ret] "; fi)\[\e[0;32m\]\u@\h \[\e[0;34m\]\W\n\[\e[0;32m\]\$\[\e[00m\] '
#PS1='$(ret=$? && if [ $ret -gt 0 ]; then echo "\[\e[01;31m\][$ret] "; fi)\[\e[0;32m\]\u@\h \[\e[0;34m\]\W \[\e[;35m\]$(__git_ps1)\n\[\e[0;32m\]\$\[\e[00m\] '
PS1='\[\e[;36m\][\u@\h \[\e[;37m\]\W\[\e[;36m\]\[\e[;35m\]$(__git_ps1)\[\e[;36m\]]\$ \[\e[0m\]'

# Enable colors in Mac terminal
export CLICOLOR=1

# Import .bash_aliases file if it exists
if [ -f $HOME/.bash_aliases ]; then
	. $HOME/.bash_aliases
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# npm bash completion
#if [ -f $(brew --prefix)/etc/bash_completion.d/npm ]; then
#	. $(brew --prefix)/etc/bash_completion.d/npm
#fi
if [ -f /usr/local/lib/node_modules/npm/lib/utils/completion.sh ]; then
	. /usr/local/lib/node_modules/npm/lib/utils/completion.sh
fi

# git bash completion
if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi

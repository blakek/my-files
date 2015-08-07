#!/bin/bash

set -e

temp=$(mktemp -t 'times.XXXXXXX')
orig="$HOME/Desktop/times.txt"

node "$HOME/bin/dept-finder.js" --file "$orig" > "$temp"

mv "$temp" "$orig"

set +e
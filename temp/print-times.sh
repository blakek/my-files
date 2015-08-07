#/bin/bash

time_file="$HOME/Desktop/times.txt"
awk_file="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/time.awk"

awk -f $awk_file $time_file
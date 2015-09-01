#!/bin/bash

date1=$(date -jf '%H:%M' +'%s' $1)
date2=$(date -jf '%H:%M' +'%s' $2)
diff=$(($date2-$date1))

hours=$(bc <<< "$diff / 3600")
mins=$(bc <<< "($diff / 60) - 60 * $hours")

#echo "$hours hours  $mins mins"
#echo "$hours:$mins"
printf "%d:%2.2d" $hours $mins
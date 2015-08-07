#!/bin/bash

parent_process="$(ps -o comm= $PPID)"

NetID='cbk117'

if [[ "$parent_process" == "/sbin/launchd" ]]; then
	NetPassword="$(osascript -e 'Tell application "System Events" to display dialog "Password for '$NetID':" with title "Password for '$NetID'" default answer "" with hidden answer' -e 'text returned of result' 2>/dev/null)"
else
	read -sp "Password for $NetID:" NetPassword
fi

# put all of your drives here
drives=(
	"VZ2|itswebdev02.its.msstate.edu|/mountpoints|$NetID|$NetPassword"
	"VZ5|itswebdev05.its.msstate.edu|/mountpoints|$NetID|$NetPassword"
	"VZ6|itswebdev06.its.msstate.edu|/mountpoints|$NetID|$NetPassword"
	# "VZ1|itswebdev01.its.msstate.edu|/mountpoints|$NetID|$NetPassword"
	# "VZ3|itswebdev03.its.msstate.edu|/mountpoints|$NetID|$NetPassword"
	# "VZ4|itswebdev04.its.msstate.edu|/mountpoints|$NetID|$NetPassword"
	# "NetID-drupal|NetID-drupal.its.msstate.edu|/var/www|NetID|NetPassword"
	# "aegir|aegir.its.msstate.edu|/|aegir|aegir"
	# "drupal-devel|drupal-devel.its.msstate.edu|/|aegir|aegir"
	# "fig|fig.its.msstate.edu|/data/www|NetID|NetPassword"
)

# don't modify below here
mountDrive() {
	# splice the string
	OIFS=$IFS
	IFS='|'

	info=()
	count=0

	for item in $1
	do
		info[$count]=$item
		count=$count+1
	done

	IFS=$OIFS

	# try and force an unmount to be sure everything is ready
	diskutil unmount force /Volumes/${info[0]}
	# create the directory
	mkdir /Volumes/${info[0]}

	# run expect command and receive the below as input
	/usr/bin/expect <<-EOF
		log_user 0

		# spawn shell to send commands
		spawn /bin/bash

		# after it has opened send the sshfs command
		expect "\$"
		send_user "Attempting to mount ${info[3]}@${info[1]}:${info[2]}\n"
		send -- "sshfs ${info[3]}@${info[1]}:${info[2]} /Volumes/${info[0]} -odefer_permissions,noappledouble,volname=${info[0]},workaround=rename,hard_remove,auto_cache,follow_symlinks,nolocalcaches\r"

		expect {
			timeout {
				send_user "\nFailed to get password prompt\n\n";
				exit 1
			}
			eof {
				send_user "\nSSHFS failure for ${info[1]}\n\n";
				exit 1
			}
			"The authenticity of host" {
				send "yes\r"
				expect {
					"*assword" {
						send "${info[4]}\r"
					}
				}
			}
			"*assword" {
				send "${info[4]}\r"
			}
		}

		expect {
			timeout {
				send_user "\nLogin failed. Password incorrect.\n\n";
				exit 1
			}
			"*\$ " {
				send_user "Password is correct\n\n"
			}
		}
	EOF

	# sometimes the file check below runs too soon
	sleep .1

	# see how many things are in the folder
	folders=$(ls /Volumes/${info[0]} | wc -l)
	# if it is empty and we haven't already retried 5 times
	if [[ $folders -eq 0 ]] && [[ $totalAttempts -lt 5 ]]; then
		totalAttempts=$(($totalAttempts+1))

		echo "/Volumes/${info[0]} is empty. Assuming mount failed. Will try again in $totalAttempts seconds"
		sleep $totalAttempts
		# wait 5 seconds and then try again
		mountDrive $1
	fi
}

# loop through all of the drives and try to mount them
for item in ${drives[*]}
do
	totalAttempts=0
	mountDrive $item
done

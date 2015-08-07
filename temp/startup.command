#!/bin/bash

# Start firefox at magic.its.msstate.edu (I don't want that to be the home page, though.)
/Applications/Firefox\ 36.app/Contents/MacOS/firefox 'https://magic.its.msstate.edu/sde/' &

# Mount the VZ servers
/Users/cbk117/bin/mountNetworkDrives.sh &

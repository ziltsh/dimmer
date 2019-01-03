#! /bin/bash
#
# dimmer.sh
#

set -u
THIS="$(basename $0)"

CFG_FILE=~/.dimmerrc
brightness=1.0
gamma=1.0:1.0:1.0


function GetActiveMonitors () {
	xrandr --listactivemonitors \
		| awk '/^ /{print $2}' \
		| tr -d '*+'
	return $?
}

function Log () {
	local msg="$@"
	local tag="$THIS"
	local pri='notice'
	logger -t $tag -p $pri "$msg"
}

# main

# load settings from file
[ -r $CFG_FILE ] && . $CFG_FILE

Log "setting brightness to $brightness and gamma to $gamma"

# loop active monitors
for M in $(GetActiveMonitors); do
	xrandr --output $M --gamma $gamma --brightness $brightness
done

#.
